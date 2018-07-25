function accuracy = one_versus_one( data, label )
%% one-versus-one分类
%训练时选择一个类的样本为正样本，负样本则只选择一个类，可以构造出k(k-1)/2个分类器，虽然分类器的数组增加了，但是训练阶段所用总时间较少
%% 训练
class = 10;
train_number = 300;
totalnumber = 480;
options = {'-t 2 -c 900 -g 0.05'};
count = 0;
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
%% 测试
label_matrix = [];
for k = 1:class
    start = (k-1)*totalnumber + train_number + 1;
    test_data = data(start:totalnumber*k,:);
    test_label = ones(totalnumber - train_number,1);
    for i = 1:class
        if i ~= k
            [predict_label_L, accuracy_L, dec_values_L] = svmpredict(test_label, test_data, model(k,i));    % 训练集准确率 
            if k < i
                label_matrix = [label_matrix predict_label_L];
            elseif k > i
                label_matrix = [label_matrix -predict_label_L];
            end
        end
    end
    
    size(label_matrix)
    result_label = sum(label_matrix,2);
    accuracy(k) = sum(result_label > 0) / (totalnumber - train_number);
    label_matrix = [];
    
end
end

