function [pflag,err_pflag] = Verify_pflag(pflag)  
err_pflag = 1;  
if isempty(pflag) 
    pflag = 0;  
elseif pflag~=0 && pflag~=1
    disp('Plot flag must be either 0 or 1!/n');  
    return;  
end  
err_pflag = 0;  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%% End of Verify_pflag %%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
end

