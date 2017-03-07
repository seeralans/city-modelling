%%
bicycle = csvread('./Data/Data/Locations/bicycle.csv');
bars = csvread('./Data/Data/Locations/bars.csv');
taxi = csvread('./Data/Data/Locations/taxi.csv');
local = [bicycle; bicycle; bicycle; bars; bars; taxi];
error = zeros(10, 1);
for i = 1:10
   [~, ~, sumd] = kmeans(local, i);
   
   error(i) = sum(sumd.^2);
end

%plot(error);
%%
[class, centroids, ~] = kmeans(local, 3);

% figure;
scatter(local(class == 1, 1), local(class == 1, 2), 'ro'); hold on;
scatter(local(class == 2, 1), local(class == 2, 2), 'bo'); hold on;
scatter(local(class == 3, 1), local(class == 3, 2), 'go'); hold on;

scatter(centroids(:, 1), centroids(:, 2), 'kd', 'filled')

hold on;

%%
class1 = local(class == 1, :);
class2 = local(class == 2, :);
class3 = local(class == 3, :);


mu = centroids;

C1 = cov(class1);
C2 = cov(class2);
C3 = cov(class3);

minX = min(local(:, 1));
maxX = max(local(:, 1));

minY = min(local(:, 2));
maxY = max(local(:, 2));

[X, Y] = meshgrid(linspace(minX, maxX, 100), linspace(minY, maxY, 100));

F1 = mvnpdf([X(:), Y(:)], mu(1,:), C1);
F1 = reshape(F1, 100, 100) ;

F2 = mvnpdf([X(:), Y(:)], mu(2,:), C2);
F2 = reshape(F2, 100, 100) ;

F3 = mvnpdf([X(:), Y(:)], mu(3,:), C3);
F3 = reshape(F3, 100, 100) ;


F1C = mvncdf([X(:), Y(:)], mu(1,:), C1);
F1C = reshape(F1, 100, 100) ;
mc = max(F1(:));
contour(X, Y, abs(F1 - mc - 0.1) <= 0.51);
% contour(X, Y, abs(F2 - F3) <= 0.001)
% contour(X, Y, abs(F2 - F1) <= 0.001)
% contour(X, Y, F3 == F2)
% contour(X, Y, F3 == F1)

hold on;

