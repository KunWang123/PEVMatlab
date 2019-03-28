clear;
clc;
B = 128;
path = './test';%输入路径
patho = [path '3_test'];%输出路径
Filename = dir(path);
LenFiles = length(Filename);
for i = 3:LenFiles
    Filespath1 = [path,'/',Filename(i).name];%./ModelNet10/bed
    Filespath1o = [patho,'/',Filename(i).name];%./ModelNet10/bed
    Filename1 = dir(Filespath1);
    for j = 3:length(Filename1)
        Filespath2 = [Filespath1,'/',Filename1(j).name];%./ModelNet10/bed/train
        Filespath2o = [Filespath1o,'/',Filename1(j).name];%./ModelNet10/bed/train
        Filename2 = dir(Filespath2);
%         parpool(4)
        for k = 3:length(Filename2)
            Filespath3 = [Filespath2,'/',Filename2(k).name];
            pathout = [Filespath2o,'image/'];
            
            pathout_orient = [Filespath2o,'orient/'];
            %输出图片所在的文件及及名字
            tic;
%             t1 = clock;
            panormic = zeros(B,2*B);
            orient = zeros(B,2*B);
            [vertices,Cycseita] = LoadFiles(Filespath3); 
            
%             disp(['加载数据时间：',num2str(etime(clock,t1))])
%             t2 = clock;
            
            %Cycseita = Getseita(Cycvertices);
            [M1,M2] = MaxAndMin(Cycseita);
            
%             disp(['角度间距时间：',num2str(etime(clock,t2))])
%             t3 = clock;
            
            Triangle_Vn = get_triangle_Vn(vertices);
            
%             disp(['法向量时间：',num2str(etime(clock,t3))])
%             t4 = clock;
            
            for miu = 0:(2*B-1)
%                 t5 = clock;
                my_thea = miu *pi/B;
                if(my_thea>=2*pi)
                    my_thea = my_thea-2*pi;
                end
                M = FindRange(M1,M2,my_thea);
%                 disp(['夹角时间：',num2str(etime(clock,t5))])
%                 t6 = clock;
                for V = 0:B-1
                    z = -1.1 + V*(2.2/B);
                    aerf = [1,my_thea,z];
                    [panormic(V+1,miu+1),orient(V+1,miu+1)]= get_insectionPoints(aerf,Triangle_Vn,vertices,M);
                end
%                 disp(['距离时间：',num2str(etime(clock,t6))])
            end
%             disp(['计算距离时间：',num2str(etime(clock,t4))])
            
            max_value = max(panormic(:));
            panormic = panormic*255/max_value;
            show_image = uint8(panormic);
            
            max_orient = max(orient(:));
            orient = orient*255/max_orient;
            show_orient = uint8(orient);
            %imshow(panormic);
            %pathout = [Filespath2,'image\',Filename2(k).name(1:end-4),'.jpg'];
            if ~exist(pathout,'dir')
                mkdir(pathout);
            end
            filenameout = [pathout,Filename2(k).name(1:end-4),'Y.png']
            imwrite(show_image,filenameout); 
            if ~exist(pathout_orient,'dir')
                mkdir(pathout_orient);
            end
            filenameout_orient = [pathout_orient,Filename2(k).name(1:end-4),'YOrient.png']
            imwrite(show_orient,filenameout_orient);
            toc
        end         
    end
end




