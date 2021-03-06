load Coords
load CoordsCityCouncil
k = 7;
[clusterIDX, ~] = kmeans(data, k);
class = clusterIDX;
% figure('Name', 'Main Map');
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
    j = clusterIDX(i) / k;
    col = [j, j, j];
    patch(a,b,col)
    hold on
end
%scatter(local(:,1), local(:, 2), 'ro', 'filled');

hold on;
%Uncomment this to plot bristol city council border
%plot(CoordsCityCouncil(:,1),CoordsCityCouncil(:,2),'b','linewidth',3)