
load Coords
load CoordsCityCouncil
k = 3; % no. of clusters
[IDX, C] = kmeans(score(:,[1 2 3 4]),k);

for i = 1:length(score)

    a = Coords{i}(:,1);
    b = Coords{i}(:,2);
    if IDX(i) == 1
        col = 1;
    elseif IDX(i) == 2
        col = 0.5;
    else
        col = 0;
    end
    patch(a,b,[IDX(i)/k 1 IDX(i)/k])
    hold on
end

%Uncomment this to plot bristol city council border
%plot(CoordsCityCouncil(:,1),CoordsCityCouncil(:,2),'b','linewidth',3)
%%

for i = 1:k
    
    clusters{i} = score(IDX == i,:);
 
end

