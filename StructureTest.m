% New code, compare neighbouring areas
% Binary class input needs to be [0,1], multiclass can be any number.
function [Structure] = StructureTest(Class, Coords, ConnectionMat)

numPoints = length(Coords);

Dist = zeros(numPoints,1);
Midpoint = zeros(numPoints,2);
for i = 1:numPoints
    Midpoint(i,:) = findCentroid(Coords{i});
end

if length(unique(Class)) == 2
    NearClass = zeros(numPoints,1);
    for i = 1:numPoints
        v = find(ConnectionMat(:,i));
        NearClass(i) = (sum(Class(v))/length(v));
    end
    NearClass(isnan(NearClass)) = 0;
    Structure = sum(sum((NearClass - Class).^2))/length(Class); % Mean sqrd error
elseif length(unique(Class)) > 2
    NearClass = zeros(numPoints,length(unique(Class)));
    C = unique(Class);
    for j  = 1:length(C)
        for i = 1:numPoints
            v = find(ConnectionMat(:,i));
            NearClass(i,j) = sum(Class(v) == C(j))/length(v);
        end
    end
    Class2 = zeros(numPoints,length(unique(Class)));
    for i = 1:numPoints
        for j = 1:length(C)
            if Class(i) == C(j)
                Class2(i,j) = 1;
            end
        end
    end
    NearClass(isnan(NearClass)) = 0;
    Structure = sum(sum((NearClass - Class2).^2))/ length(Class); % Mean sqrd error
elseif length(unique(Class)) < 2
    disp('Class error - one class')
end

return