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

    diff = xMax - xMin;

    if diff ~= 0
        normDataMat(:,i) = (dataMat(:, i) - xMin * ones(height, 1)) ./ diff;
    end



end

%% pca

[coeff, score, latent] = pca(normDataMat, 'Rows', 'complete');

%% plotting spectrum

theta = linspace(0, length(coeff), length(coeff) );

plot(theta, latent);
xlabel('theta')
ylabel('latent')

[sort_coeff, idx] = sort(abs(coeff), 'descend');
RS_coeff = zeros(814,814);
for i = 1:length(latent)
    RS_coeff(:,i) = latent(i)*coeff(:,i);
end

[sort_coeff2, idx2] = sort(abs(RS_coeff), 'descend');

T = sum(abs(RS_coeff), 2);
[sort_T, ind] = sort(T);


% test = zeros(814, 2);
%
% idx2(1,1)


