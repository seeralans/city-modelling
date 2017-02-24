function C = centreMass(pointIDX, Coords)

P = Coords{pointIDX};
[height, ~] = size(P);
tMass = 0;
tMassX = 0;
tMassY = 0;
tMass = height;
for i = 1:height
    
    tMassX = tMassX + P(i,1);
    tMassY = tMassY + P(i,2);
    
    
end

C = [tMassX, tMassY] ./ tMass;


end