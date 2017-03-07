% Spectral Clustering Script
function [clusterIDX, centroids, sumd] = spectralClustering(data, numClusters, numConnection)

[height, width] = size(data);

[knnIDX, distMatrix] = knnsearch(data, data, 'K', numConnection);

lapMatrix = zeros(height, height);


for i = 1:height

    for j = 1:numConnection

        row = i;
        column = knnIDX(i, j);

        if (row == column)
          lapMatrix(row, column) = sum(distMatrix(i, :));

        else
          lapMatrix(row, column) = -distMatrix(i, j);
          lapMatrix(column, row) = -distMatrix(i, j);
        end
    end
end


% [eigVec, eigVal] = eig(lapMatrix);
[eigVec, eigVal] = eigs(lapMatrix, numClusters, 'lm');
%%
eigVal = sort(eigVal);

eigValO = eigVal(end, :);
% eigVal = sort(eigVal);
% test = linspace(1, length(eigVal), length(eigVal));

% figure('Name', 'Eigenvalue Spectrum');
% plot(test, eigVal)
% hold off;

[clusterIDX, centroids, sumd] = kmeans(eigVec, numClusters);
plot(eigValO);
% [clusterIDX, ~] = kmeans(centroids, 3);

% s = silhouette(data, clusterIDX );

% mean(s)


end