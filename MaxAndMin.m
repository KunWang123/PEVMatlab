function [M1,M2] = MaxAndMin(Cycseita)
% Cycseita size is faces*3 
% 找到三角形所夸角度范围，最大角度和最小角度
[m,n] = size(Cycseita);
M1 = zeros(m,1);
M2 = zeros(m,1);
for i = 1:m
    if abs(Cycseita(i,1)-Cycseita(i,2))<180 && abs(Cycseita(i,1)-Cycseita(i,3))<180 &&abs(Cycseita(i,2)-Cycseita(i,3))<180 
        M1(i,1) = max(Cycseita(i,:));
        M2(i,1) = min(Cycseita(i,:));
    else
        Q1 = max(Cycseita(i,1),Cycseita(i,2));
        Q2 = min(Cycseita(i,1),Cycseita(i,2));
        if Q1-Q2>=180
            if Cycseita(i,3)-Q2>180
                Q1 = min(Q1,Cycseita(i,3));
            else
                Q2 = max(Q2,Cycseita(i,3));
            end
        else
            if Cycseita(i,3) -Q1 < 180
                Q2 = Q1;
                Q1 = Cycseita(i,3);
            end
        end
        M1(i,1) = Q2;
        M2(i,1) = Q1;
    end
end
