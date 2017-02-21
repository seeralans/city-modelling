% run preprocessor.m before running this script

load Coords
load CoordsCityCouncil

% choose cutoff threshold for cutting the hierarchical tree
cutoff = 3;
% choose linkage from:
% 'average', 'centroid', 'complete', 'median', 'single', 'ward', 'weighted'
linkageType = 'centroid'; 
T = clusterdata(score(:,[1 2 3 4 5 6 7 8 9]),'maxclust',cutoff,'linkage', linkageType);
%find(T==1) 

for i = 1:length(score)
    a = Coords{i}(:,1);
    b = Coords{i}(:,2);
    if T(i) == 1
        col = 1;
    elseif T(i) == 2
        col = 0.5;
    else 
        col = 0;
    end
    patch(a,b,[T(i)/cutoff 1 T(i)/cutoff])
    hold on
end