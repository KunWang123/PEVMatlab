function Pin_T_res = vertify_PinT(P_point, point)
% point size 1*9, PA*3 + PB*3 + PC*3
PA = point(:,1:3);
PB = point(:,4:6);
PC = point(:,7:9);
area1 = triangle_area(PA, PB, PC);
area2 = triangle_area(P_point, PB, PC);
area3 = triangle_area(PA, P_point, PC);
area4 = triangle_area(PA, PB, P_point);
area11 = area2 + area3 + area4;
judge_area = abs(area1 - area11);

Pin_T_res = (judge_area <= area1 / 100.0);


