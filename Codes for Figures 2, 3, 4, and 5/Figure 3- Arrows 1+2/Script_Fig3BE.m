clear all;close all;clc

%% Define parameters and initial conditions

% Parameters
k_onS  = 3;
k_on1  = 3;
k_on2  = 3;
k_on3  = 0;
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

mGAP_0_vec_tGplot        = [0;5;11;9];  % for  tG_act plot
mGAP_0_vec_tGEFplot      = [0;1;11;8];  % for tGEF_act plot


mGAP_act_0   = 1;

tGAP_0       = 0;
tGAP_act_0   = 1;

mGEF_0       =  0;
mGEF_act_0   =  1;

num_points1  = 10;
num_points2  = 10;
tspan        = [0 5];

%% parameters below the threshold
mg_0_th   = tGEF_tot_0  - mg_act_0 - tGEF_tot_0*G_act_0;
pt1       = 1;
pt2       = mg_0_th-0.3;
mg_0_vec_below  = linspace(pt1,pt2,num_points1);






%% colors
symb_below{1} = '--b';
symb_below{2} = '--g';
symb_below{3} = '--m';
symb_below{4} = '--c';


for j0=1:length(mGAP_0_vec_tGplot)
    mGAP_0_tGplot   = mGAP_0_vec_tGplot(j0);
    mGAP_0_tGEFplot = mGAP_0_vec_tGEFplot(j0);
    
   
    
    %% SOLVE FOR mG(0) below the threshold
    for j1=1%:num_points1
        
        %% Set initial conditions and plot numeric solutions
        mg_0                    = mg_0_vec_below(j1);    % define mg_0
        C0_tGplot               = [mg_0 mg_act_0 tG_0 tG_act_0 tGEF_0 tGEF_act_0 mGAP_0_tGplot mGAP_act_0 tGAP_0 tGAP_act_0 mGEF_0 mGEF_act_0]; 
        C0_tGEFplot             = [mg_0 mg_act_0 tG_0 tG_act_0 tGEF_0 tGEF_act_0 mGAP_0_tGEFplot mGAP_act_0 tGAP_0 tGAP_act_0 mGEF_0 mGEF_act_0];

        
        %mG = C(1) ;  mG_act = C(2);
        %tG = C(3);   tG_act = C(4);
        %tGEF = C(5); tGEF_act =C(6);
        %mGAP = C(7); mGAP_act = C(8);
        %tGAP = C(9); tGAP_act = C(10);
        %mGEF = C(11); mGEF_act = C(12);
        
         [t_tGplot,C_sol_tGplot]                  = ode23s(@(t,C) fun_s_mod_v2(t,C,k_onS,k_on1,k_on2,k_on3,k_off),tspan,C0_tGplot); % solve the EDO system - tG plot
         [t_tGEFplot,C_sol_tGEFplot]                  = ode23s(@(t,C) fun_s_mod_v2(t,C,k_onS,k_on1,k_on2,k_on3,k_off),tspan,C0_tGEFplot); % solve the EDO system - tGEF plot

        below_traj_tG{j1,j0}       = C_sol_tGplot(:,4);       % 4 - trajectories tG_act
        below_traj_tGEF{j1,j0}     = C_sol_tGEFplot(:,6);     % 6 - trajectories tGEF*

        figure(1)
        hold on
        plot(t_tGplot, below_traj_tG{j1,j0},symb_below{j0},'Linewidth',2);
        figure(2)
        plot(t_tGEFplot, below_traj_tGEF{j1,j0},symb_below{j0},'Linewidth',2);
        hold on

        
        clear mg_0 C0_tGplot C0_tGEFplot t_tGplot C_sol_tGplot t_tGEFplot C_sol_tGEFplot
    end
    clear  mGAP_0
    
end

clear pt1 pt2
%% parameters above the threshold
pt1       = mg_0_th+0.3;
pt2       = 10;
mg_0_vec_above  = linspace(pt1,pt2,num_points1);

