function [Init,err_Init] = Verify_Init(Init)  
err_Init = 1;  
if isempty(Init)  
 % Do nothing;  
elseif isstruct(Init) 
    [Wd,Wk] = size(Init.W);  
    [Md,Mk] = size(Init.M);  
    [Vd1,Vd2,Vk] = size(Init.V);  
    if Wk~=Mk || Wk~=Vk || Mk~=Vk
        disp('k in Init.W(1,k), Init.M(d,k) and Init.V(d,d,k) must equal!/n')  
        return  
    end  
    if Md~=Vd1 || Md~=Vd2 || Vd1~=Vd2
        disp('d in Init.W(1,k), Init.M(d,k) and Init.V(d,d,k) must equal!/n')  
       return  
    end  
else  
    disp('Init must be a structure: W(1,k), M(d,k), V(d,d,k) or []!');  
    return  
end  
err_Init = 0;  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%% End of Verify_Init %%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
end

