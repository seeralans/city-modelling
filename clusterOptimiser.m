%% setting up const parameters and data


data = score(:, 1:150);

% this is only for spectral
numConnection = 30;


objectiveFuncWrap = @(numClusters)objectiveFunc(numClusters, data, numConnection);


%% optimise
x0 = 10;

x = fmincon(objectiveFuncWrap, x0, [], [], [], [], 0, Inf);
