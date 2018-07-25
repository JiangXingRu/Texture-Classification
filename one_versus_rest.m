function confusion = one_versus_rest( data, label )
%% one-versus-rest 分类
%训练时，依次把某个类别的样本归为一类，其它剩余的归为另一类
%预测时，将未知样本分类为具有最大分类函数值的那一类
% number = length(label);
class = 10;
train_number = 300;
totalnumber = 480;
options = {'-t 2 -c 800 -g 0.05'};
%% 训练
for i = 1:class
    start = (i-1)*totalnumber + 1;
    pos_train_data = data(start:start+train_number - 1,:);
%     pos_train_label = label(start:start+train_number,:);
    pos_train_label = ones(train_number,1);
    % neg_train_data = data(totalnumber+1:end,:);
    % neg_train_label = -ones(length(label) - totalnumber,1);
    if i == 1
        neg_train_data = data(totalnumber+1:length(label),:);
    elseif i == class
        neg_train_data = data(1:length(label) - totalnumber,:);
    else
        neg_train_data = [data(1:start - 1,:);data(start + totalnumber:length(label),:)];
    end
%     size(neg_train_data)
    
    neg_train_label = -ones(length(label) - totalnumber,1);
    train_data = [pos_train_data;neg_train_data];
    train_label = [pos_train_label;neg_train_label];   
    model(i) = svmtrain(train_label, sparse(train_data), '-t 2 -c 800 -g 0.05');

    test_label = ones(totalnumber - train_number,1);
    test_data = data(train_number+start:totalnumber * i,:);
    testset(i).test_label = test_label;
    testset(i).test_data = sparse(test_data);
%     [predict_label_L, accuracy_L, dec_values_L] = svmpredict(train_label, train_data, model(i));    % 训练集准确率
%     [predict_label_L, accuracy_L, dec_values_L] = svmpredict(testset(i).test_label, testset(i).test_data, model(i)); % 测试集准确率
end
%% 混淆矩阵
confusion = zeros(class,class);
for i = 1:class
    for j = 1:class
        [predict_label_L, accuracy_L, dec_values_L] = svmpredict(testset(i).test_label, testset(i).test_data, model(j)); % 测试集准确率       
        confusion(i,j) = accuracy_L(1);
    end
end

end

