
function dC=fun_s_mod123(t,C,k_on,k_off)
% Description: This function that computes the time-derivative of the
% system, given the model

mG = C(1) ;  mG_act = C(2); 
tG = C(3);   tG_act = C(4);
tGEF = C(5); tGEF_act =C(6);
mGAP = C(7); mGAP_act = C(8);
tGAP = C(9); tGAP_act = C(10);
mGEF = C(11); mGEF_act = C(12);


dC = [ - k_on*mGEF_act*mG + k_off*mGAP_act*mG_act
         k_on*mGEF_act*mG - k_off*mGAP_act*mG_act - k_on*tGEF*mG_act
       - k_on*tGEF_act*tG + k_off*tGAP_act*tG_act
         k_on*tGEF_act*tG - k_off*tGAP_act*tG_act - k_on*mGAP*tG_act
       - k_on*tGEF*mG_act
         k_on*tGEF*mG_act - k_on*tGEF_act*mGAP
       - k_on*mGAP*tG_act - k_on*tGEF_act*mGAP
         k_on*mGAP*tG_act + k_on*tGEF_act*mGAP
         0
         0
         0
         0 ];
     
%% OLD MODEL      
%      dC = [ - k_on*mGEF_act*mG + k_off*mGAP_act*mG_act
%          k_on*mGEF_act*mG - k_off*mGAP_act*mG_act - k_on*tGEF*mG_act
%        - k_on*tGEF_act*tG + k_off*tGAP_act*tG_act
%          k_on*tGEF_act*tG - k_off*tGAP_act*tG_act %- k_on*mGAP*tG_act
%        - k_on*tGEF*mG_act
%          k_on*tGEF*mG_act %- k_on*tGEF_act*mGAP
%          0 %- k_on*mGAP*tG_act - k_on*tGEF_act*mGAP
%          0 %k_on*mGAP*tG_act + k_on*tGEF_act*mGAP
%          0
%          0
%          0
%          0 ];
end


