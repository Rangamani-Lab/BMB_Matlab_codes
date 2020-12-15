%% This script Compute the eigenvalues of the Jacobian matrix - Arrows 1 and 2


clear all;close all;clc

syms   kon rhomG_off rho1_on rho2_on rhotG_on rhotG_off mGEF_act mGAP_act tGAP_act C mG_act tGEF_act tGEF_tot G_act Tau_act C1 C2 mGAP_tot


Eq_mGact     = (C1- mG_act - tGEF_act - mGAP_act) - rhomG_off*mGAP_act*mG_act - rho1_on*(C2 - tGEF_act - mGAP_act)*mG_act;
Eq_tauact    = rhotG_on*tGEF_act*(1-Tau_act) - rhotG_off*Tau_act;
Eq_tGEFact   = rho1_on*(C2 - tGEF_act - mGAP_act)*mG_act - rho2_on*tGEF_act*(mGAP_tot - mGAP_act);
Eq_mGAPact   = rho2_on*tGEF_act*(mGAP_tot - mGAP_act);


Jac      = jacobian([Eq_mGact, Eq_tauact, Eq_tGEFact, Eq_mGAPact], [mG_act, Tau_act, tGEF_act,mGAP_act]);


%% SS CASE 1: C1 > mGAPtot, C2>C1
mG_act_1   = 0;
Tau_act_1  = (rhotG_on*(C1 - mGAP_tot))/(rhotG_on*(C1 - mGAP_tot) + rhotG_off);
tGEF_act_1 = C1 - mGAP_tot;
mGAP_act_1 = mGAP_tot; 


%% SS CASE 2: C2 > mGAPtot, C1>C2
mG_act_2   = (1/(1 + rhomG_off*mGAP_tot))*(C1 - C2);
Tau_act_2  = (rhotG_on*(C2 - mGAP_tot))/((C2 - mGAP_tot) + rhotG_off);
tGEF_act_2 = C2 - mGAP_tot;
mGAP_act_2 = mGAP_tot;
% 
% 
 %% SS CASE 3: C1 < mGAPtot, C2>C1
 mG_act_3   = 0;
 Tau_act_3  = 0;
 tGEF_act_3 = 0;
 mGAP_act_3 = C1;
% 
% 
%% SS CASE 4: C2 < mGAPtot, C1>C2
mG_act_4   = (1/(1 + rhomG_off*C2))*(C1 - C2);
Tau_act_4  = 0;
tGEF_act_4 = 0;
mGAP_act_4 = C2;





 % Substitute 4 steady states
 %Jac_subs1 = simplify(subs(Jac, [mG_act, Tau_act, tGEF_act,mGAP_act], [mG_act_1, Tau_act_1, tGEF_act_1,mGAP_act_1]))
  %Jac_subs2 = subs(Jac, [mG_act, Tau_act, tGEF_act,mGAP_act], [mG_act_2, Tau_act_2, tGEF_act_2,mGAP_act_2]);
 % Jac_subs3 = subs(Jac, [mG_act, Tau_act, tGEF_act,mGAP_act], [mG_act_3, Tau_act_3, tGEF_act_3,mGAP_act_3]);
  Jac_subs4 = subs(Jac, [mG_act, Tau_act, tGEF_act,mGAP_act], [mG_act_4, Tau_act_4, tGEF_act_4,mGAP_act_4]);

 
  
 % Compute eigenvalues of the Jacobian Matrix
 % lambda1    = simplify(eig(Jac_subs1))
% lambda2  = simplify(eig(Jac_subs2))
%lambda3  = simplify(eig(Jac_subs3))
 lambda4  = simplify(eig(Jac_subs4))
% 

% %% 2 eigenvalues for the SS 3 and 4 are given by complicated formulas, but we can prove that their sum are negative and their product are positve, hence they are negative numbers.
%sum3   = lambda3(3) + lambda3(4)
%prod3  = simplify(lambda3(3)*lambda3(4))
% 
% sum4   = lambda4(3) + lambda4(4)
% prod4  = simplify(lambda4(3)*lambda4(4))
% 

 %sum1   = lambda1(3) + lambda1(4)
 %prod1  = simplify(lambda1(3)*lambda1(4))

