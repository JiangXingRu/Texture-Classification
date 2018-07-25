clear all
clc
%load dataset64gray % �������ݼ� 64*64�Ҷ�ͼ
% load dataset128gray % �������ݼ� 128*128�Ҷ�ͼ
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