% Spectral Clustering Script
[height, width] = size(score(:, 1:150))

numConnection = 50;
[knnIDX, distMatrix] = knnsearch(score(:, 1:150), score(:, 1:150), 'K', numConnection);

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
[eigVec, eigVal] = eigs(lapMatrix, 200, eps);
%%
eigVal = sort(eigVal);

eigVal = eigVal(end, :);
eigVal = sort(eigVal);
test = linspace(1, length(eigVal), length(eigVal));

figure('Name', 'Eigenvalue Spectrum');
plot(test, eigVal)
hold off;

numClusters = 10;
[clusterIDX, centroids] = kmeans(eigVec, numClusters);
[clusterIDX, ~] = kmeans(centroids, 3);
s = silhouette(score(:, 1:10), clusterIDX );

mean(s)


