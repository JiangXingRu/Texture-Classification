clc
clear all
% readpath = 'F:\ImageTestSet\ALOTsubset128_128\';
% writepath = 'F:\ImageTestSet\ALOTsubset128_128_gray\';
readpath = 'F:\ImageTestSet\ALOTsubset\';       % ����ͼƬ·��
writepath = 'F:\ImageTestSet\ALOTsubset_gray\'; % ����ͼƬ·��
for number = 1:10                % ͼƬ��Ŀ
    filepath = [readpath,num2str(number)];    % ����ͼƬ�ļ���·��
    AuImgList = dir(fullfile(filepath,'*.png'));  % �����и�ʽΪpng���ļ�·��
    imagenumber = length(AuImgList);    % �Զ�����ͼƬ��Ŀ
    for i = 1:imagenumber
        SC = [readpath,num2str(number),'\',num2str(i),'.png'];  % ͼƬ·��
        I = imread(SC);                                         % ����ͼƬ
        gray = rgb2gray(I);                                     % ���лҶ�ת��
        filewritepath = [writepath,num2str(number),'\'];        % ����ͼƬ·��
        if ( 0 == exist(filewritepath,'dir') )                  % ����·���������򴴽�·��
            mkdir(filewritepath);
        end
        imwrite(gray,[filewritepath,num2str(i),'.png']);        % ����ͼƬ
    end
end