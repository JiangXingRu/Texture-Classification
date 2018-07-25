function Plot_GM(X,k,W,M,V)  
[n,d] = size(X);  
if d>2
    disp('Can only plot 1 or 2 dimensional applications!/n');  
    return;  
end  
S = zeros(d,k);  
R1 = zeros(d,k);  
R2 = zeros(d,k);  
for i=1:k % Determine plot range as 4 x standard deviations  
    S(:,i) = sqrt(diag(V(:,:,i)));  
    R1(:,i) = M(:,i)-4*S(:,i);  
    R2(:,i) = M(:,i)+4*S(:,i);  
end  
Rmin = min(min(R1));  
Rmax = max(max(R2));  
R = Rmin:0.001*(Rmax-Rmin):Rmax;  
clf, hold on  
if d==1
    Q = zeros(size(R));  
    for i=1:k 
        P = W(i)*normpdf(R,M(:,i),sqrt(V(:,:,i)));  
        Q = Q + P;  
        plot(R,P,'r-'); grid on,  
    end  
    plot(R,Q,'k-');  
    xlabel('X');  
    ylabel('Probability density');  
else % d==2  
    plot(X(:,1),X(:,2),'r.');  
    for i=1:k
        Plot_Std_Ellipse(M(:,i),V(:,:,i));  
    end  
    xlabel('1^{st} dimension');  
    ylabel('2^{nd} dimension');  
    axis([Rmin Rmax Rmin Rmax])  
end  
title('Gaussian Mixture estimated by EM');  
%%%%%%%%%%%%%%%%%%%%%%%%  
%%%% End of Plot_GM %%%%  
%%%%%%%%%%%%%%%%%%%%%%%%  
end

