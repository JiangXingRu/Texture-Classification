function E = Expectation( X,k,W,M,V )
[n,d] = size(X);  
a = (2*pi)^(0.5*d);  
S = zeros(1,k);  
iV = zeros(d,d,k);  
for j=1:k     
    if V(:,:,j)==zeros(d,d)
        V(:,:,j)=ones(d,d)*eps;
    end  
    S(j) = sqrt(det(V(:,:,j)));  
    iV(:,:,j) = inv(V(:,:,j));  
end  
E = zeros(n,k);  
for i=1:n   
    for j=1:k
        dXM = X(i,:)'-M(:,j);  
        pl = exp(-0.5*dXM'*iV(:,:,j)*dXM)/(a*S(j));  
        E(i,j) = W(j)*pl;  
    end  
    E(i,:) = E(i,:)/sum(E(i,:));  
end  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%% End of Expectation %%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
end

