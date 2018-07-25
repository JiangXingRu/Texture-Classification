clear all;
clc;
addpath(genpath('EM'));
feature_number = 1;
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
%% 混合高斯聚类
gauss_number = 10;
pca_dim = 60;
[COEFF SCORE latent] = pca(data);
pcadata = SCORE(:,1:pca_dim);

[W,M,V,L] = EM_GM(pcadata,gauss_number,[],[],0,[]);
p = zeros(length(pcadata(:,1)),gauss_number);
P = zeros(length(pcadata(:,1)),gauss_number);
pm = zeros(1,length(pcadata(:,1)));
for i = 1:length(pcadata(:,1))
    x = pcadata(i,:);
    for j = 1:gauss_number
        residual = x' - M(:,j);
        coff = 0.5 * residual' * inv(V(:,:,j)) * residual;
        p(i,j) = W(j) / (sqrt((2*pi)^pca_dim * abs(det(V(:,:,j)))) * exp(coff));
        pm(i) = pm(i) + p(i,j);       
    end
    for j = 1:gauss_number
        P(i,j) = p(i,j) / pm(i);      
    end    
end
save statistic P
for i = 1:length(P(:,1))
    [maxr index] = max(P(i,:));
    Index(i) = index;
end
class = 10;
patch = length(P(:,1)) / class;
gauss_number = 10;
hist = zeros(class,gauss_number);
for k = 1:class
    coutstart = (k-1)*patch+1;
    coutend = k*patch;
    for i = coutstart:coutend
        for j = 1:gauss_number
            if Index(i) == j
                hist(k,j) = hist(k,j)+1;
            end
        end
    end
end




%% 对每一类样本建立混合高斯模型
% gauss_number = 1;       % 混合高斯模型中包含的高斯模型数目
% train_number = 384;
% total_number = 480;
% test_number = total_number - train_number;
% pca_dim = 200;

% for i= 1:class
% 
%     train_set = data((i-1)*total_number+1:(i-1)*total_number+train_number,:);   % 训练集
%     [COEFF SCORE latent] = pca(train_set);
%     PCAtrain_data = SCORE(:,1:pca_dim);
%     [W,M,V,L] = EM_GM(PCAtrain_data,gauss_number,[],[],0,[]);
%     GaussModel{i}.W = W;
%     GaussModel{i}.M = M;
%     GaussModel{i}.V = V;
%     GaussModel{i}.label = i;
%     
% end






