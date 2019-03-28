function [vertices,Cycvertices] = LoadFiles(Filespath3)
%��Filespath3���ļ����ش洢��vertices�У���ת��Ϊ������Ƕȴ洢��Cycvertices��
%verticesΪfaces*9, CycverticesΪface*3
[vertex,face] = read_off(Filespath3);
%% X �᷽��ȫ��ͼ
% �汾1
% vertexx = vertex(:,1);
% vertex(:,1) = vertex(:,3);
% vertex(:,3) = vertexx;

% �汾2
% vertexx = vertex(:,1);
% vertex(:,1) = vertex(:,2);
% vertex(:,2) = vertex(:,3);
% vertex(:,3) = vertexx;
%% Y �᷽��ȫ��ͼ
% �汾1
% vertexx = vertex(:,2);
% vertex(:,2) = vertex(:,3);
% vertex(:,3) = vertexx;

% �汾2
vertexx = vertex(:,2);
vertex(:,2) = vertex(:,1);
vertex(:,1) = vertex(:,3);
vertex(:,3) = vertexx;
%% ��һ������
maxvalue = max(vertex,[],1);
vertex = vertex/maxvalue(1,3);%��z���һ��x:1,y:2,z:3
%% ת��Ϊ�����꣬���Ұ���ÿ�������δ洢�����
[m,n] = size(face);% m face_number
vertices = zeros(m,9);% ��A B C ������ֵ
Cycvertices = zeros(m,3);%��A B C �ĽǶ�ֵ
v = 1;
for i=1:m
    for j = 1:n
        vertices(i,v:v+2) = vertex(face(i,j),:);
        %% ������ת��Ϊ�Ƕ�
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

