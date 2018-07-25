clear all
clc
addpath(genpath('libsvm'));
feature_number = 1;
method_number = 1;
featurelib = {'LBP','HOG','Gabor'};    % 选择特征
slectfeature = featurelib{feature_number};
switch slectfeature
    case 'LBP'
        load LBPfeatureset
        maxvalue = zeros(1,length(LBPfeature));
        minvalue = zeros(1,length(LBPfeature));
        for i = 1:length(LBPfeature)
            maxvalue(i) = max(LBPfeature(i).data);
            minvalue(i) = min(LBPfeature(i).data);        
        end
        totalmaxvalue = max(maxvalue);
        totalminvalue = min(minvalue);
        data = zeros(length(LBPfeature),length(LBPfeature(1).data));
        label = zeros(length(LBPfeature),1);
        scale = totalmaxvalue - totalminvalue;
        inter = totalmaxvalue + totalminvalue;
        for i = 1:length(LBPfeature)
            data(i,:) = (LBPfeature(i).data * 2 - inter) / scale;
            label(i,1) = LBPfeature(i).label;
        end
        
        
    case 'HOG'
        load HOGfeatureset
        HOGdata = zeros(length(HOGfeature),length(HOGfeature(1).data) * length(HOGfeature(1).data{1,1}));
        HOGlabel = zeros(length(HOGfeature),1);
        patch = length(HOGfeature(1).data{1,1});
        for i = 1:length(HOGfeature)
            HOGlabel(i) = HOGfeature(i).label;
            for j = 1:length(HOGfeature(1).data)
                HOGdata(i,(j-1)*patch+1:j*patch) = HOGfeature(i).data{1,j};              
            end           
        end
        for i = 1:length(HOGfeature)
            maxvalue(i) = max(HOGdata(i,:));
            minvalue(i) = min(HOGdata(i,:));        
        end
        totalmaxvalue = max(maxvalue);
        totalminvalue = min(minvalue);
        scale = totalmaxvalue - totalminvalue;
        inter = totalmaxvalue + totalminvalue;
        data = zeros(length(HOGfeature),length(HOGfeature(1).data) * length(HOGfeature(1).data{1,1}));
        label = zeros(length(HOGfeature),1);
        for i = 1:length(HOGfeature)
            data(i,:) = (HOGdata(i,:) .* 2 - inter) / scale;
            label(i,1) = HOGfeature(i).label;
        end

    case 'Gabor'
        load Gaborfeatureset  
        Gabordata = zeros(length(Gaborfeature),length(Gaborfeature(1).data) * length(Gaborfeature(1).data{1,1}));
        Gaborlabel = zeros(length(Gaborfeature),1);
        patch = length(Gaborfeature(1).data{1,1});
        for i = 1:length(Gaborfeature)
            Gaborlabel(i) = Gaborfeature(i).label;
            for j = 1:length(Gaborfeature(1).data)
                Gabordata(i,(j-1)*patch+1:j*patch) = Gaborfeature(i).data{1,j};              
            end           
        end
        for i = 1:length(Gaborfeature)
            maxvalue(i) = max(Gabordata(i,:));
            minvalue(i) = min(Gabordata(i,:));        
        end
        totalmaxvalue = max(maxvalue);
        totalminvalue = min(minvalue);
        scale = totalmaxvalue - totalminvalue;
        inter = totalmaxvalue + totalminvalue;
        data = zeros(length(Gaborfeature),length(Gaborfeature(1).data) * length(Gaborfeature(1).data{1,1}));
        label = zeros(length(Gaborfeature),1);
        for i = 1:length(Gaborfeature)
            data(i,:) = (Gabordata(i,:) .* 2 - inter) / scale;
            label(i,1) = Gaborfeature(i).label;
        end   
end
methodlib = {'one_versus_rest','one_versus_one','DAG_svm'};   % 选择分类方式
slectmethod = methodlib{method_number};
switch slectmethod
    case 'one_versus_rest'
        tic;
        confusion = one_versus_rest( data, label );
        toc;
        
    case 'one_versus_one'
        tic;
        accurancy = one_versus_one( data, label );
        toc;
        
    case 'DAG_svm'
        tic;
        accuracy = DAG_svm( data, label ); 
        toc;

end


