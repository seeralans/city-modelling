% This calculates the midpoints of each of the areas. Finds the distance to
% the nearest Doctor, Banks, ect. Classifies the data using given features
% and K means. Data is then reclassified and smoothed usuing K NN.
%
%





maps = importdata('mapping/mapping_LA_OA_Vertices');
Cen1 = importdata('Reduced_Census/Census/ks101ew');

mapchar = char(maps);

num = 3485; %Set to number of regions you want to plot, 3485 for whole bristol area

Cords = [];
WantedVariable = zeros(1,num);

for j = 1:num
    WantedVariable(j) = Cen1.data(j,1)/Cen1.data(j,7); %Set RHS to desired data index
end

%MaxDat = max(People); %Find highest value in data set
%MinDat = min(People); %Find lowest value in data set

MaxDat = mean(WantedVariable)+2*std(WantedVariable);
MinDat = mean(WantedVariable)-2*std(WantedVariable);

if MinDat < 0
    MinDat = 0;
end

WantedVariable(WantedVariable>MaxDat) = MaxDat;
WantedVariable(WantedVariable<MinDat) = MinDat;

load Coords
Midpoints = zeros(3485,2);

LocationBanks = xlsread('locations/banks.csv');
LocationDoctors = xlsread('locations/doctors.csv');
LocationEstateAgents = xlsread('locations/estate_agents.csv');
LocationJewellry = xlsread('locations/jewellry.csv');

for i = 1:3485
    Midpoints(i,:) = [mean(Coords{i}(:,1)), mean(Coords{i}(:,2))];
        
end

DistB = zeros(109,1);
MinDistB = zeros(3484,1);
for i = 3485
    if isnan(Midpoints(i,:))
        Midpoints(i,:) = [0, 0];
    end
end

DistD = zeros(65,1);
MinDistD = zeros(3484,1);
DistEA = zeros(96,1);
MinDistEA = zeros(3484,1);
DistJ = zeros(46,1);
MinDistJ = zeros(3484,1);


for i = 1:3484
    
    
   for x = 1:109
       
       DistB(x) = sqrt((Midpoints(i,1) - LocationBanks(x,2))^2 + (Midpoints(i,2) - LocationBanks(x,1))^2);
   end
   MinDistB(i) = min(DistB) ;
   DistB = zeros(109,1);
   
   for x = 1:65
       
       DistD(x) = sqrt((Midpoints(i,1) - LocationDoctors(x,2))^2 + (Midpoints(i,2) - LocationDoctors(x,1))^2);
   end
   MinDistD(i) = min(DistD) ;
   DistD = zeros(65,1);
   
   for x = 1:96
       
       DistEA(x) = sqrt((Midpoints(i,1) - LocationEstateAgents(x,2))^2 + (Midpoints(i,2) - LocationEstateAgents(x,1))^2);
   end
   MinDistEA(i) = min(DistEA) ;
   DistEA = zeros(96,1);
   
   
   for x = 1:46
       
       DistJ(x) = sqrt((Midpoints(i,1) - LocationJewellry(x,2))^2 + (Midpoints(i,2) - LocationJewellry(x,1))^2);
   end
   MinDistJ(i) = min(DistJ) ;
   DistJ = zeros(46,1);
   
   
end


MinDistJ = [MinDistJ; 0];
MinDistD = [MinDistD; 0];
MinDistB = [MinDistB; 0];
MinDistEA = [MinDistEA; 0];
MinDistJNorm = MinDistJ./(max(MinDistJ));
MinDistDNorm = MinDistD./(max(MinDistD));
MinDistBNorm = MinDistB./(max(MinDistB));
MinDistEANorm = MinDistEA./(max(MinDistEA));
WantedVariableNorm = WantedVariable./(max(WantedVariable));

% Include features in this vector for K means
X = [MinDistJNorm WantedVariableNorm' ];

[IDX, C] = kmeans(X, 2);

D = zeros(3485,1);
K = 5; % no. of neighbours 
NN_IDX = zeros(3485,K);


% [dist, ind] = min(pdist2(X(:,1),X(:,2),C));
% 
% scatter(X(:,1),X(:,2),[],ind,'.');

for i = 1:3485
    for j = 1:3485
        D(j) = sqrt((Midpoints(i,1) - Midpoints(j,1))^2 + (Midpoints(i,2) - Midpoints(j,2))^2 );
        
    end
    [D2, I] = sort(D);
    NN_IDX(i,1:K) = I(1:K);
    
    
    if mod(i,100)==0
         disp(i)
    end
end

NIDX = zeros(3485,1);
IDX = IDX - 1;

for i = 1:3485
    
    V = zeros(K,1);
    for j = 1:K
        V(j) = IDX(NN_IDX(i,j));
    end
    
    if sum(V) >= K/2
    
        NIDX(i) = 1;
    else
        NIDX(i) = 0;
    end
    
end
NIDX = NIDX + 1;

figure()
for i = 1:3484
    
    
    a = Coords{i}(:,1);
    b = Coords{i}(:,2);
    
%     Uncomment the following if you wish to display text values over the 
%     top of the areas (Not recommended as it looks like aids)
%     
%     txt1 = num2str(Cen1.data(i,1)/Cen1.data(i,7));
%     text(mean(a),mean(b),txt1)
%     
%     plot(a,b)
%     Fills in area, change vector to change colours
    patch(a,b,[ NIDX(i)/2 NIDX(i)/2 NIDX(i)/2 ])%(WantedVariable(i)-MinDat)/(MaxDat-MinDat)(WantedVariable(i)-MaxDat)/(MinDat-MaxDat)
    
    if mod(i,1000)==0
        disp(i)
    end
end



