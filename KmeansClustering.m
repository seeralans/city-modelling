%
% This code produces the best kmeans from 3 clusters with 4 features. Dont
% fuck with it please.
%
%
load Coords
k = 30; % no. of clusters
[clusterIDX, Centriods] = kmeans(normDataMat(:,[351 353 354 384]),k);
for i = 1:k

    clusters{i} = score(clusterIDX == i,:);

end
Class = zeros(3485,1);
k2 = 2; % no. of classes
[reclusterIDX,~] = kmeans(Centriods,k2,'Start',[1 0 0 0;0 0 1 0]);
for i = 1:numPoints  
    Class(i) = reclusterIDX(clusterIDX(i));
end
Class =  Class - 1 ;
figure('Name','Map - Kmeans')
for i = 1:length(score)

    a = Coords{i}(:,1);
    b = Coords{i}(:,2);
    if Class(i) == 1
        col = [0.66 0.66 0.66];
    elseif Class(i) == 0
            col = [1 1 1];
    end
    
    patch(a,b,col)
    hold on
end
hold off;

Structure = StructureTest(Class, Coords, ConnectionMat)