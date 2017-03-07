%
% This code produces the best kmeans from 3 clusters with 4 features. Dont
% fuck with it please.
%
%
load Coords
%load ConnectionMat
numPoints = 3485;
k = 7; % no. of clusters
[clusterIDX, Centriods] = kmeans(score(:,1:150),k); % [MinDistJNorm MinDistBNorm MinDistDNorm MinDistEANorm MinDistBikeNorm MinDistBarsNorm MinDistTNorm]
for i = 1:k

    clusters{i} = score(clusterIDX == i,:);

end
Class = zeros(numPoints,1);
k2 = 7; % no. of classes
[reclusterIDX,~] = kmeans(Centriods,k2);
for i = 1:numPoints  
    Class(i) = reclusterIDX(clusterIDX(i));
end

figure();
silhouette(score(:,1:150),clusterIDX);

FigHandle = figure('Position', [100, 100, 800, 600],'Name','Map - Kmeans');
set(gca,'fontsize',10)
xlabel('latitude')
ylabel('longnitude')
title('Using PCA and Kmeans to cluster output areas')
for i = 1:length(score)

    a = Coords{i}(:,1);
    b = Coords{i}(:,2);
%     if Class(i) == 1
%         col = [0.66 0.66 0.66];
%     elseif Class(i) == 0
%             col = [1 1 1];
%     end
    
    j = Class(i)/k2;
    col = [j j j];
    patch(a,b,col)
    hold on
end
hold off;

Structure = StructureTest(Class, Coords, ConnectionMat)