function value = objectiveFunc(numClusters, data, numConnection) 

% only use one of the methods.
% [clusterIDX, clusterCentroids] = spectralClustering(data, numClusters, numConnection)

[clusterIDX, clusterCentroids] = kmeans(data, numClusters);

% i will change this when the structure code supports more clusters
s = silhouette(data, clusterIDX );

value = 1 - mean(s)
numClusters


end