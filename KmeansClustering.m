%
% This code produces the best kmeans from 3 clusters with 4 features. Dont
% fuck with it please.
%
%

k = 3; % no. of clusters
[clusterIDX, ~] = kmeans(normDataMat(:,[351 353 354 384]),k,'Start',[1 0 0 0;0 1 0 0; 0 0 1 0]);
for i = 1:k

    clusters{i} = score(clusterIDX == i,:);

end
Class = zeros(3485,1);
for i = 1:3485

    if clusterIDX(i) == 1 
        Class(i) = 0; %City
    elseif clusterIDX(i) == 3 || clusterIDX(i) == 2
        Class(i) = 1; % Not city
    end
end

for i = 1:length(score)

    a = Coords{i}(:,1);
    b = Coords{i}(:,2);
    % if clusterIDX(i) == 1
    %     col = [1 1 1];

    % elseif clusterIDX(i) == 2
    %     col = [1 - 1/k, 1 - 1/k, 1- 1/k];

    % elseif clusterIDX(i) == 2
    %     col = [1 - 1/k, 1 - 1/k, 1- 1/k];
    % else
    %     col = [0.33 0.33 0.33];
    % end
    j = Class(i);
    col = [j, j, j];
    patch(a,b,col)
    hold on
end
hold off;