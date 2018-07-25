function [W,M,V] = Maximization(X,k,E)
[n,d] = size(X);  
W = zeros(1,k); M = zeros(d,k);  
V = zeros(d,d,k);  
for i=1:k  % Compute weights     
    for j=1:n
        W(i) = W(i) + E(j,i);  
        M(:,i) = M(:,i) + E(j,i)*X(j,:)';  
    end  
    M(:,i) = M(:,i)/W(i);  
end  
for i=1:k 
    for j=1:n 
        dXM = X(j,:)'-M(:,i);  
        V(:,:,i) = V(:,:,i) + E(j,i)*dXM*dXM';  
    end  
    V(:,:,i) = V(:,:,i)/W(i);  
end  
W = W/n;  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%% End of Maximization %%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
end

