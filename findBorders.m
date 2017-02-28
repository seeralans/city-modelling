%Need to load Coords and ConnectionMat as well as run the preprocessor and
%a classifier (Class is indexes of classifier)
Num = 3485;
IsBorder = zeros(3485,1);

for i = 1:3485
    Borders = find(ConnectionMat(i,:));
    count=0;
    count2=0;
    for j = 1:length(Borders)
        if Class(Borders(j)) == 1
            count = count+1;
        elseif Class(Borders(j)) == 0
            count2 = count2+1;
        end
    end
    if count>0 && count2>0
        IsBorder(i) = 1;
    end
end

for i = 1:Num

    a = Coords{i}(:,1);
    b = Coords{i}(:,2);
    if Class(i) == 1
        col = [0.66 1 1];
    else
            col = [1 1 1];
    end
    
    patch(a,b,col)
    hold on
end

for i = 1:Num
    if (IsBorder(i) == 1 && Class(i) == 1)
        Borders = find(ConnectionMat(i,:));
        for j = 1:length(Borders)
            if Class(Borders(j))==0
                [v ai bi] = intersect(Coords{i},Coords{Borders(j)});
                BorderCoords = [];
                if mod(v,2) == 1
                    error('Number of points should be even')
                end
                [ai2 id] = sort(ai);
                for k = 1:length(ai2)
                    if k > length(ai2)/2
                        %BorderCoords(k,:) = Coords{i}(:,ai(k));
                    else
                        BorderCoords(k,:) = Coords{i}(ai2(k),:);
                    end
                end
                plot(BorderCoords(:,1),BorderCoords(:,2),'r','LineWidth',1.5)
                %plot(v(1:length(v)/2),v(((length(v)/2)+1):length(v)),'r','LineWidth',2.5)
            end
        end     
    end
end
load ('CoordsCityCouncil.mat')
plot(Coords2(:,1),Coords2(:,2),'y--','LineWidth',1.5)

Clear Num IsBorder Borders count count2 i j k col a b v ai bi BorderCoords
        
            