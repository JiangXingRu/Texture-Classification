clear all
clc
% load dataset64gray             % 加载数据集 64*64灰度图
%load dataset128gray            % 加载数据集 128*128灰度图
load dataset
number = length(Labelimage);   % 计算数据中元素个数
for i = 1:number 
    I = Labelimage(i).image;        
    h = lbp(I);                   % 计算每张图片的LBP直方图
    LBPfeature(i).data = h;       % 保存LBP特征
    LBPfeature(i).label = Labelimage(i).label;   % 设置标签
end
save featureset LBPfeature