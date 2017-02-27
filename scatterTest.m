BeforeScatter = normDataMat(:,[351,352,353,384])'*normDataMat(:,[351,352,353,384]);
BSTrace = trace(BeforeScatter);

for j = 1:max(IDX)
    V = [];
    for i = 1:3485
        if IDX(i) == j
            V = [V;normDataMat(i,[351,352,353,384])];
        end
    end
    if j == 1
        A = V;
    elseif j == 2
        B = V;
    else
        C = V;
    end
end

ATrace = trace(A'*A);
BTrace = trace(B'*B);
CTrace = trace(C'*C);

BetweenScatterMeasure = BSTrace - (ATrace + BTrace + CTrace)



