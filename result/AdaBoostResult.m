close all
clear all
clc
% load ADABOOSTlbp10.mat
% load ADABOOSTlbp20.mat
% load ADABOOSThog10.mat
% load ADABOOSThog20.mat
% load ADABOOSThog30.mat
% load ADABOOSTGabor10.mat
% load ADABOOSTGabor20.mat
% load ADABOOSTGabor30.mat

% class = 10;
% confusion = zeros(class, class);
% for i = 1:class - 1
%     for j = i+1:class
%         confusion(i,j) = AdaBoost_model{i,j}.test_error;
%     end
% end
% 
% error_rate =  [];
% for i = 1:class - 1
%     error_rate = [error_rate; confusion(i,i+1:end)'];
% end
weak_leaner_num = 20;
x = 1:weak_leaner_num;
class = 10;

load ADABOOSTlbp20.mat
count = 1;
for i = 1:class - 1
    for j = i+1:class
        train_time_lbp_20(count,:) = AdaBoost_model{i,j}.train_time;
        count = count + 1;
    end
end
trainerrlbp1vs2 = AdaBoost_model{1,2}.train_error;
trainerrlbp2vs3 = AdaBoost_model{2,3}.train_error;
trainerrlbp3vs4 = AdaBoost_model{3,4}.train_error;
trainerrlbp4vs5 = AdaBoost_model{4,5}.train_error;
trainerrlbp5vs6 = AdaBoost_model{5,6}.train_error;
trainerrlbp6vs7 = AdaBoost_model{6,7}.train_error;
trainerrlbp7vs8 = AdaBoost_model{7,8}.train_error;
trainerrlbp8vs9 = AdaBoost_model{8,9}.train_error;
trainerrlbp9vs10 = AdaBoost_model{9,10}.train_error;
time1 = mean(train_time_lbp_20,1);
time1std = sqrt(std(train_time_lbp_20,0,1));
errorbar(x,time1,time1std,'b','linewidth',2);
hold on;
load ADABOOSThog20.mat
count = 1;
for i = 1:class - 1
    for j = i+1:class
        train_time_hog_20(count,:) = AdaBoost_model{i,j}.train_time;
        count = count + 1;
    end
end
trainerrhog1vs2 = AdaBoost_model{1,2}.train_error;
trainerrhog2vs3 = AdaBoost_model{2,3}.train_error;
trainerrhog3vs4 = AdaBoost_model{3,4}.train_error;
trainerrhog4vs5 = AdaBoost_model{4,5}.train_error;
trainerrhog5vs6 = AdaBoost_model{5,6}.train_error;
trainerrhog6vs7 = AdaBoost_model{6,7}.train_error;
trainerrhog7vs8 = AdaBoost_model{7,8}.train_error;
trainerrhog8vs9 = AdaBoost_model{8,9}.train_error;
trainerrhog9vs10 = AdaBoost_model{9,10}.train_error;
time2 = mean(train_time_hog_20,1);
time2std = sqrt(std(train_time_hog_20,0,1));
errorbar(x,time2,time2std,'r','linewidth',2);

load ADABOOSTGabor20.mat
count = 1;
for i = 1:class - 1
    for j = i+1:class
        train_time_Gabor_20(count,:) = AdaBoost_model{i,j}.train_time;
        count = count + 1;
    end
end
trainerrgabor1vs2 = AdaBoost_model{1,2}.train_error;
trainerrgabor2vs3 = AdaBoost_model{2,3}.train_error;
trainerrgabor3vs4 = AdaBoost_model{3,4}.train_error;
trainerrgabor4vs5 = AdaBoost_model{4,5}.train_error;
trainerrgabor5vs6 = AdaBoost_model{5,6}.train_error;
trainerrgabor6vs7 = AdaBoost_model{6,7}.train_error;
trainerrgabor7vs8 = AdaBoost_model{7,8}.train_error;
trainerrgabor8vs9 = AdaBoost_model{8,9}.train_error;
trainerrgabor9vs10 = AdaBoost_model{9,10}.train_error;
time3 = mean(train_time_Gabor_20,1);
time3std = sqrt(std(train_time_Gabor_20,0,1));
errorbar(x,time3,time3std,'g','linewidth',2);
legend('LBP','HOG','Gabor');
set(gca, 'FontSize', 28);
title('弱分类器训练时间','Fontsize',30,'Fontname','黑体');
xlabel('弱分类器数目','Fontsize',28,'Fontname','宋体');
ylabel('训练时间 (s)','Fontsize',28,'Fontname','宋体');
hold off

figure;% 绘制训练误差图

subplot(3,3,1);
plot(trainerrlbp1vs2,'b','linewidth',2);
hold on;
plot(trainerrhog1vs2,'r','linewidth',2);
plot(trainerrgabor1vs2,'g','linewidth',2);
legend('LBP','HOG','Gabor');
set(gca, 'FontSize', 14);
title('class1 vs class2','Fontsize',16,'Fontname','Times New Roman');
xlabel('弱分类器数目','Fontsize',14,'Fontname','宋体');
ylabel('分类错误率','Fontsize',14,'Fontname','宋体');

subplot(3,3,2);
plot(trainerrlbp2vs3,'b','linewidth',2);
hold on;
plot(trainerrhog2vs3,'r','linewidth',2);
plot(trainerrgabor2vs3,'g','linewidth',2);
legend('LBP','HOG','Gabor');
set(gca, 'FontSize', 14);
title('class2 vs class3','Fontsize',16,'Fontname','Times New Roman');
xlabel('弱分类器数目','Fontsize',14,'Fontname','宋体');
ylabel('分类错误率','Fontsize',14,'Fontname','宋体');

subplot(3,3,3);
plot(trainerrlbp3vs4,'b','linewidth',2);
hold on;
plot(trainerrhog3vs4,'r','linewidth',2);
plot(trainerrgabor3vs4,'g','linewidth',2);
legend('LBP','HOG','Gabor');
set(gca, 'FontSize', 14);
title('class3 vs class4','Fontsize',16,'Fontname','Times New Roman');
xlabel('弱分类器数目','Fontsize',14,'Fontname','宋体');
ylabel('分类错误率','Fontsize',14,'Fontname','宋体');

subplot(3,3,4);
plot(trainerrlbp4vs5,'b','linewidth',2);
hold on;
plot(trainerrhog4vs5,'r','linewidth',2);
plot(trainerrgabor4vs5,'g','linewidth',2);
legend('LBP','HOG','Gabor');
set(gca, 'FontSize', 14);
title('class4 vs class5','Fontsize',16,'Fontname','Times New Roman');
xlabel('弱分类器数目','Fontsize',14,'Fontname','宋体');
ylabel('分类错误率','Fontsize',14,'Fontname','宋体');

subplot(3,3,5);
plot(trainerrlbp5vs6,'b','linewidth',2);
hold on;
plot(trainerrhog5vs6,'r','linewidth',2);
plot(trainerrgabor5vs6,'g','linewidth',2);
legend('LBP','HOG','Gabor');
set(gca, 'FontSize', 14);
title('class5 vs class6','Fontsize',16,'Fontname','Times New Roman');
xlabel('弱分类器数目','Fontsize',14,'Fontname','宋体');
ylabel('分类错误率','Fontsize',14,'Fontname','宋体');

subplot(3,3,6);
plot(trainerrlbp6vs7,'b','linewidth',2);
hold on;
plot(trainerrhog6vs7,'r','linewidth',2);
plot(trainerrgabor6vs7,'g','linewidth',2);
legend('LBP','HOG','Gabor');
set(gca, 'FontSize', 14);
title('class6 vs class7','Fontsize',16,'Fontname','Times New Roman');
xlabel('弱分类器数目','Fontsize',14,'Fontname','宋体');
ylabel('分类错误率','Fontsize',14,'Fontname','宋体');

subplot(3,3,7);
plot(trainerrlbp7vs8,'b','linewidth',2);
hold on;
plot(trainerrhog7vs8,'r','linewidth',2);
plot(trainerrgabor7vs8,'g','linewidth',2);
legend('LBP','HOG','Gabor');
set(gca, 'FontSize', 14);
title('class7 vs class8','Fontsize',16,'Fontname','Times New Roman');
xlabel('弱分类器数目','Fontsize',14,'Fontname','宋体');
ylabel('分类错误率','Fontsize',14,'Fontname','宋体');

subplot(3,3,8);
plot(trainerrlbp8vs9,'b','linewidth',2);
hold on;
plot(trainerrhog8vs9,'r','linewidth',2);
plot(trainerrgabor8vs9,'g','linewidth',2);
legend('LBP','HOG','Gabor');
set(gca, 'FontSize', 14);
title('class8 vs class9','Fontsize',16,'Fontname','Times New Roman');
xlabel('弱分类器数目','Fontsize',14,'Fontname','宋体');
ylabel('分类错误率','Fontsize',14,'Fontname','宋体');

subplot(3,3,9);
plot(trainerrlbp9vs10,'b','linewidth',2);
hold on;
plot(trainerrhog9vs10,'r','linewidth',2);
plot(trainerrgabor9vs10,'g','linewidth',2);
legend('LBP','HOG','Gabor');
set(gca, 'FontSize', 14);
title('class9 vs class10','Fontsize',16,'Fontname','Times New Roman');
xlabel('弱分类器数目','Fontsize',14,'Fontname','宋体');
ylabel('分类错误率','Fontsize',14,'Fontname','宋体');


hold off






