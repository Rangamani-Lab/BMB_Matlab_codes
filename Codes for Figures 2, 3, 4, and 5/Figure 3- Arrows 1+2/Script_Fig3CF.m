clear all;close all;clc

%% Define parameters and initial conditions
% choose between tGEF_act or tG_act plots in lines 116 and 117. tGEF_act =
% C_sol(end,6), tG_act = C_sol(end,4).
%

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

%mGAP_0_vec    = [0;5;11;9];
%mGAP_0_vec    = [0;1;11;8]; %for tGEF_act plot
mGAP_0_vec    = [0;5;11;9];  %for tG_act plot





mGAP_act_0   = 1;

tGAP_0       = 0;
tGAP_act_0   = 1;

mGEF_0       =  0;
mGEF_act_0   =  1;

num_points1  = 10;
num_points2  = 10;
tspan        = [0 50];

%% parameters below the threshold
mg_0_th   = tGEF_tot_0  - mg_act_0 - tGEF_tot_0*G_act_0;
pt1       = 1;
pt2       = mg_0_th-0.3;
mg_0_vec_below  = linspace(pt1,pt2,num_points1);



for j0=1:length(mGAP_0_vec)
    mGAP_0 = mGAP_0_vec(j0);
    
    %% SOLVE FOR mG(0) below the threshold
    for j1=1:num_points1
        
        %% Set initial conditions and plot numeric solutions
        mg_0           = mg_0_vec_below(j1);    % define mg_0
        C0             = [mg_0 mg_act_0 tG_0 tG_act_0 tGEF_0 tGEF_act_0 mGAP_0 mGAP_act_0 tGAP_0 tGAP_act_0 mGEF_0 mGEF_act_0];                                
        
        %mG = C(1) ;  mG_act = C(2);
        %tG = C(3);   tG_act = C(4);
        %tGEF = C(5); tGEF_act =C(6);
        %mGAP = C(7); mGAP_act = C(8);
        %tGAP = C(9); tGAP_act = C(10);
        %mGEF = C(11); mGEF_act = C(12);
        
        [t,C_sol]      = ode23s(@(t,C) fun_s_mod_v2(t,C,k_onS,k_on1,k_on2,k_on3,k_off),tspan,C0); % solve the EDO system
        
        
        %below_vec(j1,j0)     = C_sol(end,6); % tGEF
        below_vec(j1,j0)      = C_sol(end,4); % tG_act
        %trajectories{j1,j0}   = C_sol(:,4); % trajectories tG_act 


        
        clear mg_0 C0_red C_sol_red
        
        
    end
    clear  mGAP_0
    
end

clear pt1 pt2 
%% parameters above the threshold 
pt1       = mg_0_th+0.3;
pt2       = 10;
mg_0_vec_above  = linspace(pt1,pt2,num_points1);




for j0=1:length(mGAP_0_vec)
    mGAP_0 = mGAP_0_vec(j0);
    
    for j1=1:num_points2
        
        %% SOLVE FOR mG(0) above the threshold
        mg_0           = mg_0_vec_above(j1);    % define mg_0
        C0             = [mg_0 mg_act_0 tG_0 tG_act_0 tGEF_0 tGEF_act_0 mGAP_0 mGAP_act_0 tGAP_0 tGAP_act_0 mGEF_0 mGEF_act_0];                                  % set initial conditions
        
        %mG = C(1) ;  mG_act = C(2);
        %tG = C(3);   tG_act = C(4);
        %tGEF = C(5); tGEF_act =C(6);
        %mGAP = C(7); mGAP_act = C(8);
        %tGAP = C(9); tGAP_act = C(10);
        %mGEF = C(11); mGEF_act = C(12);
        
        [t,C_sol]      = ode23s(@(t,C) fun_s_mod_v2(t,C,k_onS,k_on1,k_on2,k_on3,k_off),tspan,C0); % solve the EDO system
        

        
         %above_vec(j1,j0) = C_sol(end,6);
         above_vec(j1,j0)  = C_sol(end,4); 
         %trajectories{j1,j0}   = C_sol(:,4); % trajectories tG 


        
        clear mg_0 C0_red C_sol_red
        
    end
    clear  mGAP_0
end

% 
% % Symbols list for the plot
% symb{1} = '-o';
% symb{2} = '-s';
% symb{3} = '-^';
% symb{4} = '-d';
% 
% 
% for j2 = 1:length(mGAP_0_vec)
% figure(1)
% hold on
% plot(mg_0_vec_below, below_vec(:,j2),symb{j2},'Linewidth',1.5,'Markersize',9);%,'MarkerFaceColor','b');
% end
% 
% 
% clear symb
% % Symbols list for the plot
% symb{1} = '-o';
% symb{2} = '-s';
% symb{3} = '-^';
% symb{4} = '-d';
% 
% clear j2
% for j2 = 1:length(mGAP_0_vec)
% figure(1)
% hold on
% plot(mg_0_vec_above , above_vec(:,j2),symb{j2},'Linewidth',1.5,'Markersize',9);%,'MarkerFaceColor','r');
% end



% Symbols list for the plot
symb{1} = 'bo';
symb{2} = 'gs';
symb{3} = 'm^';
symb{4} = 'cd';


total_vec = [below_vec; above_vec];
total_mg0 =  [mg_0_vec_below mg_0_vec_above]';

for j2 = 1:length(mGAP_0_vec)
figure(1)
hold on
h1= plot(total_mg0,total_vec(:,j2),symb{j2},'Linewidth',1.5,'Markersize',9,'MarkerFaceColor','w');
set(h1, 'markerfacecolor', get(h1, 'color'))
clear h1
end


% Symbols list for the plot
symb{1} = 'ro';

clear j2
for j2 = 1
figure(1)
hold on
h2= plot(mg_0_vec_above , above_vec(:,j2),symb{j2},'Linewidth',1.5,'Markersize',9);%,'MarkerFaceColor','r');
set(h2, 'markerfacecolor', get(h2, 'color'))
clear h2
end


%% Label Figure
figure(1)
hold on
xlabel(['$\bf{[mG](0) (\mu M)}$'],'interpreter','latex','FontWeight','bold','Color','k')
ylabel(['$\bf{[tG^*] }$ ($\bf{\mu}$\textbf{M}) s.s '],'interpreter','latex','FontWeight','bold','Color','k')
%ylabel(['$\bf{[tGEF^*]}$ ($\bf{\mu}$\textbf{M}) s.s '],'interpreter','latex','FontWeight','bold','Color','k')
set(gca,'FontSize',20)
set(gca, 'FontName', 'Helvetica')
set(gca, 'FontWeight', 'Bold')
axis([1 10 0 10])
