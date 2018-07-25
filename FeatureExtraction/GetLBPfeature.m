clear all
clc
% load dataset64gray             % �������ݼ� 64*64�Ҷ�ͼ
%load dataset128gray            % �������ݼ� 128*128�Ҷ�ͼ
load dataset
number = length(Labelimage);   % ����������Ԫ�ظ���
for i = 1:number 
    I = Labelimage(i).image;        
    h = lbp(I);                   % ����ÿ��ͼƬ��LBPֱ��ͼ
    LBPfeature(i).data = h;       % ����LBP����
    LBPfeature(i).label = Labelimage(i).label;   % ���ñ�ǩ
end
save featureset LBPfeature