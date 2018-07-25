clear all;
clc;
addpath(genpath('AdaBoost'));
feature_number = 1;
featurelib = {'LBP','HOG','Gabor'};    % ѡ������
slectfeature = featurelib{feature_number};
weak_learner_number = 30;
class = 10;                            % ������������
%% ��������ѡ��
switch slectfeature
    case 'LBP'
        load LBPfeatureset
        data = zeros(length(LBPfeature),length(LBPfeature(1).data));
        label = zeros(length(LBPfeature),1);
        for i = 1:length(LBPfeature)
            data(i,:) = LBPfeature(i).data;
            label(i,:) = LBPfeature(i).label;
        end
        
    case 'HOG'
        load HOGfeatureset
        data = zeros(length(HOGfeature),length(HOGfeature(1).data) * length(HOGfeature(1).data{1,1}));
        label = zeros(length(HOGfeature),1);
        patch = length(HOGfeature(1).data{1,1});
        for i = 1:length(HOGfeature)
            label(i) = HOGfeature(i).label;
            for j = 1:length(HOGfeature(1).data)
                data(i,(j-1)*patch+1:j*patch) = HOGfeature(i).data{1,j};              
            end           
        end
    case 'Gabor'
        load Gaborfeatureset  
        data = zeros(length(Gaborfeature),length(Gaborfeature(1).data) * length(Gaborfeature(1).data{1,1}));
        label = zeros(length(Gaborfeature),1);
        patch = length(Gaborfeature(1).data{1,1});
        for i = 1:length(Gaborfeature)
            label(i) = Gaborfeature(i).label;
            for j = 1:length(Gaborfeature(1).data)
                data(i,(j-1)*patch+1:j*patch) = Gaborfeature(i).data{1,j};              
            end           
        end
        
end


%% ѵ�����AdaBoost������
% class = 10
for i = 1:class - 1   
    for j = i+1:class
        pos_class = i;     % �����������
        neg_class = j;     % �����������
        total_number = 480;    % ÿ����������
        train_number = 240;    % ÿ������ѵ����������
        train_error = zeros(1,weak_learner_number);    % ѵ�����


        pos_train_set = data((pos_class-1)*total_number+1:(pos_class-1)*total_number+train_number,:);   % ����������ѵ��������ǩ
        pos_train_label = ones(train_number,1);
        neg_train_set = data((neg_class-1)*total_number+1:(neg_class-1)*total_number+train_number,:);   % ���ø�����ѵ��������ǩ
        neg_train_label = 2*ones(train_number,1);
        train_set = [pos_train_set;neg_train_set];
        train_label = [pos_train_label;neg_train_label];
        train_time = zeros(1,weak_learner_number);

        pos_test_set = data((pos_class-1)*total_number+train_number+1:pos_class*total_number,:);% �������������Լ�����ǩ
        pos_test_label = ones(train_number,1);
        neg_test_set = data((neg_class-1)*total_number+train_number+1:neg_class*total_number,:);% ���ø��������Լ�����ǩ
        neg_test_label = 2*ones(train_number,1);
        test_set = [pos_test_set;neg_test_set];
        test_label = [pos_test_label;neg_test_label];
        total_train_number = train_number * 2;
        total_test_number = (total_number - train_number)*2;

        for k = 1:weak_learner_number
            tic;
            model = ADABOOST_tr(@threshold_tr,@threshold_te,train_set,train_label,k);
            % ѵ����������
            [L_tr,hits_tr] = ADABOOST_te(model,@threshold_te,train_set,train_label);
            train_error(k) = (total_train_number - hits_tr)/total_train_number;
            train_time(k) = toc
        end
        AdaBoost_model{i,j}.model = model;
        AdaBoost_model{i,j}.train_error = train_error;
        AdaBoost_model{i,j}.train_time = train_time;
        %% ������������
        [L_te,hits_te] = ADABOOST_te(model,@threshold_te,test_set,test_label);
        test_error = (total_test_number - hits_te)/total_test_number;
        AdaBoost_model{i,j}.test_error = test_error;
    end
end

    
save ADABOOST AdaBoost_model


