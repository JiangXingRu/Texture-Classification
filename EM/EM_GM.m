function [ W,M,V,L ] = EM_GM( X,k,ltol,maxiter,pflag,Init ) 
% [W,M,V,L] = EM_GM(X,k,ltol,maxiter,pflag,Init)  
%  
% EM algorithm for k multidimensional Gaussian mixture estimation  
%  
% Inputs:  
%   X(n,d) - input data, n=number of observations, d=dimension of variable  
%   k - maximum number of Gaussian components allowed  
%   ltol - percentage of the log likelihood difference between 2 iterations ([] for none)  
%   maxiter - maximum number of iteration allowed ([] for none)  
%   pflag - 1 for plotting GM for 1D or 2D cases only, 0 otherwise ([] for none)  
%   Init - structure of initial W, M, V: Init.W, Init.M, Init.V ([] for none)  
%  
% Ouputs:  
%   W(1,k) - estimated weights of GM  
%   M(d,k) - estimated mean vectors of GM  
%   V(d,d,k) - estimated covariance matrices of GM  
%   L - log likelihood of estimates  
%  
% Written by  
%   Patrick P. C. Tsui,  
%   PAMI research group  
%   Department of Electrical and Computer Engineering  
%   University of Waterloo,  
%   March, 2006  
% 
%%%% Validate inputs %%%%
if nargin <= 1 
    disp('EM_GM must have at least 2 inputs: X,k!/n') 
    return;
elseif nargin == 2
    ltol = 0.1; maxiter = 1000; pflag = 0; Init = [];  
    err_X = Verify_X(X);  
    err_k = Verify_k(k);  
    if err_X || err_k
        return;
    end  
elseif nargin == 3 
    maxiter = 1000; pflag = 0; Init = [];  
    err_X = Verify_X(X);  
    err_k = Verify_k(k);  
    [ltol,err_ltol] = Verify_ltol(ltol);  
    if err_X || err_k || err_ltol
        return;
    end  
elseif nargin == 4 
    pflag = 0;  Init = [];  
    err_X = Verify_X(X);  
    err_k = Verify_k(k);  
    [ltol,err_ltol] = Verify_ltol(ltol);  
    [maxiter,err_maxiter] = Verify_maxiter(maxiter);  
    if err_X || err_k || err_ltol || err_maxiter
        return; 
    end  
elseif nargin == 5
    Init = [];  
    err_X = Verify_X(X);  
    err_k = Verify_k(k);  
    [ltol,err_ltol] = Verify_ltol(ltol);  
    [maxiter,err_maxiter] = Verify_maxiter(maxiter);  
    [pflag,err_pflag] = Verify_pflag(pflag);  
    if err_X || err_k || err_ltol || err_maxiter || err_pflag
        return; 
    end  
elseif nargin == 6 
    err_X = Verify_X(X);  
    err_k = Verify_k(k);  
    [ltol,err_ltol] = Verify_ltol(ltol);  
    [maxiter,err_maxiter] = Verify_maxiter(maxiter);  
    [pflag,err_pflag] = Verify_pflag(pflag);  
    [Init,err_Init]=Verify_Init(Init);  
    if err_X || err_k || err_ltol || err_maxiter || err_pflag || err_Init
        return; 
    end  
else  
    disp('EM_GM must have 2 to 6 inputs!');  
    return; 
end  
   
%%%% Initialize W, M, V,L %%%%  
t = cputime;  
if isempty(Init)    
    [W,M,V] = Init_EM(X,k); 
    L = 0;  
else  
    W = Init.W;  
    M = Init.M;  
    V = Init.V;  
end  
Ln = Likelihood(X,k,W,M,V); % Initialize log likelihood  
Lo = 2*Ln;  
   
%%%% EM algorithm %%%%  
niter = 0;  
while (abs(100*(Ln-Lo)/Lo)>ltol) && (niter<=maxiter)
    E = Expectation(X,k,W,M,V); % E-step  
    [W,M,V] = Maximization(X,k,E);  % M-step  
    Lo = Ln;  
    Ln = Likelihood(X,k,W,M,V);  
    niter = niter + 1;  
end  
L = Ln;  
   
%%%% Plot 1D or 2D %%%%  
if pflag==1
   [n,d] = size(X);  
   if d > 2  
      disp('Can only plot 1 or 2 dimensional applications!/n');  
   else  
      Plot_GM(X,k,W,M,V);  
   end  
   elapsed_time = sprintf('CPU time used for EM_GM: %5.2fs',cputime-t);  
   fprintf(elapsed_time);  
   fprintf('Number of iterations: %d',niter-1);  
end  
%%%%%%%%%%%%%%%%%%%%%%  
%%%% End of EM_GM %%%%  
%%%%%%%%%%%%%%%%%%%%%% 
end

