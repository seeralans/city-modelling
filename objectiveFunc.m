function value = objectiveFunc(numClusters, data, numConnection) 
numClusters = ceil(numClusters);
% only use one of the methods.

% [clusterIDX, clusterCentroids] = spectralClustering(data, numClusters, numConnection)
[clusterIDX, clusterCentroids] = kmeans(data, numClusters);

% i will change this when the structure code supports more clusters

% value = StructureTest(clusterIDX, Coords, ConnectionMat)


value = mean(silhouette(data, clusterIDX));

end