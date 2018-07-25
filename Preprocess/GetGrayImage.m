clc
clear all
% readpath = 'F:\ImageTestSet\ALOTsubset128_128\';
% writepath = 'F:\ImageTestSet\ALOTsubset128_128_gray\';
readpath = 'F:\ImageTestSet\ALOTsubset\';       % 读入图片路径
writepath = 'F:\ImageTestSet\ALOTsubset_gray\'; % 保存图片路径
for number = 1:10                % 图片数目
    filepath = [readpath,num2str(number)];    % 该类图片文件夹路径
    AuImgList = dir(fullfile(filepath,'*.png'));  % 打开所有格式为png的文件路径
    imagenumber = length(AuImgList);    % 自动计算图片数目
    for i = 1:imagenumber
        SC = [readpath,num2str(number),'\',num2str(i),'.png'];  % 图片路径
        I = imread(SC);                                         % 读入图片
        gray = rgb2gray(I);                                     % 进行灰度转换
        filewritepath = [writepath,num2str(number),'\'];        % 保存图片路径
        if ( 0 == exist(filewritepath,'dir') )                  % 若该路径不存在则创建路径
            mkdir(filewritepath);
        end
        imwrite(gray,[filewritepath,num2str(i),'.png']);        % 保存图片
    end
end