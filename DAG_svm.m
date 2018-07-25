function accuracy = DAG_svm( data, label )
%% 基于有向无环图的svm
% 类似于"one-versus-one"方法，只是对一个样本分类之前，先按照有向无环图组织分类器


%% 训练
class = 10;
train_number = 300;
totalnumber = 480;
test_number = totalnumber - train_number;
options = {'-t 2 -c 900 -g 0.05'};
count = 0;    %分类器数目
for i = 1:class-1
    for j = i+1:class
        start = (i-1)*totalnumber + 1;
        pos_train_data = data(start:start + train_number - 1,:);
        pos_train_label = ones(train_number,1);
        neg_train_data = data((j-1)*totalnumber+1:j*totalnumber,:);
        neg_train_label = -ones(totalnumber,1);
        train_data = [pos_train_data;neg_train_data];
        train_label = [pos_train_label;neg_train_label];
        model(i,j) = svmtrain(train_label, sparse(train_data), '-t 2 -c 800 -g 0.05');
        model(j,i) = model(i,j);
%         [predict_label_L, accuracy_L, dec_values_L] = svmpredict(train_label, train_data, model(i,j));    % 训练集准确率
        count = count + 1;      
    end
end
%% 有向无环图测试
% class = 1
% test_number = 1
for k = 1:class
    start = (k-1)*totalnumber + train_number + 1;   
    test_data = data(start:totalnumber*k,:);
    test_label = ones(test_number,1);
    left_class = 1;
    right_class = class;
    true_number = 0;
    for i = 1:test_number
        while (right_class - left_class) ~= 0
            [predict_label_L, accuracy_L, dec_values_L] = svmpredict(test_label(i), sparse(test_data(i,:)), model(left_class,right_class));          
            if predict_label_L == -1
                left_class = left_class + 1;               
            elseif predict_label_L == 1
                right_class = right_class-1;               
            end
        end
        true_number = true_number + (left_class == k);
    end
    accuracy(k) = true_number / test_number;   
end
end

