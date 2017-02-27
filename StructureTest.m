%% New code, compare neighbouring areas
function Structure = StructureTest(Class, Coords, ConnectionMat)

numPoints = length(Coords);

Dist = zeros(numPoints,1);
Midpoint = zeros(numPoints,2);
for i = 1:numPoints
    Midpoint(i,:) = findCentroid(Coords{i});
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
