function area = triangle_area(PA, PB, PC)
AB = PA-PB;
AC = PA-PC;
X = AB(:,2).*AC(:,3) - AC(:,2).*AB(:,3);
Y = AC(:,1).*AB(:,3) - AB(:,1).*AC(:,3);
Z = AB(:,1).*AC(:,2) - AC(:,1).*AB(:,2);
m = sqrt(X.*X + Y.*Y + Z.*Z);
area = m/2;
