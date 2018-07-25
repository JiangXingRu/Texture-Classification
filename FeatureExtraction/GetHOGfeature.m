clear all
clc
%load dataset64gray % 加载数据集 64*64灰度图
% load dataset128gray % 加载数据集 128*128灰度图
load dataset
addpath(genpath('HOG'));
number = length(Labelimage);
for i = 1:number
    I = Labelimage(i).image;   % 读取图像数据
    [m n] = size(I);        % 获取图像尺寸
    step = m / 4;      % step*step个像素作为一个单元
    orient = 9;     % 方向直方图的方向个数
    feature = hog(I,step,orient);   % 进行特征提取
    HOGfeature(i).data = feature;   % 保存HOG特征
    HOGfeature(i).label = Labelimage(i).label;  % 设置标签  
end
save featureset HOGfeature

