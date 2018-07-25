function err_k = Verify_k(k)  
err_k = 1;  
if ~isnumeric(k) || ~isreal(k) || k<1  
    disp('k must be a real integer >= 1!/n');  
    return;  
end  
err_k = 0;  
%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%% End of Verify_k %%%%  
%%%%%%%%%%%%%%%%%%%%%%%%% 
end

