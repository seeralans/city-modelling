function [Cx, Cy] = findCentroid(A)
Area = polyarea(A(:,1),A(:,2));
Cx = 0;
Cy = 0;
for i = 1:length(A)-1   
    Cx = Cx + ((A(i,1)+A(i+1,1))*((A(i,1)*A(i+1,2))-(A(i+1,1)*A(i,2))));
    Cy = Cy + ((A(i,2)+A(i+1,2))*((A(i,1)*A(i+1,2))-(A(i+1,1)*A(i,2)))); 
end
Cx = -Cx/(Area*6);
Cy = -Cy/(Area*6);
scatter(Cx,Cy)
return
    
    