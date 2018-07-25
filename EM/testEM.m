clear all
clc

X = zeros(600,20);  
X(1:200,:) = normrnd(0,1,200,20);  
X(201:400,:) = normrnd(1,1,200,20);  
X(401:600,:) = normrnd(4,1,200,20);  
[W,M,V,L] = EM_GM(X,5,[],[],1,[]) 