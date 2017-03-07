load Coords
load ConnectionMat

LocationBanks = xlsread('Data/Data/locations/banks.csv');
LocationDoctors = xlsread('Data/Data/locations/doctors.csv');
LocationEstateAgents = xlsread('Data/Data/locations/estate_agents.csv');
LocationBars = xlsread('Data/Data/locations/bars.csv');
LocationBike = xlsread('Data/Data/locations/bicycle.csv');
LocationTaxi = xlsread('Data/Data/locations/taxi.csv');
LocationJewellry = xlsread('Data/Data/locations/jewellry.csv');


numPoints = length(Coords);
Midpoint = zeros(numPoints,2);

for i = 1:numPoints
    Midpoint(i,:) = findCentroid(Coords{i});
end

DistB = zeros(length(LocationBanks),1);
MinDistB = zeros(numPoints,1);
DistD = zeros(length(LocationDoctors),1);
MinDistD = zeros(numPoints,1);
DistEA = zeros(length(LocationEstateAgents),1);
MinDistEA = zeros(numPoints,1);
DistJ = zeros(length(LocationJewellry),1);
MinDistJ = zeros(numPoints,1);
DistBike = zeros(length(LocationBike),1);
MinDistBike = zeros(numPoints,1);
DistBars = zeros(length(LocationBars),1);
MinDistBars = zeros(numPoints,1);
DistT = zeros(length(LocationTaxi),1);
MinDistT = zeros(numPoints,1);

for i = 1: numPoints 
   for x = 1:length(LocationBanks)  
       DistB(x) = sqrt((Midpoint(i,1) - LocationBanks(x,2))^2 + (Midpoint(i,2) - LocationBanks(x,1))^2);
   end
   MinDistB(i) = min(DistB) ;
   DistB = zeros(length(LocationBanks),1);
   for x = 1:length(LocationDoctors)   
       DistD(x) = sqrt((Midpoint(i,1) - LocationDoctors(x,2))^2 + (Midpoint(i,2) - LocationDoctors(x,1))^2);
   end
   MinDistD(i) = min(DistD) ;
   DistD = zeros(length(LocationDoctors),1);
   for x = 1:length(LocationEstateAgents)    
       DistEA(x) = sqrt((Midpoint(i,1) - LocationEstateAgents(x,2))^2 + (Midpoint(i,2) - LocationEstateAgents(x,1))^2);
   end
   MinDistEA(i) = min(DistEA) ;
   DistEA = zeros(length(LocationEstateAgents),1);
   for x = 1:length(LocationJewellry)   
       DistJ(x) = sqrt((Midpoint(i,1) - LocationJewellry(x,2))^2 + (Midpoint(i,2) - LocationJewellry(x,1))^2);
   end
   MinDistJ(i) = min(DistJ) ;
   DistJ = zeros(46,1);
   
   for x = 1:length(LocationBike)  
       DistBike(x) = sqrt((Midpoint(i,1) - LocationBike(x,1))^2 + (Midpoint(i,2) - LocationBike(x,2))^2);
   end
   MinDistBike(i) = min(DistBike) ;
   DistBike = zeros(length(LocationBike),1);
   for x = 1:length(LocationBars)   
       DistBars(x) = sqrt((Midpoint(i,1) - LocationBars(x,1))^2 + (Midpoint(i,2) - LocationBars(x,2))^2);
   end
   MinDistBars(i) = min(DistBars) ;
   DistBars = zeros(length(LocationBars),1);
   for x = 1:length(LocationTaxi)    
       DistT(x) = sqrt((Midpoint(i,1) - LocationTaxi(x,1))^2 + (Midpoint(i,2) - LocationTaxi(x,2))^2);
   end
   MinDistT(i) = min(DistT) ;
   DistT = zeros(length(LocationTaxi),1);
   
end

MinDistJNorm = (MinDistJ - min(MinDistJ))/ (max(MinDistJ) - min(MinDistJ));
MinDistBNorm = (MinDistB - min(MinDistB))/ (max(MinDistB) - min(MinDistB));
MinDistDNorm = (MinDistD - min(MinDistD))/ (max(MinDistD) - min(MinDistD));
MinDistEANorm = (MinDistEA - min(MinDistEA))/ (max(MinDistEA) - min(MinDistEA));
MinDistBikeNorm = (MinDistBike - min(MinDistBike))/ (max(MinDistBike) - min(MinDistBike));
MinDistBarsNorm = (MinDistBars - min(MinDistBars))/ (max(MinDistBars) - min(MinDistBars));
MinDistTNorm = (MinDistT - min(MinDistT))/ (max(MinDistT) - min(MinDistT));

MinDistJNorm(isnan(MinDistJNorm)) = 0;
MinDistBNorm(isnan(MinDistBNorm)) = 0;
MinDistDNorm(isnan(MinDistDNorm)) = 0;
MinDistEANorm(isnan(MinDistEANorm)) = 0;
MinDistBikeNorm(isnan(MinDistBikeNorm)) = 0;
MinDistBarsNorm(isnan(MinDistBarsNorm)) = 0;
MinDistTNorm(isnan(MinDistTNorm)) = 0;

clear DistB MinDistB DistD MinDistD DistEA MinDistEA DistJ MinDistJ DistBike ...
      MinDistBike DistBars MinDistBars DistT MinDistT



