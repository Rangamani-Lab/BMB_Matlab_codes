clear all;close all;clc

%% Define parameters and initial conditions
% Choose fun_s_mod1, fun_s_mod12 or fun_s_mod123 in line 60 to plot the
% results for arrows 1, 1+2 or 1+2+3


%mG = C(1) ;  mG_act = C(2);
%tG = C(3);   tG_act = C(4);
%tGEF = C(5); tGEF_act =C(6);
%mGAP = C(7); mGAP_act = C(8);
%tGAP = C(9); tGAP_act = C(10);
%mGEF = C(11); mGEF_act = C(12);




t     = linspace(0,500,1000);
k_on  = 3;
k_off = 1;



C_0(1)  = 0;    % mG_0
C_0(2)  = 0;    % mG_act_0
C_0(3)  = 5;    %tG_0
C_0(4)  = 0;    %tG_act_0
C_0(5)  = 5;    %tGEF_0
C_0(6)  = 0;    %tGEF_0
C_0(7)  = 6;    % mGAP_0
C_0(8)  = 6;    % mGAP_act_0
C_0(9)  = 1;    % tGAP_0 --- constant
C_0(10) = 1;    % tGAP_act_0 --- constant
C_0(11) = 0;    % mGEF_0 --- constant
C_0(12) = 1;    % mGEF_act_0 --- constant

ind1 = 2 ;
ind2 = 8;
clear C_0(ind1) C_0(ind2)
max_par1 = 10;
max_par2 = 12;
num_points = 150;
par_vec1 = linspace(0,max_par1,num_points);
par_vec2 = linspace(0,max_par2,num_points);

tol = 10^(-5);


%% START LOOP

for j1 = 1: num_points
    
    C_0(ind1)  = par_vec1(j1);
    
    for j2=1:num_points
        
        C_0(ind2)  = par_vec2(j2);
        C_0(7)  = 12 - C_0(ind2) ;    

        
        [~,C_sol] = ode15s(@(t,C) fun_s_mod1(t,C,k_on,k_off),t,C_0); % solve the EDO system

        count = 0;
        for j3=1:4
            if abs(C_sol(end,j3)) < tol
                count = count;
            else
                count = count+1;
            end
            
        end
             count_matrix(j1,j2) = count;                        
            clear C_sol count j3  C_0(ind2) C_0(6)
    end
    
clear   C_0(ind1)
end
    
    
figure
pcolor(par_vec2,par_vec1, count_matrix)
xlabel(['$\bf{[mGAP^*](0) (\mu M)}$'],'interpreter','latex','FontSize',30,'FontWeight','bold','Color','k')
ylabel(['$\bf{[mG^*](0) (\mu M)}$'],'interpreter','latex','FontSize',30,'FontWeight','bold','Color','k')
set(gca,'FontSize',30)    
set(gca, 'FontName', 'Helvetica','Fontweight','bold')
colorbar
shading flat
%xlabel('mGAP_{act}(0)')
%ylabel('mG_{act}(0)')
    