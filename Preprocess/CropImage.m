clear all
clc
src_path='F:\ImageTestSet\ALOT\'; %原始图片路径 ALOT数据集
dst_path = 'F:\ImageTestSet\ALOTsubset\';%分割图片后保存路径
imageclass = [1,4,5,7,10,16,23,64,81,205];
imagename = {'_c1i', '_c1l2','_c1l2r60','_c1l2r120','_c1l2r180','_c1l3r60','_c1l3r120','_c1l3r180','_c1l4','_c1l4r60',...
    '_c1l4r120','_c1l4r180','_c1l8','_c1l8r60','_c1l8r120','_c1l8r180','_c1l1','_c1l1r60','_c1l1r120','_c1l1r180'};

for number = 1:length(imageclass)
    for k = 1:length(imagename)
        image_src_path = [src_path,num2str(imageclass(number)),'\',num2str(imageclass(number)) ,imagename{k},'.png'];  % 读入图片的具体路径
        A = imread(image_src_path);     % 读入图片
        [m,n,l] = size(A);              % 确定图片张量的维数
        row = 4; vol = 6;               % 将图像分割为64*64大小图像块
    %     row = 2; vol = 3;               % 将图片分割为128*128大小图像块
        image_dst_path = [dst_path,num2str(number),'\'];
        if ( 0 == exist(image_dst_path,'dir') )
            mkdir(image_dst_path);
        end
        for i = 1:row
            for j = 1:vol
               m_start=1+(i-1)*fix(m/row);          % 确定分割的起始坐标和终止坐标
               m_end=i*fix(m/row);
               n_start=1+(j-1)*fix(n/vol);
               n_end=j*fix(n/vol);
               AA=A(m_start:m_end,n_start:n_end,:);  %将每块读入矩阵
               imwrite(AA,[image_dst_path ,num2str((k-1)*vol*row+(i-1)*vol+j) ,'.png' ],'png'); % 写图像
            end
        end 
    end
end

