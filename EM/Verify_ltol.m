function [ltol,err_ltol] = Verify_ltol(ltol)  
err_ltol = 1;  
if isempty(ltol)
    ltol = 0.1;  
elseif ~isreal(ltol) || ltol<=0    
    disp('ltol must be a positive real number!');  
    return;  
end  
err_ltol = 0; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%% End of Verify_ltol %%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
end

