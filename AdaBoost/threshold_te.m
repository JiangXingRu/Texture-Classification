function [L,hits,error_rate] = threshold_te(model,test_set,sample_weights,true_labels)  
%  
% TESTING THRESHOLD CLASSIFIER  
%  
%    Testing of the basic linear classifier where seperation hyperplane is  
%  perpedicular to one dimension.  
%  
%  [L,hits,error_rate] = threshold_te(model,test_set,sample_weights,true_labels)  
%  
%   model: the model that is outputed from threshold_tr. It consists of  
%    1) min_error: training error  
%    2) min_error_thr: threshold value  
%    3) pos_neg: whether up-direction shows the positive region (label:2, 'pos') or  
%     the negative region (label:1, 'neg')  
%   test_set: an NxD-matrix, each row is a testing sample in the D dimensional feature  
%    space.  
%   sample_weights:  an  Nx1-vector,  each  entry  is  the  weight  of  the  corresponding  test sample  
%   true_labels: Nx1 dimensional vector, each entry is the corresponding label (either 1 or 2)  
%  
%   L: an Nx2-matrix showing likelihoods of each class  
%   hits: the number of hits  
%   error_rate: the error rate with the sample weights  
%  
%  
% Bug Reporting: Please contact the author for bug reporting and comments.  
%  
% Cuneyt Mertayak  
% email: cuneyt.mertayak@gmail.com  
% version: 1.0  
% date: 21/05/2007  
  
feat = test_set(:,model.dim);  
if(strcmp(model.pos_neg,'pos'))  
    ind = (feat>model.min_error_thr)+1;  
else  
    ind = (feat<model.min_error_thr)+1;  
end  
  
hits = sum(ind==true_labels);  
error_rate = sum(sample_weights(ind~=true_labels));  
  
L = zeros(length(feat),2);  
L(ind==1,1) = 1;  
L(ind==2,2) = 1;  
end

