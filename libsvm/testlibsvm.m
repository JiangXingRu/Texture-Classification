clear all
clc
[heart_scale_label, heart_scale_inst] = libsvmread('C:/Users/JXR/Desktop/Wavelet Image Retrieval/Example/matlab/heart_scale');
% Split Data
train_data = heart_scale_inst(1:150,:);
train_label = heart_scale_label(1:150,:);
test_data = heart_scale_inst(151:270,:);
test_label = heart_scale_label(151:270,:);

% Linear Kernel
model_linear = svmtrain(train_label, train_data, '-t 3');
[predict_label_L, accuracy_L, dec_values_L] = svmpredict(test_label, test_data, model_linear);
str1 = {'Bob';'Smith';'Alien'};
str2 = {'cleaner';'programmer';'scientist'};
nums = [30;40;200];
T = table;
T.Name = str1;
T.job = str2;
T.age = nums;
T
