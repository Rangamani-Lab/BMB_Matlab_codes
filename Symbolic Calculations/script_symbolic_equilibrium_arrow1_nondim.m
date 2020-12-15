%% This script Compute the eigenvalues of the Jacobian matrix - Arrow 1

clear all;close all;clc

syms   kon rhomG_off rho1_on rhotG_on rhotG_off mGEF_act mGAP_act tGAP_act C mG_act tGEF_tot G_act Tau_act 



Eq_mGact  = (C- mG_act - tGEF_tot*G_act) - rhomG_off*mGAP_act*mG_act - rho1_on*tGEF_tot*(1-G_act)*mG_act;
Eq_tauact = rhotG_on*tGEF_tot*G_act*(1-Tau_act) - rhotG_off*Tau_act;
Eq_Gact   = rho1_on*(1-G_act)*mG_act; 


J1       = jacobian([Eq_mGact, Eq_tauact, Eq_Gact], [mG_act, Tau_act, G_act]);
J1_subs1 = subs(J1, [mG_act, Tau_act, G_act], [0, 1/(1+(rhotG_off/(rhotG_on*C))),C/tGEF_tot]);
lambda1  = eig(J1_subs1);
sum1     = lambda1(2) + lambda1(3);
prod1    = simplify(lambda1(2)*lambda1(3));


%[(kon*mGEF_act*(C-tGEF_tot))/(kon*mGEF_act+koff*mGAP_act),(kon*tGEF_tot)/(kon*tGEF_tot+ koff*tGAP_act),1]
%[(C-tGEF_tot)/(rhomG_off*mGAP_act+1),(rhotG_on*tGEF_tot)/(rhotG_on*tGEF_tot + rhotG_off),1]


J1_subs2 = subs(J1, [mG_act, Tau_act, G_act], [(C-tGEF_tot)/(rhomG_off*mGAP_act+1),(rhotG_on*tGEF_tot)/(rhotG_on*tGEF_tot + rhotG_off),1]);
lambda2  = eig(J1_subs2);
sum2     = lambda2(2) + lambda2(3);
prod2    = simplify(lambda2(2)*lambda2(3));


