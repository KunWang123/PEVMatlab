function [vertices,Cycvertices] = LoadFiles(Filespath3)
%将Filespath3的文件加载存储在vertices中，并转化为极坐标角度存储在Cycvertices中
%vertices为faces*9, Cycvertices为face*3
[vertex,face] = read_off(Filespath3);
%% X 轴方向全景图
% 版本1
% vertexx = vertex(:,1);
% vertex(:,1) = vertex(:,3);
% vertex(:,3) = vertexx;

% 版本2
% vertexx = vertex(:,1);
% vertex(:,1) = vertex(:,2);
% vertex(:,2) = vertex(:,3);
% vertex(:,3) = vertexx;
%% Y 轴方向全景图
% 版本1
% vertexx = vertex(:,2);
% vertex(:,2) = vertex(:,3);
% vertex(:,3) = vertexx;

% 版本2
vertexx = vertex(:,2);
vertex(:,2) = vertex(:,1);
vertex(:,1) = vertex(:,3);
vertex(:,3) = vertexx;
%% 归一化函数
maxvalue = max(vertex,[],1);
vertex = vertex/maxvalue(1,3);%对z轴归一化x:1,y:2,z:3
%% 转化为极坐标，并且按照每个三角形存储坐标点
[m,n] = size(face);% m face_number
vertices = zeros(m,9);% 点A B C 的坐标值
Cycvertices = zeros(m,3);%点A B C 的角度值
v = 1;
for i=1:m
    for j = 1:n
        vertices(i,v:v+2) = vertex(face(i,j),:);
        %% 极坐标转换为角度
        angle = atan2(vertex(face(i,j),2),vertex(face(i,j),1));% y/x
        if angle<0
            Cycvertices(i,j) = angle/pi*180+360;
        else
            Cycvertices(i,j) = angle/pi*180;
        end
        v = v+3;
        v = mod(v,9);
    end
end

