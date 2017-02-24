
load Coords
load CoordsCityCouncil
k = 3; % no. of clusters
[IDX, C] = kmeans(normDataMat(:,[351 353 354 384]),k, 'Start',[1 0 0 0; 0 1 0 0; 0 0 1 0]);

for i = 1:length(score)

    a = Coords{i}(:,1);
    b = Coords{i}(:,2);
    if IDX(i) == 1
        col = [1 1 1];
    elseif IDX(i) == 2
        col = [0.66 0.66 0.66];
    else
        col = [0.33 0.33 0.33];
    end
    patch(a,b,col)
    hold on
end

%Uncomment this to plot bristol city council border
%plot(CoordsCityCouncil(:,1),CoordsCityCouncil(:,2),'b','linewidth',3)
%%

for i = 1:k
    
    clusters{i} = score(IDX == i,:);
 
end