symb_above{1} = 'r';
symb_above{2} = 'g';
symb_above{3} = 'm';
symb_above{4} = 'c';



for j0=1:length(mGAP_0_vec_tGplot)
    mGAP_0_tGplot   = mGAP_0_vec_tGplot(j0);
    mGAP_0_tGEFplot = mGAP_0_vec_tGEFplot(j0);
    
    for j1=num_points2
        
        %% SOLVE FOR mG(0) above the threshold
        mg_0                    = mg_0_vec_above(j1);    % define mg_0
        C0_tGplot               = [mg_0 mg_act_0 tG_0 tG_act_0 tGEF_0 tGEF_act_0 mGAP_0_tGplot mGAP_act_0 tGAP_0 tGAP_act_0 mGEF_0 mGEF_act_0]; 
        C0_tGEFplot             = [mg_0 mg_act_0 tG_0 tG_act_0 tGEF_0 tGEF_act_0 mGAP_0_tGEFplot mGAP_act_0 tGAP_0 tGAP_act_0 mGEF_0 mGEF_act_0];
 
        %mG = C(1) ;  mG_act = C(2);
        %tG = C(3);   tG_act = C(4);
        %tGEF = C(5); tGEF_act =C(6);
        %mGAP = C(7); mGAP_act = C(8);
        %tGAP = C(9); tGAP_act = C(10);
        %mGEF = C(11); mGEF_act = C(12);
        
         [t_tGplot,C_sol_tGplot]                   = ode23s(@(t,C) fun_s_mod_v2(t,C,k_onS,k_on1,k_on2,k_on3,k_off),tspan,C0_tGplot); % solve the EDO system - tG plot
         [t_tGEFplot,C_sol_tGEFplot]                 = ode23s(@(t,C) fun_s_mod_v2(t,C,k_onS,k_on1,k_on2,k_on3,k_off),tspan,C0_tGEFplot); % solve the EDO system - tGEF plot

        above_traj_tG{j1,j0}     =   C_sol_tGplot(:,4);  % 4- trajectories tG_act
        above_traj_tGEF{j1,j0}   = C_sol_tGEFplot(:,6);  % 6- trajectories tGEF_act
        
        figure(1)
        plot(t_tGplot, above_traj_tG{j1,j0},symb_above{j0},'Linewidth',2);
        figure(2)
        plot(t_tGEFplot, above_traj_tGEF{j1,j0},symb_above{j0},'Linewidth',2);
        
        clear mg_0 C0_tGplot C0_tGEFplot t_tGplot C_sol_tGplot t_tGEFplot C_sol_tGEFplot
        
    end
    clear  mGAP_0
end


%% Label Figure
figure(1)
hold on
xlabel(['\bf{time(s)}'],'interpreter','latex','FontWeight','bold','Color','k')
ylabel(['$\bf{[tG^*]}$ ($\bf{\mu}$\textbf{M}) '],'interpreter','latex','FontWeight','bold','Color','k')
%ylabel(['$\bf{[tGEF^*]}$ ($\bf{\mu}$\textbf{M}) '],'interpreter','latex','FontWeight','bold','Color','k')
set(gca,'FontSize',20)
set(gca, 'FontName', 'Helvetica')
set(gca, 'FontWeight', 'Bold')
axis([0 1 0 10])

figure(2)
hold on
xlabel(['\bf{time(s)}'],'interpreter','latex','FontWeight','bold','Color','k')
%ylabel(['$\bf{[tG^*]}$ ($\bf{\mu}$\textbf{M}) '],'interpreter','latex','FontWeight','bold','Color','k')
ylabel(['$\bf{[tGEF^*]}$ ($\bf{\mu}$\textbf{M}) '],'interpreter','latex','FontWeight','bold','Color','k')
set(gca,'FontSize',20)
set(gca, 'FontName', 'Helvetica')
set(gca, 'FontWeight', 'Bold')
axis([0 1 0 10])
