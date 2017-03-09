figure()
hold on
tempvar2 = zeros(1,814);
for i = 1:814
    tempvar2(i) = sum(normDataMat(:,i))/3485;
end
tempvar = zeros(1,814);
%scatter(1:814,tempvar2)
hold on
for j = 3 %class number you want to compare
    indxs = find(Class==j);
    for i = 1:814
        tempvar(i) = (sum(normDataMat(indxs,i))/length(indxs))-tempvar2(i);
    end
    scatter(1:814,tempvar)
end
[a b] = sort(abs(tempvar),'descend')
b(1:10)
    