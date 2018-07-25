clear all
clc
%load dataset64gray % 加载数据集 64*64灰度图
% load dataset128gray % 加载数据集 128*128灰度图
load dataset
number = length(Labelimage);
tic;
for i = 1:number
    I = Labelimage(i).image;    
    feature = gabor(I);
    Gaborfeature(i).data = feature;
    Gaborfeature(i).label = Labelimage(i).label;
end
toc
save featureset Gaborfeature