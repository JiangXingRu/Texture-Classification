clear all;
close all;
clc;
data = xlsread('KSVD分类');
maxvalue = max(data(:))
featurelib = {'LBP','HOG','Gabor'};
alpha1 = [7 7 7 6 6 6 5 5 5 7 7 7 6 6 6 5 5 5];

[x y] = find(data == maxvalue);

featurenum = mod(y,3);
dict = x * 30;
aipha = 10^(alpha1(y) - 6)
if y > 9
    iter = 50
else
    iter = 20
end

disp(['The feature is  ' featurelib{featurenum}]);
disp(['The dict is  ' num2str(dict)]);

flag = 1;
if flag
    dictsize = 30:30:900;
    accuracy_lbp_alpha7_iter20 = data(:,1)';
    accuracy_hog_alpha7_iter20 = data(:,2)';
    accuracy_gabor_alpha7_iter20 = data(:,3)';

    accuracy_lbp_alpha6_iter20 = data(:,4)';
    accuracy_hog_alpha6_iter20 = data(:,5)';
    accuracy_gabor_alpha6_iter20 = data(:,6)';

    accuracy_lbp_alpha5_iter20 = data(:,7)';
    accuracy_hog_alpha5_iter20 = data(:,8)';
    accuracy_gabor_alpha5_iter20 = data(:,9)';

    accuracy_lbp_alpha7_iter50 = data(:,10)';
    accuracy_hog_alpha7_iter50 = data(:,11)';
    accuracy_gabor_alpha7_iter50 = data(:,12)';

    accuracy_lbp_alpha6_iter50 = data(:,13)';
    accuracy_hog_alpha6_iter50 = data(:,14)';
    accuracy_gabor_alpha6_iter50 = data(:,15)';

    accuracy_lbp_alpha5_iter50 = data(:,16)';
    accuracy_hog_alpha5_iter50 = data(:,17)';
    accuracy_gabor_alpha5_iter50 = data(:,18)';

    subplot(2,3,1);
    plot(dictsize,accuracy_lbp_alpha7_iter20,'b','linewidth',2);
    hold on;
    plot(dictsize,accuracy_hog_alpha7_iter20,'r','linewidth',2);
    plot(dictsize,accuracy_gabor_alpha7_iter20,'g','linewidth',2);
    legend('LBP','HOG','Gabor');
    set(gca, 'FontSize', 14);
    title(' \alpha = 10 iter = 20','Fontsize',16,'Fontname','Times New Roman');
    xlabel('字典容量','Fontsize',14,'Fontname','宋体');
    ylabel('分类准确率','Fontsize',14,'Fontname','宋体');
    axis([30 900 0 1]);

    subplot(2,3,2);
    plot(dictsize,accuracy_lbp_alpha6_iter20,'b','linewidth',2);
    hold on;
    plot(dictsize,accuracy_hog_alpha6_iter20,'r','linewidth',2);
    plot(dictsize,accuracy_gabor_alpha6_iter20,'g','linewidth',2);
    legend('LBP','HOG','Gabor');
    set(gca, 'FontSize', 14);
    title(' \alpha = 1 iter = 20','Fontsize',16,'Fontname','Times New Roman');
    xlabel('字典容量','Fontsize',14,'Fontname','宋体');
    ylabel('分类准确率','Fontsize',14,'Fontname','宋体');
    axis([30 900 0 1]);

    subplot(2,3,3);
    plot(dictsize,accuracy_lbp_alpha5_iter20,'b','linewidth',2);
    hold on;
    plot(dictsize,accuracy_hog_alpha5_iter20,'r','linewidth',2);
    plot(dictsize,accuracy_gabor_alpha5_iter20,'g','linewidth',2);
    legend('LBP','HOG','Gabor');
    set(gca, 'FontSize', 14);
    title(' \alpha = 0.1 iter = 20','Fontsize',16,'Fontname','Times New Roman');
    xlabel('字典容量','Fontsize',14,'Fontname','宋体');
    ylabel('分类准确率','Fontsize',14,'Fontname','宋体');
    axis([30 900 0 1]);

    subplot(2,3,4);
    plot(dictsize,accuracy_lbp_alpha7_iter50,'b','linewidth',2);
    hold on;
    plot(dictsize,accuracy_hog_alpha7_iter50,'r','linewidth',2);
    plot(dictsize,accuracy_gabor_alpha7_iter50,'g','linewidth',2);
    legend('LBP','HOG','Gabor');
    set(gca, 'FontSize', 14);
    title(' \alpha = 10 iter = 50','Fontsize',16,'Fontname','Times New Roman');
    xlabel('字典容量','Fontsize',14,'Fontname','宋体');
    ylabel('分类准确率','Fontsize',14,'Fontname','宋体');
    axis([30 900 0 1]);

    subplot(2,3,5);
    plot(dictsize,accuracy_lbp_alpha6_iter50,'b','linewidth',2);
    hold on;
    plot(dictsize,accuracy_hog_alpha6_iter50,'r','linewidth',2);
    plot(dictsize,accuracy_gabor_alpha6_iter50,'g','linewidth',2);
    legend('LBP','HOG','Gabor');
    set(gca, 'FontSize', 14);
    title(' \alpha = 1 iter = 50','Fontsize',16,'Fontname','Times New Roman');
    xlabel('字典容量','Fontsize',14,'Fontname','宋体');
    ylabel('分类准确率','Fontsize',14,'Fontname','宋体');
    axis([30 900 0 1]);

    subplot(2,3,6);
    plot(dictsize,accuracy_lbp_alpha5_iter50,'b','linewidth',2);
    hold on;
    plot(dictsize,accuracy_hog_alpha5_iter50,'r','linewidth',2);
    plot(dictsize,accuracy_gabor_alpha5_iter50,'g','linewidth',2);
    legend('LBP','HOG','Gabor');
    set(gca, 'FontSize', 14);
    title(' \alpha = 0.1 iter = 50','Fontsize',16,'Fontname','Times New Roman');
    xlabel('字典容量','Fontsize',14,'Fontname','宋体');
    ylabel('分类准确率','Fontsize',14,'Fontname','宋体');
    axis([30 900 0 1]);
end





