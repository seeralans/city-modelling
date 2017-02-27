%% New code, compare neighbouring areas
function Structure = StructureTest(Class, Coords)

numPoints = length(Coords);

Dist = zeros(numPoints,1);
Midpoint = zeros(numPoints,2);
for i = 1:numPoints
    Midpoint(i,:) = findCentroid(Coords{i});
end
ConnectionMat = zeros(numPoints,numPoints);
DistMat = zeros(numPoints,numPoints);
for i = 1:numPoints
    for j = i:numPoints
        DistMat(i,j) = norm(Midpoint(i, :) - Midpoint(j, :));
        DistMat(j,i) = DistMat(i,j);
    end
end

[ SortDistMat, DistIndex] = sort(DistMat);
for i = 1:numPoints
    x = 0;
    for j = 1:20
        x = isempty(intersect(Coords{i}, Coords{DistIndex(j, i)}));
        ConnectionMat(i,DistIndex(j,i)) = 1 - x;
    end
end


NearClass = zeros(numPoints,1);
for i = 1:numPoints
    v = find(ConnectionMat(:,i));
    if (sum(Class(v))/length(Class(v))) >= 0.5
        NearClass(i) = 1;
    else
        NearClass(i) = 0;
    end
end

Structure = sum(NearClass)/length(Class)
return
