%% Plotting clusters
for i = 1:length(clusters)
  scatter(clusters{i}(:, 1), clusters{i}(:,2), 'ro', 'filled'); hold on;

end

hold off;