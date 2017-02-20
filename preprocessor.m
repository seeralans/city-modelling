clear;
cen = loadData();

%% form a data matrix
dataMat = [];
for i = 1:length(cen)
  dataMat = [dataMat, cen{i}.data];
end


%% normalisation steps

mu = nanmean(dataMat);

[height, width] = size(dataMat);
normDataMat = zeros(height, width);

for i = 1:width

  %dataMat(isnan(dataMat(:, i))) = mu(i);

  xMax = max(dataMat(:,i));
  xMin = min(dataMat(:,i));


  normDataMat(:,i) = (dataMat(:, i) - xMin * ones(height, 1)) ./ (xMax - xMin);




end

%% pca

[coeff, ~, latent] = pca(normDataMat);

%% plotting spectrum

theta = linspace(0, length(coeff), length(coeff));

scatter(theta, coeff);



