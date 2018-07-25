close all
clear all
clc
addpath(genpath('ConfusionMatrices'));
featurelib = {'LBP','HOG','Gabor'};    % ÌØÕ÷¿â
feature_number = 3;                    % Ñ¡ÔñÌØÕ÷
switch feature_number
    case 1
        load SVMLBP;
    case 2
        load SVMHOG
    case 3
        load SVMGabor
end
        

num_class = 10;
confusion_matrix = confusion ./ 100;
name_class = {'class-1';'class-2';'class-3';'class-4';'class-5';'class-6';'class-7';'class-8';'class-9';'class-10'};
draw_cm(confusion_matrix,name_class,num_class);
hold on;
axis square

title(['SVM One-versus-rest ' featurelib{feature_number}],'Fontsize',24,'Fontname','Times New Roman');
