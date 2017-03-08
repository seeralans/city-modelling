% elbow method for determining optimal num clusters for hierarchical 
% COMMENT OUT ALL FIGURE PLOTS IN hierarchicalClustering.m before running
% this script

numberClusters = 10;
means = zeros(numberClusters-1,1);
wss = zeros(numberClusters-1,1);
for i = 2:numberClusters % for i clusters
    [clusterIDX, Class, meanSil] = hierarchicalClustering(score(:,1:150),i);
    means(i-1) = meanSil;
    centroid = zeros(i,1);
    wssj = zeros(i,1);
    for j = 1:i % for j sets of points within a cluster
        indexes = find(Class == j);
        elementsInCluster = score(indexes,1:150);
        centroid(i) = mean(mean(elementsInCluster));
        wssk = zeros(size(elementsInCluster,1),1);
        for k = 1:size(elementsInCluster,1) % for k points in cluster
            wssk(k) = sum((elementsInCluster(k,:) - centroid(i)).^2); 
        end
        wssj(j) = sum(wssk);
    end
   wss(i-1) = sum(wssj);
end


%% plot av silhouette value vs number of clusters
figure();
y = linspace(2,numberClusters,numberClusters-1);
plot(y,means)
xlabel('Number of clusters')
ylabel('Average Silhouette Value')

%% plot wss against number of clusters
figure();
plot(y,wss)
xlabel('Number of clusters')
ylabel('Total within cluster sum of squares')