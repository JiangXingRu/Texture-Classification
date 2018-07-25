function model = threshold_tr(train_set, sample_weights, labels)  
%  
% TRAINING THRESHOLD CLASSIFIER  
%  
%  Training of the basic linear classifier where seperation hyperplane  
%  is perpedicular to one dimension.  
%  
%  model = threshold_tr(train_set, sample_weights, labels)  
%   train_set: an NxD-matrix, each row is a training sample in the D dimensional feature  
%            space.  
%        sample_weights: an Nx1-vector, each entry is the weight of the corresponding training sample  
%        labels: Nx1 dimensional vector, each entry is the corresponding label (either 1 or 2)  
%  
%        model: the ouput model. It consists of  
%            1) min_error: training error  
%            2) min_error_thr: threshold value  
%            3) pos_neg: whether up-direction shows the positive region (label:2, 'pos') or  
%                the negative region (label:1, 'neg')  
%  
% Bug Reporting: Please contact the author for bug reporting and comments.  
%  
% Cuneyt Mertayak  
% email: cuneyt.mertayak@gmail.com  
% version: 1.0  
% date: 21/05/2007  
  
model = struct('min_error',[],'min_error_thr',[],'pos_neg',[],'dim',[]);  
  
sample_n = size(train_set,1);  
min_error = sum(sample_weights);  
min_error_thr = 0;  
pos_neg = 'pos';  
  
% for each dimension  
for dim=1:size(train_set,2)  
    sorted = sort(train_set(:,dim),1,'ascend');  
      
    % for each interval in the specified dimension  
    for i=1:(sample_n+1)  
        if(i==1)  
            thr = sorted(1)-0.5;  
        elseif(i==sample_n+1)  
            thr = sorted(sample_n)+0.5;  
        else  
            thr = (sorted(i-1)+sorted(i))/2;  
        end  
          
        ind1 = train_set(:,dim) < thr;  
        ind2 = ~ind1;  
        tmp_err  =  sum(sample_weights((labels.*ind1)==2))+sum(sample_weights((labels.*ind2)==1));  
          
        if(tmp_err < min_error)  
            min_error = tmp_err;  
            min_error_thr = thr;  
            pos_neg = 'pos';  
            model.dim = dim;  
        end  
          
        ind1 = train_set(:,dim) < thr;  
        ind2 = ~ind1;  
        tmp_err  =  sum(sample_weights((labels.*ind1)==1))+sum(sample_weights((labels.*ind2)==2));  
          
        if(tmp_err < min_error)  
            min_error = tmp_err;  
            min_error_thr = thr;  
            pos_neg = 'neg';  
            model.dim = dim;  
        end  
    end  
end  
  
model.min_error = min_error;  
model.min_error_thr = min_error_thr;  
model.pos_neg = pos_neg; 
end

