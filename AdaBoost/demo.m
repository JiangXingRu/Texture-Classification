clear;clc;  
addpath(genpath('AdaBoost'));
%  
% DEMONSTRATION OF ADABOOST_tr and ADABOOST_te  
%  
% Just type "demo" to run the demo.  
%  
% Using adaboost with linear threshold classifier  
% for a two class classification problem.  
%  
% Bug Reporting: Please contact the author for bug reporting and comments.  
%  
% Cuneyt Mertayak  
% email: cuneyt.mertayak@gmail.com  
% version: 1.0  
% date: 21/05/2007  
% Creating the training and testing sets  
%  
tr_n = 200;  
te_n = 200;  
weak_learner_n = 20;  
  
tr_set = abs(rand(tr_n,2))*100;  
te_set = abs(rand(te_n,2))*100;  
  
tr_labels = (tr_set(:,1)-tr_set(:,2) > 0) + 1;  
te_labels = (te_set(:,1)-te_set(:,2) > 0) + 1;  
  
% Displaying the training and testing sets  
figure;  
subplot(2,2,1);  
hold on; axis square;  
indices = tr_labels==1;  
plot(tr_set(indices,1),tr_set(indices,2),'b*');  
indices = ~indices;  
plot(tr_set(indices,1),tr_set(indices,2),'r*');  
title('Training set');  
  
subplot(2,2,2);  
hold on; axis square;  
indices = te_labels==1;  
plot(te_set(indices,1),te_set(indices,2),'b*');  
indices = ~indices;  
plot(te_set(indices,1),te_set(indices,2),'r*');  
title('Testing set');  
  
% Training and testing error rates  
tr_error = zeros(1,weak_learner_n);  
te_error = zeros(1,weak_learner_n);  
  
for i=1:weak_learner_n  
    adaboost_model = ADABOOST_tr(@threshold_tr,@threshold_te,tr_set,tr_labels,i);  
    % —µ¡∑—˘±æ≤‚ ‘  
    [L_tr,hits_tr] = ADABOOST_te(adaboost_model,@threshold_te,tr_set,tr_labels);  
    tr_error(i) = (tr_n-hits_tr)/tr_n;  
    % ≤‚ ‘—˘±æ≤‚ ‘  
    [L_te,hits_te] = ADABOOST_te(adaboost_model,@threshold_te,te_set,te_labels);  
    te_error(i) = (te_n-hits_te)/te_n;  
end  
  
subplot(2,2,3);  
plot(1:weak_learner_n,tr_error);  
axis([1,weak_learner_n,0,1]);  
title('Training Error');  
xlabel('weak classifier number');  
ylabel('error rate');  
grid on;  
  
subplot(2,2,4); axis square;  
plot(1:weak_learner_n,te_error);  
axis([1,weak_learner_n,0,1]);  
title('Testing Error');  
xlabel('weak classifier number');  
ylabel('error rate');  
grid on;  