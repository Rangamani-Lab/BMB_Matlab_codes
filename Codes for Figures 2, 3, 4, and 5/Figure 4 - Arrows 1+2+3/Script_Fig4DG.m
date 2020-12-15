clear all;close all;clc

%% Define parameters and initial conditions
%% Choose k_on3 = 0 to generate colormaps of figure 3

% Parameters
k_onS  = 3;
k_on1  = 3;
k_on2  = 3;
k_on3  = 3;
k_off  = 1;

% Initial Conditions
mg_act_0     = 0;
tGEF_tot_0   = 10;
G_act_0      = 0.5;
tGEF_act_0   = G_act_0*tGEF_tot_0;
tGEF_0       = tGEF_tot_0 - tGEF_act_0;

Tau_act_0    = 0.5;
tG_tot       = 10;
tG_act_0     = Tau_act_0*tG_tot;
tG_0         = tG_tot - tG_act_0;

mGAP_act_0   = 1;

tGAP_0       = 0;
tGAP_act_0   = 1;

mGEF_0       =  0;
mGEF_act_0   =  1;

num_points1  = 100; %num of points for mG_0
num_points2  = 100; % num of points for mGAP_0
tspan        = [0 50]; % time interval

%%  define mG_0 and mGAP_0 vector
mg_0_th    = tGEF_tot_0  - mg_act_0 - tGEF_tot_0*G_act_0;
pt1        = 1;
pt2a       = 10;
pt2b       = 20;
mG_0_vec   = linspace(pt1,pt2a,num_points1);
mGAP_0_vec = linspace(pt1,pt2b,num_points2);




%% SOLVE FOR mG(0) below the threshold
for j1=1:num_points1
    
    %% Set initial conditions and plot numeric solutions
    mg_0           = mG_0_vec(j1);    % define mg_0
    
    for j2=1:num_points2
        j1,j2
        
        mGAP_0         = mGAP_0_vec(j2); % define mGAP_0
        C0             = [mg_0 mg_act_0 tG_0 tG_act_0 tGEF_0 tGEF_act_0 mGAP_0 mGAP_act_0 tGAP_0 tGAP_act_0 mGEF_0 mGEF_act_0];  % set initial conditions
        
        %mG = C(1) ;  mG_act = C(2);
        %tG = C(3);   tG_act = C(4);
        %tGEF = C(5); tGEF_act =C(6);
        %mGAP = C(7); mGAP_act = C(8);
        %tGAP = C(9); tGAP_act = C(10);
        %mGEF = C(11); mGEF_act = C(12);
        
        [t,C_sol]             = ode23s(@(t,C) fun_s_mod_v2(t,C,k_onS,k_on1,k_on2,k_on3,k_off),tspan,C0); % solve the ODE system
        
        matrix_mG(j1,j2)       = C_sol(end,1);
        matrix_mG_act(j1,j2)   = C_sol(end,2);
        matrix_tG(j1,j2)       = C_sol(end,3);
        matrix_tG_act(j1,j2)   = C_sol(end,4);
        matrix_tGEF(j1,j2)     = C_sol(end,5);
        matrix_tGEF_act(j1,j2) = C_sol(end,6);
        
     
      
        
        clear mGAP_0 C0 C_sol
        
    end
    
    clear mg_0
end





