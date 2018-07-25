function L = Likelihood( X,k,W,M,V )
% Compute L based on K. V. Mardia, "Multivariate Analysis", Academic Press, 1979, PP. 96-97  
% to enchance computational speed  
[n,d] = size(X);  
U = mean(X)';  
S = cov(X);  
L = 0;  
for i=1:k
    iV = inv(V(:,:,i));  
    L = L + W(i)*(-0.5*n*log(det(2*pi*V(:,:,i))) ...  
        -0.5*(n-1)*(trace(iV*S)+(U-M(:,i))'*iV*(U-M(:,i))));  
end  
%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%% End of Likelihood %%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%  
end

