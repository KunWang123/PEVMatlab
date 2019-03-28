function Triangle_Vn = get_triangle_Vn(vertices)
AB = vertices(:,4:6)-vertices(:,1:3);
AC = vertices(:,7:9)-vertices(:,1:3);
[m,n]= size(vertices);
Triangle_Vn = zeros(m,3);
Triangle_Vn(:,1) = AB(:,2).*AC(:,3)-AC(:,2).*AB(:,3);
Triangle_Vn(:,2) = AB(:,3).*AC(:,1)-AC(:,3).*AB(:,1);
Triangle_Vn(:,3) = AB(:,1).*AC(:,2)-AC(:,1).*AB(:,2);