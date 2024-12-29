%% Function calcFearIndex calculates the Fear Index based on a weighted sum of extracted features (F).
function FearIndex = calcFearIndex(F)
    FearIndex = F(1) + (2*F(2)) + F(3) + (0.5*F(4)) + F(5) + (2*F(6)) + F(7) + (5*F(8)) + (0.001*F(9)) + (0.5*F(10));
end