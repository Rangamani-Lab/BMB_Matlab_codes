clear all;close all;clc

%% Define parameters and initial conditions

% Parameters
mgap   = 1;
mgef    = 1;
k_on  = 3;
k_off = 1;

% Initial Conditions
mg_act_0     = 0;
k_gef        = k_on*mgef;
k_gap        = k_off*mgap;
tgef_tot     = 10;
G_act_0      = 0.5;
Tau_act_0    = 0.5;
k_tilde      = k_on*(tgef_tot);
num_points1  = 10;
num_points2  = 1;
tspan        = [0 5];

% mg_0 vector
mg_0_th   = tgef_tot - mg_act_0 - tgef_tot*G_act_0;

pt1 = 1;
pt2 = mg_0_th-0.3;
mg_0_vec  = linspace(pt1,pt2,num_points1);

%% SOLVE FOR mG(0) below the threshold
for j1=1:num_points1
    
    %% Set initial conditions and plot numeric solutions
    mg_0           = mg_0_vec(j1);                                                        % define mg_0
    C0_red         = [mg_0 mg_act_0 Tau_act_0  G_act_0];                                  % set initial conditions
    [t,C_sol_red]  = ode23s(@(t,C) fun_s_red(t,C,k_gef,k_gap,k_tilde,k_on),tspan,C0_red); % solve the EDO system
    
    
    % PLot numerical solutions
    figure(1)
    hold on
    plot(C_sol_red(:,4),C_sol_red(:,1) + C_sol_red(:,2),'b','Linewidth',2);             % Fig2 B (G* vs mG_tot)
    
    figure(2)
    hold on
    plot(C_sol_red(:,3),C_sol_red(:,1) + C_sol_red(:,2),'b','Linewidth',2);             % Fig2 C (T* vs mG_tot)

   

  figure(3)
   hold on
   plot(C_sol_red(:,1), C_sol_red(:,2), 'b', 'Linewidth',2)    % FIG2 E final mG vs mG*
    
    
    
    clear mg_0 C0_red C_sol_red
    
    
end


%% SOLVE FOR mG(0) above the threshold

clear pt1 pt2 mg_0_vec
pt1 = mg_0_th+0.3;
pt2 = 10;

mg_0_vec  = linspace(pt1,pt2,num_points1);

for j1=1:num_points1
    
    %% Set initial conditions and plot numeric solutions
    mg_0           = mg_0_vec(j1);                                                        % define mg_0
    C0_red         = [mg_0 mg_act_0 Tau_act_0  G_act_0];                                  % set initial conditions
    [t,C_sol_red]  = ode23s(@(t,C) fun_s_red(t,C,k_gef,k_gap,k_tilde,k_on),tspan,C0_red); % solve the EDO system
    
    
    % Plot numerical solutions
    figure(1)
    hold on
    plot(C_sol_red(:,4),C_sol_red(:,1) + C_sol_red(:,2),'r','Linewidth',2);             % Fig2 B (G* vs mG_tot)
    
    figure(2)
    hold on
    plot(C_sol_red(:,3),C_sol_red(:,1) + C_sol_red(:,2),'r','Linewidth',2);             % Fig2 C (T* vs mG_tot)

    
    
   figure(3)
   hold on
   plot(C_sol_red(:,1), C_sol_red(:,2), 'r', 'Linewidth',2)    % FIG2 E final mG vs mG*
    
    
    clear mg_0 C0_red C_sol_red
    
end

clear mg_0_vec
mg_0_vec  = linspace(pt1,pt2,num_points2);



%% Label Fig 2B (G* vs mG_tot)
 figure(1) 
 xlabel(['$\bf{\mathcal{G}^*}$'],'interpreter','latex','FontWeight','bold','Color','k')
 ylabel(['$\bf{[mG_{tot}]}$ ($\bf{\mu}$\textbf{M}) '],'interpreter','latex','FontWeight','bold','Color','k')
 set(gca,'FontSize',20)
 set(gca, 'FontName', 'Helvetica')
 set(gca, 'FontWeight', 'Bold')
 axis([0.5 1 0 10])
 
 %% Label Fig 2E (T* vs mG_tot)
 figure(2)
 xlabel(['$\bf{\mathcal{T}^*}$ '],'interpreter','latex','FontWeight','bold','Color','k')
 ylabel(['$\bf{[mG_{tot}]}$ ($\bf{\mu}$\textbf{M}) '],'interpreter','latex','FontWeight','bold','Color','k')
 set(gca,'FontSize',20)
 set(gca, 'FontName', 'Helvetica')
 set(gca, 'FontWeight', 'Bold')
 axis([0.5 1 0 10])
 

 
  %% Label Fig 2C (mG vs mG*)
 figure(3)
 xlabel(['  $\bf{[mG]}$ ($\bf{\mu}$\textbf{M}) '],'interpreter','latex','FontWeight','bold','Color','k')
 ylabel([' $\bf{[mG^*]}$ ($\bf{\mu}$\textbf{M})'],'interpreter','latex','FontWeight','bold','Color','k')
 set(gca,'FontSize',20)
 set(gca, 'FontName', 'Helvetica')
 set(gca, 'FontWeight', 'Bold')
 axis([0 10 0 4])
 
 
 
%  %% SAVING FIGURES
%  saveas(figure(1),'Fig2B.fig');  saveas(figure(1),'Fig2B.png'); 
%  saveas(figure(2),'Fig2C.fig');  saveas(figure(2),'Fig2C.png'); 
%  saveas(figure(3),'Fig2D_1.fig');  saveas(figure(3),'Fig2D_1.png'); 
%  saveas(figure(4),'Fig2D_2.fig');  saveas(figure(4),'Fig2D_2.png'); 
%  saveas(figure(5),'Fig2E.fig');  saveas(figure(5),'Fig2E.png'); 


 
 
