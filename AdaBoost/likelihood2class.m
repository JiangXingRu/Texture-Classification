function classes = likelihood2class(likelihoods)   
%   
% LIKELIHOODS TO CLASSES   
%   
% classes = likelihood2class(likelihoods)   
%   
%   Find the class assignment of the samples from the likelihoods   
%   'likelihoods' an NxD matrix where N is the number of samples and   
%   D is the dimension of the feature space. 'likelihoods(i,j)' is   
%   the i-th samples likelihood of belonging to class-j.   
%   
%   'classes' contains the class index of the each sample maximum likelihood   
%   
% Bug Reporting: Please contact the author for bug reporting and comments.   
%   
% Cuneyt Mertayak   
% email: cuneyt.mertayak@gmail.com   
% version: 1.0   
% date: 21/05/2007   
%   
   
[sample_n,class_n] = size(likelihoods);   
maxs = (likelihoods==repmat(max(likelihoods,[],2),[1,class_n]));   
   
classes=zeros(sample_n,1);   
for i=1:sample_n   
  classes(i) = find(maxs(i,:),1);   
end  
end

