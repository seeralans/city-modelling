%% setting up const parameters and data


data = score(:, 1:150);

% this is only for spectral
numConnection = 30;


%%
for i = 1:30
    %[~, ~, sumd] = spectralClustering(data, i, 100);
   [~, ~, sumd] = kmeans(data, i);
   
   error(i) = sum(sumd.^2);
end

plot(error);

%%
error1 = [error; 0]
error2 = [0; error]

errorChange = abs(error1 - error2);

figure;
plot(errorChange)



%%
[~, ~, sumd] = spectralClustering(data, i, 50);