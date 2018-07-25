clear all
clc
%load dataset64gray % �������ݼ� 64*64�Ҷ�ͼ
% load dataset128gray % �������ݼ� 128*128�Ҷ�ͼ
load dataset
addpath(genpath('HOG'));
number = length(Labelimage);
for i = 1:number
    I = Labelimage(i).image;   % ��ȡͼ������
    [m n] = size(I);        % ��ȡͼ��ߴ�
    step = m / 4;      % step*step��������Ϊһ����Ԫ
    orient = 9;     % ����ֱ��ͼ�ķ������
    feature = hog(I,step,orient);   % ����������ȡ
    HOGfeature(i).data = feature;   % ����HOG����
    HOGfeature(i).label = Labelimage(i).label;  % ���ñ�ǩ  
end
save featureset HOGfeature

