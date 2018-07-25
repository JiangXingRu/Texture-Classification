function [maxiter,err_maxiter] = Verify_maxiter(maxiter)  
err_maxiter = 1;  
if isempty(maxiter) 
    maxiter = 1000;  
elseif ~isreal(maxiter) || maxiter<=0 
    disp('ltol must be a positive real number!');  
    return;  
end  
err_maxiter = 0;  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%% End of Verify_maxiter %%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
end

