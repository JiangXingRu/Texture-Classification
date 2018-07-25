clear all;
clc;
addpath(genpath('.\ksvdbox'));  % 添加KSVD工具箱
addpath(genpath('.\OMPbox')); % 添加稀疏编码算法OMP算法工具箱
feature_number = 3;
featurelib = {'LBP','HOG','Gabor'};    % 选择特征
slectfeature = featurelib{feature_number};
class = 10;                            % 待分类的类别数
%% 进行特征选择
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
%% 训练集和测试集选取
train_number = 240;               % 每一类训练样本数
samplenum = size(label,1);                                  % 样本总数
train_data = zeros(class * train_number,size(data,2));      % 为训练集与测试集分配空间
test_data = zeros(samplenum - class * train_number,size(data,2));

eachClass = zeros(class,1);
for i = 1:class                             % 统计每一类样本数量
    for j = 1:samplenum
        if(label(j)==i)
            eachClass(i) = eachClass(i)+1;
        end
    end
end

mk = 0;
m = 0;
for j = 1:class
    randIdx = randperm(eachClass(j));        % 随机排列样本序号
    b_train = randIdx(1:train_number);             % 划分测试样本序号和训练样本序号
    b_test = randIdx(train_number+1:eachClass(j));
    train_index = mk+b_train;       % 训练样本和测试样本序号
    test_index = mk+b_test;
       
    train_data(((j-1)*train_number+1):j*train_number,:) = data(train_index,:); 
    train_data_label(((j-1)*train_number+1):j*train_number,1)=j;
    p=eachClass(j,1)-train_number;    % 每一类的测试样本数
    
    test_data(m+1:m+p,:) = data(test_index,:);
    test_data_label(m+1:m+p,1)=j;
    m=m+(eachClass(j,1)-train_number);
    mk=mk+eachClass(j);
end
%% 设置类标矩阵
[numtrain,at]=size(train_data_label);
[numtest,bt]=size(test_data_label);
H_test=zeros(class,numtest);
H_train=zeros(class,numtrain);
for j=1:numtrain
    a=train_data_label(j);
    H_train(a,j)=1;
end
for j=1:numtest
    b=test_data_label(j);
    H_test(b,j)=1;
end
%% 训练集和测试集归一化

for i = 1:size(train_data,1)
    train_data(i,:) = train_data(i,:) / norm(train_data(i,:));
end

for i = 1:size(test_data,1)
    test_data(i,:) = test_data(i,:) / norm(test_data(i,:));
end

%% 进行K-SVD训练
sumd = 0;
sparsitythres = 15;
for dictsize = 100:100:3000
    
    sumd=sumd+1;
    params.data = train_data';
    params.Tdata = sparsitythres;
    params.dictsize = dictsize;

    params.memusage = 'high';
    for iternum=20%10:20:50
        params.iternum = iternum;
        for alpha1=7%1:10
            alpha= 10^(alpha1-6);
            [D1,S,err,gerr] = ksvd(params,'');
            S=normcols(S);
            WRinit = inv(S*S'+alpha*eye(size(S*S')))*S*H_train';
            WRinit = WRinit';
            WRinit=normcols(WRinit);
%% 进行分类测试
            [prediction1,accuracy] = classification(D1, WRinit, test_data', H_test, sparsitythres);
            fprintf('\n K-SVD is : %.03f,%.03f,%.03f', dictsize,alpha1,iternum,accuracy);
            b=fopen('ceshi.txt','a+');
            fprintf(b,'%.03f,%.03f,%.03f,%.03f\r\n',dictsize,alpha1,iternum,accuracy);
            fclose(b);
        end % alpha
    end %iternum
    rec(1,sumd)=accuracy
    
end
Ravg = mean(rec);                  % average recognition rate
Rstd = std(rec);                   % standard deviation of the recognition rate
fprintf('===============================================');
fprintf('Average classification accuracy: %f\n', Ravg);
fprintf('Standard deviation: %f\n', Rstd);    
fprintf('===============================================');
b=fopen('averceshi.txt','a+');
fprintf(b,' %.03f,%.03f,\r\n',Ravg, Rstd);
fclose(b);
plot(1:sumd,rec);
    









