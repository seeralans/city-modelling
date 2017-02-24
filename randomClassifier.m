% randomClassifier.m
% make sure to run preprocessor.m first

% choose probability that a random OA is classified as 'city'
probabilityCity = 0.5;
probabilityNonCity = 1-probabilityCity;
x = rand(height,1);

figure()
for i = 1:height

    a = Coords{i}(:,1);
    b = Coords{i}(:,2);
    if x(i) > probabilityCity % city OA are green
        col = [1 0 1];
    else
        col = [0 1 0]; % non city OA are purple
    end
    patch(a,b,col)
    hold on
end

string = sprintf('Random Classifier with %.1f probability that an OA is classified as city', probabilityCity);
title(string);