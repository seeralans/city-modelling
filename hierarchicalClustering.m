% run preprocessor.m before running this script

load Coords
load CoordsCityCouncil

%% Options
% choose cutoff threshold for cutting the hierarchical tree
cutoff = 2;
% choose linkage from:
% 'average', 'centroid', 'complete', 'median', 'single', 'ward', 'weighted'
% complete seems to be best
linkageType = 'complete'; 
% choose the top n most important features found from pca
n = 20;
index = ind;

%% Hierarchical clustering
T = clusterdata(normDataMat(:,index(end-n:end)),'maxclust',cutoff,'linkage', linkageType);
% silhouette to show how crap our clusters are
figure();
silhouette(normDataMat(:,index(end-n:end)),T);
%% Plot map
figure();
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
