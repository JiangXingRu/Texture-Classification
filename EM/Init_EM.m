function [W,M,V] = Init_EM(X,k)  
[n,d] = size(X);  
[Ci,C] = kmeans(X,k,'Start','cluster', ...  
        'Maxiter',100, ...  
        'EmptyAction','drop', ...  
        'Display','off'); % Ci(nx1) - cluster indeices; C(k,d) - cluster centroid (i.e. mean)  
while sum(isnan(C))>0 
    [Ci,C] = kmeans(X,k,'Start','cluster', ...  
        'Maxiter',100, ...  
        'EmptyAction','drop', ...  
        'Display','off');  
end  
M = C';  
Vp = repmat(struct('count',0,'X',zeros(n,d)),1,k);  
for i=1:n % Separate cluster points  
    Vp(Ci(i)).count = Vp(Ci(i)).count + 1;  
    Vp(Ci(i)).X(Vp(Ci(i)).count,:) = X(i,:);  
end  
V = zeros(d,d,k);  
for i=1:k 
    W(i) = Vp(i).count/n;  
    V(:,:,i) = cov(Vp(i).X(1:Vp(i).count,:));  
end  
%%%%%%%%%%%%%%%%%%%%%%%%  
%%%% End of Init_EM %%%%  
%%%%%%%%%%%%%%%%%%%%%%%%  
end

