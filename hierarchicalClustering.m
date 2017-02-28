% run preprocessor.m before running this script
% eg command window entry: hierarchicalClustering(normDataMat(:,ind(end-20:end)),4)

function [clusterIDX, reclusterIDX] = hierarchicalClustering(data, numClusters)

load Coords
[height, ~] = size(data);

%% Options
cutoff = numClusters; % choose cutoff threshold for where to cut the hierarchical tree
% choose linkage from:
% 'average', 'centroid', 'complete', 'median', 'single', 'ward', 'weighted'
% complete seems to be best
linkageType = 'complete'; 
% choose the top n most important features found from pca
% n = 20;

%% Hierarchical clustering
%index = ind; % need this line as matlab gets confused otherwise
clusterIDX = clusterdata(data,'maxclust',cutoff,'linkage', linkageType);
% run hierarchical clustering again to get only 2 clusters (city/noncity hopefully)
cutoff2 = 2;
reclusterIDX = clusterdata(clusterIDX,'maxclust',cutoff2,'linkage', linkageType);
Class = zeros(height,1);
for i = 1:height
    Class(i) = reclusterIDX(clusterIDX(i));
end

%% Plot silhouette to show how crap our clusters are
figure();
silhouette(data,reclusterIDX);

%% Plot map
figure();
for i = 1:height
    a = Coords{i}(:,1);
    b = Coords{i}(:,2);
    if Class(i) == 1
        patch(a,b,[0.66 0.66 0.66])
        hold on
    elseif Class(i) == 2
        patch(a,b,[1 1 1])
        hold on
    end
end
hold off;

end