%  
%  % % Label FIG2 E  mG vs mG*
% figure(1)
% pcolor(mGAP_0_vec,mG_0_vec,matrix_mG)
% shading flat
% colorbar
% xlabel(['$\bf{[mGAP](0)}$'],'interpreter','latex','FontWeight','bold','Color','k')
% ylabel(['$\bf{[mG](0)}$'],'interpreter','latex','FontWeight','bold','Color','k')
% set(gca,'FontSize',20)
% set(gca, 'FontName', 'Helvetica')
% set(gca, 'FontWeight', 'Bold')
% title('mG')
%  
%  
% figure(2)
% pcolor(mGAP_0_vec,mG_0_vec,matrix_mG_act)
% shading flat
% colorbar
% xlabel(['$\bf{[mGAP](0)}$'],'interpreter','latex','FontWeight','bold','Color','k')
% ylabel(['$\bf{[mG](0)}$'],'interpreter','latex','FontWeight','bold','Color','k')
% set(gca,'FontSize',20)
% set(gca, 'FontName', 'Helvetica')
% set(gca, 'FontWeight', 'Bold')
% title('mG_{act}')
% 
% figure(3)
% pcolor(mG_0_vec,mGAP_0_vec,matrix_tG)
% cab=makeColorMap([0 0.5 0],[1 1 1],[0.5, 0, 0.5],100);
% colormap(cab)
% shading interp
% colorbar
% xlabel(['$\bf{[mGAP](0)}$'],'interpreter','latex','FontWeight','bold','Color','k')
% ylabel(['$\bf{[mG](0)}$'],'interpreter','latex','FontWeight','bold','Color','k')
% set(gca,'FontSize',20)
% set(gca, 'FontName', 'Helvetica')
% set(gca, 'FontWeight', 'Bold')
% %axis([tspan(1) tspan(end) 5 10])
% title('tG')


figure(4)
pcolor(mG_0_vec,mGAP_0_vec,matrix_tG_act')
cab=makeColorMap([0 0.5 0],[1 1 1],[0.5, 0, 0.5],100);
colormap(cab)
colorbar
shading interp
ylabel(['$\bf{[mGAP](0)}$'],'interpreter','latex','FontWeight','bold','Color','k')
xlabel(['$\bf{[mG](0)}$'],'interpreter','latex','FontWeight','bold','Color','k')
set(gca,'FontSize',20)
set(gca, 'FontName', 'Helvetica')
set(gca, 'FontWeight', 'Bold')
title(['$\bf{[tG^*](\mu M) s.s}$'],'interpreter','latex','FontWeight','bold','Color','k')

% figure(5)
% pcolor(mGAP_0_vec,mG_0_vec,matrix_tGEF)
% cab=makeColorMap([0 0.5 0],[1 1 1],[0.5, 0, 0.5],100);
% colormap(cab)
% colorbar
% xlabel(['$\bf{[mGAP](0)}$'],'interpreter','latex','FontWeight','bold','Color','k')
% ylabel(['$\bf{[mG](0)}$'],'interpreter','latex','FontWeight','bold','Color','k')
% set(gca,'FontSize',20)
% set(gca, 'FontName', 'Helvetica')
% set(gca, 'FontWeight', 'Bold')
% title('tGEF')


figure(6)
pcolor(mG_0_vec,mGAP_0_vec,matrix_tGEF_act')
cab=makeColorMap([0 0.5 0],[1 1 1],[0.5, 0, 0.5],100);
colormap(cab)
colorbar
shading interp
ylabel(['$\bf{[mGAP](0) (\mu M)}$'],'interpreter','latex','FontWeight','bold','Color','k')
xlabel(['$\bf{[mG](0) (\mu M) }$'],'interpreter','latex','FontWeight','bold','Color','k')
set(gca,'FontSize',20)
set(gca, 'FontName', 'Helvetica')
set(gca, 'FontWeight', 'Bold')
title('tGEF_{act}')
title(['$\bf{[tGEF^*](\mu M) s.s}$'],'interpreter','latex','FontWeight','bold','Color','k')




%  %% SAVING FIGURES
%  saveas(figure(1),'Fig2B.fig');  saveas(figure(1),'Fig2B.png');
%  saveas(figure(2),'Fig2C.fig');  saveas(figure(2),'Fig2C.png');
%  saveas(figure(3),'Fig2D_1.fig');  saveas(figure(3),'Fig2D_1.png');
%  saveas(figure(4),'Fig2D_2.fig');  saveas(figure(4),'Fig2D_2.png');
%  saveas(figure(5),'Fig2E.fig');  saveas(figure(5),'Fig2E.png');




