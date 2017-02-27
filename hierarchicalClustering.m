% run preprocessor.m before running this script

load Coords
load CoordsCityCouncil

%% Options
% choose cutoff threshold for cutting the hierarchical tree
cutoff = 3;
% choose linkage from:
% 'average', 'centroid', 'complete', 'median', 'single', 'ward', 'weighted'
% complete seems to be best
linkageType = 'complete'; 
% choose the top n most important features found from pca
n = 20;
index = ind;

%% Hierarchical clustering
T = clusterdata(normDataMat(:,index(end-n:end)),'maxclust',cutoff,'linkage', linkageType);

%% Plot silhouette to show how crap our clusters are
figure();
silhouette(normDataMat(:,index(end-n:end)),T);

%% Plot map
figure();
Class = zeros(height,1);
for i = 1:height

    if T(i) == 1
        Class(i) = 0; %City
    elseif T(i) == 2 || T(i) == 3
        Class(i) = 1; % Not city
    end
end

for i = 1:height

    a = Coords{i}(:,1);
    b = Coords{i}(:,2);
    if Class(i) == 0
        col = [0.66 0.66 0.66];
    elseif Class(i) == 1
        col = [1 1 1];
    end
    
    patch(a,b,col)
    hold on
end
hold off;

