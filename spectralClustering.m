% Spectral Clustering Script
[height, width] = size(score(:, 1:5))

numConnection = 200;
[knnIDX, distMatrix] = knnsearch(score(:, 1:5), score(:, 1:5), 'K', numConnection);

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


[eigVec, eigVal] = eig(lapMatrix);
%%
eigVal = sort(eigVal);

eigVal = eigVal(end, :);
eigVal = sort(eigVal);
test = linspace(1, length(eigVal), length(eigVal));

figure('Name', 'Eigenvalue Spectrum');
plot(test, eigVal)
hold off;