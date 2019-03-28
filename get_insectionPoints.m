function  [value,orient] = get_insectionPoints(aerf,Triangle_Vn,vertices,M)
v1 = aerf(1,1)*cos(aerf(1,2));% x
v2 = aerf(1,1)*sin(aerf(1,2));% y
v3 = 0;% z
m1 = 0;% x
m2 = 0;% y
m3 = aerf(1,3);% z
index = find(M);
a = Triangle_Vn(index,1);% vn.x
b = Triangle_Vn(index,2);% vn.y
c = Triangle_Vn(index,3);% vn.z
n1 = vertices(index,1);% point.x
n2 = vertices(index,2);% point.y
n3 = vertices(index,3);% point.z
VPT = a*v1 + b*v2 + c*v3; 
t = (a.*(n1 - m1) + b.*(n2 - m2) + c.*(n3 - m3)) ./ VPT;% VPT=0ʱ t=inf
Px = m1 + v1*t;
Py = m2 + v2*t;
Pz = m3 + v3*t;
Px(Px == Inf,:) = m1;
Py(Py == Inf,:) = m2;
Pz(Pz == Inf,:) = m3;
P_point = [Px Py Pz];
Pin_T_res = vertify_PinT(P_point, vertices(index,:));
index_PRT = find(Pin_T_res);
testvalue = sqrt(Px(index_PRT,:).*Px(index_PRT,:)+Py(index_PRT,:).*Py(index_PRT,:));
%testorient = power(abs(VPT./(sqrt(a.*a+b.*b+c.*c)*sqrt(v1*v1+v2*v2+v3*v3))),5);
testorient = power(abs(VPT(index_PRT,:)./(sqrt(a(index_PRT,:).*a(index_PRT,:)+ ...
    b(index_PRT,:).*b(index_PRT,:)+c(index_PRT,:).*c(index_PRT,:))*sqrt(v1*v1+v2*v2+v3*v3))),5);
[value, I] = max(testvalue);
orient = testorient(I,1);
if isempty(value)
    value = 0;
    orient = 0;
end

% [colum,row] = size(M);
% for i = 1:colum
%     if M(i,1)==1
%         a = Triangle_Vn(i,1);% vn.x
% 		b = Triangle_Vn(i,2);% vn.y
%         c = Triangle_Vn(i,3);% vn.z
%         n1 = vertices(i,1);% point.x
%         n2 = vertices(i,2);% point.y
%         n3 = vertices(i,3);% point.z
%         VPT = a*v1 + b*v2 + c*v3;
%         if VPT ~= 0
%             t = (a*(n1 - m1) + b*(n2 - m2) + c*(n3 - m3)) / VPT;
%             Px = m1 + v1*t;
%             Py = m2 + v2*t;
%             Pz = m3 + v3*t;
%             P_point = [Px Py Pz];
%             if Px*v1 >= 0 && Pz * v3 >= 0
%                 Pin_T_res = vertify_PinT(P_point, vertices(i,:));
%                 if Pin_T_res
%                     testvalue = Px*Px+Pz*Pz;
%                     testorient = abs(VPT/(sqrt(a*a+b*b+c*c)*sqrt(v1*v1+v2*v2+v3*v3)))^5;
%                     if distance<testvalue
%                         distance = testvalue;
%                         orientvalue = testorient;
%                     end
%                 end
%             end
%         end        
%     end    
% end
% value = distance;
% orient = orientvalue;