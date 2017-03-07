%% Improved structure calc
figure(1);
scatter(centroids(:,1), centroids(:,2));
hold on;

[numCentres, ~] = size(centroids);

centreDist = zeros(numCentres - 1, numCentres);

for i = 1:numCentres
    j = 1;
    for k = 1:numCentres
        if (i ~= k)
            centreDist(j, i) = norm(centroids(i,:) - centroids(k, :));
            j = j + 1;
        end
    end
end

centreDist = sort(centreDist);


theta = linspace(-pi, pi, 100);

x = 0.5 * centreDist(1, 1) * cos(theta) + centroids(1, 1);
y = 0.5 * centreDist(1, 1) * sin(theta) + centroids(1, 2);

plot(x, y); hold on;
%%

numPoints = length(Coords);

midpoints = zeros(numPoints,2);

for i = 1:numPoints
    midpoints(i,:) = findCentroid(Coords{i});
end

radiusVec = midpoints - centroids(1,:) .* ones(numPoints, 2);
radius = sqrt(sum(abs(radiusVec) .^ 2, 2));

vecAngles = atan2(radiusVec(:,1), radiusVec(:,2));
withinPointsIDX = radius <= centreDist(1, 1) / 2; %& radius > centreDist(1, 1) / 4;


%% find squared error for each sector

% ask liam to modify existing code

angle = pi / 2;
error = 0;
numSectors = 2 * pi / angle;
for i = 0:numSectors - 1
  startAngle = i * angle - pi;
  endAngle = startAngle + angle;
  sectorIDX = vecAngles < endAngle & vecAngles > startAngle;

  validIDX = withinPointsIDX & sectorIDX;



  scatter(midpoints(validIDX,1), midpoints(validIDX, 2), 'filled')

  modeClass = mode(class(validIDX));
  error = sum((class - modeClass) ~= 0) + error;

end


error / (numPoints ^ 2)


