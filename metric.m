%%
load Coords.mat
load ConnectionMat.mat
mappingScript
class = clusterIDX;
%% Improved structure calc
%figure(1);
scatter(centroids(:,1), centroids(:,2), 70, 'o', 'm', 'filled');
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

plot(x, y, 'linewidth', 1.5); hold on;
%%

numPoints = length(Coords);

midpoints = zeros(numPoints,2);

for i = 1:numPoints
    midpoints(i,:) = findCentroid(Coords{i});
end

radiusVec = midpoints - centroids(1,:) .* ones(numPoints, 2);
radius = sqrt(sum(abs(radiusVec) .^ 2, 2));

vecAngles = atan2(radiusVec(:,1), radiusVec(:,2));
withinPointsIDX = radius <= centreDist(1, 1) / 2 & radius > centreDist(1, 1) / 18;


%% find squared error for each sector

% ask liam to modify existing code

error = 0;
numSectors = 8;
angle = 2 * pi / numSectors;

for i = 0:numSectors - 1
    startAngle = i * angle - pi;
    endAngle = startAngle + angle;
    
    
    
    sectorIDX = vecAngles < endAngle & vecAngles > startAngle;
    
    validIDX = withinPointsIDX & sectorIDX;
    
    
    
    scatter(midpoints(validIDX,1), midpoints(validIDX, 2),8 ,'filled')
    hold on;
    modeClass = mode(class(validIDX));
    error = sum((class - modeClass) ~= 0) + error;
    
end


error / (numPoints ^ 2)

%% Calculate Metric
numSectors = 4;
mScore = 999999;
numnum = zeros(10, 1);
metrics = zeros(10,1);
for k = 1:10
numSectors = k;
sectorAngle = 2 * pi / numSectors;
shiftCount = 2;
angleShift = sectorAngle / shiftCount;

errors = zeros(shiftCount, 1);
minError = 0;
for j = 1:shifCount
    
    prevError = 99999;
    currError = 9999;
    
    error = 0;
    
    for i = 0:numSectors - 1
        
        startAngle = i * angle - pi + (j - 1) * angleShift;
        endAngle = startAngle + angle;
        
        if (startAngle > pi | endAngle > pi)
            startAngle = startAngle - 2 * pi;
            endAngle = startAngle - 2 * pi;
            
        elseif (startAngle < -pi | endAngle < -pi)
            
            startAngle = startAngle + 2 * pi;
            endAngle = startAngle + 2 * pi;
        end
        
        
        sectorIDX = vecAngles < endAngle & vecAngles > startAngle;
        validIDX = withinPointsIDX & sectorIDX;
        
        modeClass = mode(class(validIDX));
%         figure;
%         scatter(midpoints(validIDX,1), midpoints(validIDX, 2),8 ,'filled')
%         hold off;
        
        total = sum(validIDX);
        if (total ~= 0)
            error = sum((class(validIDX) - modeClass) ~= 0) / sum(validIDX) + error;
        else
            error = 0;
        end
        
    end
    
    errors(j) = error / numSectors;
%     if (j > 1 & (errors(j) >= errors(j - 1)))
%         minError = errors(j - 1);)
%         break;
%     end
end
minError = min(errors(errors > 0));
[w, ~] = size(minError);
if (w == 0)
    minError = 0;
end
metricScore = minError^(-2) * numSectors ^ (0.1);
numnum(k) = k;

metrics(k) = metricScore
end
figure;
plot(numnum, metrics);
xlabel('Number of sectors used')
ylabel('Metric score')