%% New code, compare neighbouring areas
function Structure = StructureTest(Class, Coords)
Dist = zeros(3485,1);
Midpoint = zeros(3485,2);
for i = 1:3485   
    Midpoint(i,:) = findCentroid(Coords{i});
end
ConnectionMat = zeros(3485,3485);
DistMat = zeros(3485,3485);
for i = 1:3485
    for j = i:3485
        DistMat(i,j) = sqrt((Midpoint(i,1)-Midpoint(j,1))^2 + (Midpoint(i,2)-Midpoint(j,2))^2);
        DistMat(j,i) = DistMat(i,j);
    end   
end
[ SortDistMat, DistIndex] = sort(DistMat);
for i = 1:3485
    v = [ Coords{i}(:,1) Coords{i}(:,2)];
    x = 0;
    for j = 1:20
        u = [ Coords{DistIndex(j,i)}(:,1) Coords{DistIndex(j,i)}(:,2)];
        x = isempty(intersect(v,u));
        ConnectionMat(i,DistIndex(j,i)) = 1 - x;
    end
    v = [];
    u = [];
end
NearClass = zeros(3485,1);
for i = 1:3485
    v = find(ConnectionMat(:,i));
    if (sum(Class(v))/length(Class(v))) >= 0.5
        NearClass(i) = 1;
    else
        NearClass(i) = 0;
    end
end

Structure = sum(NearClass)/length(Class)
return





