%
%
 
%Data = normDataMat(:,[351,353,354,384]);

Class = zeros(3485,1);
Dist = zeros(3485,1);
for i = 1:3485
    if IDX(i) == 1 || IDX(i) == 2
    Class(i) = 1; %City
    
    elseif IDX(i) == 3
        Class(i) = 0; % Not city
    end
end
Midpoints = Midpoints; % Waiting for Ben's Code for center of masses 
Distance_Threshold = 0.0002;
Neighbough_Threshold = 5;

%% Whos Nearest Who

Neighbours = zeros(3485,3485);
Neigh_Dist = zeros(3485,3485);
for i = 1:3485
    for j = 1:3485
        Neigh_Dist(i,j) = sqrt((Midpoints(i,1) - Midpoints(j,1))^2 + (Midpoints(i,2) - Midpoints(j,2))^2);
    end
end

[Neigh_Dist2, Dist_Ind] = sort(Neigh_Dist);




%%  Test for the class of the areas surrounding a point
Neigh_Class = zeros(3485,1);
for i = 1:3485
    
    V = zeros(Neighbough_Threshold,1);
    for j = 1:K
        V(j) = Class(Dist_Ind(i,j));
    end
    
    if sum(V) >= K/2
    
        Neigh_Class(i) = 1;
    else
        Neigh_Class(i) = 0;
    end
    
end


Error = sum(Class - Neigh_Class);












