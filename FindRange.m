function M = FindRange(M1,M2,thea)
% M1 is max
% M2 is min
test_thea = thea*180/pi;
[m,n] = size(M1);
N1 = zeros(m,1);
N2 = zeros(m,1);
for i = 1:m
    if M1(i,1)>M2(i,1)
        if test_thea<M1(i,1)
            N1(i,1) = 1;
        end
        if test_thea>M2(i,1)
            N2(i,1) = 1;
        end
    else
        if test_thea>180
            if test_thea>M2(i,1)
                N1(i,1) = 1;
                N2(i,1) = 1;
            end
        else
            if test_thea < M1(i,1)
                N1(i,1) = 1;
                N2(i,1) = 1;
            end
        end      
    end
end
M = and(N1,N2);