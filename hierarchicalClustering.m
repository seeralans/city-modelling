% run preprocessor.m before running this script
% run with [clusterIDX, Class, Structure] = hierarchicalClustering(score(:,1:150),6)

function [clusterIDX, Class, Structure] = hierarchicalClustering(data, numClusters)

load Coords
load ConnectionMat
[height, ~] = size(data);

%% Options
% choose linkage from:
% 'average', 'centroid', 'complete', 'median', 'single', 'ward', 'weighted'
% complete seems to be best
linkageType = 'complete'; 

%% Hierarchical clustering
clusterIDX = clusterdata(data,'maxclust',numClusters,'linkage', linkageType);

Class = zeros(height,1);
for i = 1:height
    Class(i) = clusterIDX(i);
end

%% Plot silhouette to show how crap our clusters are
figure();
silhouette(data,clusterIDX);

%% Plot map
FigHandle = figure('Position', [100, 100, 800, 600],'Name','Map - Hierarchical');
set(gca,'fontsize',10)
xlabel('latitude')
ylabel('longnitude')
title('Using PCA and Hierarchical clustering to cluster output areas')

for i = 1:height
    a = Coords{i}(:,1);
    b = Coords{i}(:,2);
    j = Class(i)/numClusters;
    col = [abs(1-j) abs(1-j) abs(1-j)];
    patch(a,b,col)
    hold on
end
hold off;

Structure = StructureTest(Class, Coords, ConnectionMat)
end