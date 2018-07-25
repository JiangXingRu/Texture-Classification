clc
clear all
readpath = 'F:\ImageTestSet\ALOTsubset_gray\';

for number = 1:10
    filepath = [readpath,num2str(number),'\'];
    AuImgList = dir(fullfile(filepath,'*.png'));  % 打开所有格式为png的文件路径
    imagenumber = length(AuImgList);    % 自动计算图片数目    
    for i = 1:imagenumber
        imagepath = [filepath,num2str(i),'.png'];
        I = imread(imagepath);
        total = (number-1) * imagenumber + i;
        Labelimage(total).image = I;
        Labelimage(total).label = number;
        imshow(I);
    end
end
save dataset Labelimage 

