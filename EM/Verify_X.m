function err_X = Verify_X( X )
err_X = 1;  
[n,d] = size(X);  
if n<d
   disp('Input data must be n x d!/n');  
   return;  
end  
err_X = 0;  
%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%% End of Verify_X %%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%  
end

