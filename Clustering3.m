
k = 10; % no. of clusters
%[clusterIDX, ~] = kmeans(normDataMat(:,[351 353 354 384]),k, 'Start',[1 0 0 0; 0 1 0 0; 0 0 1 0]);
%%

for i = 1:k

    clusters{i} = score(IDX == i,:);

end
Class = zeros(3485,1);
for i = 1:3485

    if IDX(i) == 1 || IDX(i) == 2
        Class(i) = 1; %City
    elseif IDX(i) == 3
        Class(i) = 0; % Not city
    end
end
