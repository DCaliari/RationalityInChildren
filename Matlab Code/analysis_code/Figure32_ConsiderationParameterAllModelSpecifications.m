create_warp_datasets

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ECMA MODEL ESTIMATIONS %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[DATA1,DATA2,~,~,~,~] = dataset_constructions(DATASET(:,1:6),n); % use the function "dataset_constructions" to obtain the dataset for estimation

C_pencils = DATA1; % These are the choices from the pencils
C_pens = DATA2; % These are the choices from the pens

%% Here I load data on school, groups, class, etc...

load groups.mat 

load gender_class_school

spring = group < 8; % I focus on the pupils who did the experiment in the autumn

%% I create the subpopulations

T(:,1) = school == 1 & class == 1 & ~spring;
T(:,2) = school == 1 & class == 2 & ~spring;
T(:,3) = school == 1 & class == 3 & ~spring;
T(:,4) = school == 1 & class == 4 & ~spring;
T(:,5) = school == 1 & class == 5 & ~spring;
T(:,6) = school == 4 & class == 1 & ~spring;
T(:,7) = school == 4 & class == 2 & ~spring;
T(:,8) = school == 4 & class == 3 & ~spring;
T(:,9) = school == 4 & class == 4 & ~spring;
T(:,10) = school == 4 & class == 5 & ~spring;
T(:,11) = school == 1 & ~spring;
T(:,12) = school == 4 & ~spring;


%%

for treatment = 1:2
    if treatment==1 % Focus on pencils
        C = C_pencils;
    elseif treatment==2 % Focus on pens
        C = C_pens;
    end


iter=1;

for z=1:12 % Here we go through the subpopulations

clearvars N p_par_new pi_par_new F y % eliminate the previous parameters

g = 1; % Number of gamma parameters = 1, i.e. unique consideration parameter

N=size(C(T(:,z),:),1); % Numerosity of the subpopulation

% p_par = rand(g,1); % starting point for the estimation of the gamma parameter
% p_par = sort(p_par);
p_par = 0.5;

%%%% This is to check that the starting point does not modify the estimates
if iter==1
pi_par=ones(1,(g)*lc)/((g)*lc); % starting point for the estimation of the probability distribution "pi" - uniform
else
pi_par = rand(1,(g)*lc); % starting point for the estimation of the probability distribution "pi" - random vector
pi_par = pi_par./sum(pi_par);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pi_par_old = pi_par;

tol_par = 1e-9;
par_dist=1; it=1; 

p_par_old = p_par;

options=optimoptions('fmincon','display','off','MaxFunctionEvaluations',1e7,...
    'StepTolerance',1e-9,'FunctionTolerance',1e-9,'OptimalityTolerance',1e-9,'FiniteDifferenceType','central' );

LL_dist = 1; 
tol_LL = 1e-8; % Log-likelihood differences for the while loop

while   LL_dist>tol_LL
clearvars Q P % I clear the conditional probabilities matrices to recalculate them with the new estimated parameters
Q=[];
p_par = p_par_old;

temp_par = repmat(p_par,1,4); % Here, unique gamma per each alternative

%%% Here, we calculate the conditional probabilities matrices

for i=1:size(p_par,1)
for u=1:lc
P(:,u) = P_Rho_varying_type(temp_par(i,:),PER,u,R); 
end

temp=P;
Q=[Q,temp];

end

%%%


F=exp(C(T(:,z),:)*log(Q)); % This is the likelihood function


%%% The constraints in the first maximization problem

lb = zeros(size(F,2),1); % lower bound at zero for the probabilities
ub = ones(size(F,2),1); % upper bound at one for the probabilities
Aeq = ones(1,size(F,2)); % the vector of probabilities sum to one
beq = 1;

%%%

[pi_par_new] = fmincon(@(pi_par) Log_lik_EB(pi_par,F), pi_par_old',[],[],Aeq,beq,lb,ub,[],options); % maximization of the likelihood w.r.t. to the probability distribution
pi_par_new = pi_par_new';

%%% The constraints in the second maximization problem: lower/upper bound
%%% for gamma at 0 and 1

lb=0;
for i=1:size(p_par_old,1)-1    
    lb = [lb;p_par_old(i)];
end
ub=[];
for i=1:size(p_par_old,1)-1 
ub  = [ub;p_par_old(1+i)];
end
ub=[ub;1];

%%%

[p_par_new,~,~,~,~,grad,hessian] = fmincon(@(p_par) log_lik_model(p_par, pi_par_new, PER, lc, R, C(T(:,z),:)), p_par_old, [], [], [], [], lb, ub, [], options); % maximization of the likelihood w.r.t. to gamma

LL_dist = log_lik_model(p_par_old, pi_par_new, PER, lc, R, C(T(:,z),:)) - log_lik_model(p_par_new, pi_par_new, PER, lc, R, C(T(:,z),:)); % likelihood distance

pi_par_old = pi_par_new; % re-set the parameters in the while loop
p_par_old=p_par_new;
it=it+1;
end

parameters2{treatment}(:,z) = p_par_new; % store the estimated gammas
preferences2{treatment}(z,:) = pi_par_new; % store the estimated probability distribution

LL2{treatment}(z) = log_lik_model(p_par_new, pi_par_new, PER, lc, R, C(T(:,z),:));

z
end
end



for treatment = 1:2
    if treatment==1
        C = C_pencils;
    elseif treatment==2
        C = C_pens;
    end

%% SCHOOL 1

iter=1;

%%% we choose the numerosity of the grid using BIC

for h=1:3

for z=1:12

clearvars N p_par_new pi_par_new F y

g = h+2;

N=size(C(T(:,z),:),1);

p_par = rand(g-1,1);
p_par = sort(p_par);

%%%% This is to check that the starting point does not modify the estimates
if iter==1
pi_par=ones(1,(g-1)*lc)/((g-1)*lc);
else
pi_par = rand(1,(g-1)*lc);
pi_par = pi_par./sum(pi_par);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pi_par_old=pi_par;

tol_par = 1e-9;
par_dist=1; it=1; 

p_par_old = p_par;


options=optimoptions('fmincon','display','off','MaxFunctionEvaluations',1e7,...
    'StepTolerance',1e-9,'FunctionTolerance',1e-9,'OptimalityTolerance',1e-9,'FiniteDifferenceType','central' );

LL_dist = 1; 
tol_LL = 1e-6;


while   LL_dist>tol_LL
clearvars Q P 
Q=[];
p_par = p_par_old;

temp_par = repmat(p_par,1,4);

for i=1:size(p_par,1)
for u=1:lc
P(:,u) = P_Rho_varying_type(temp_par(i,:),PER,u,R); 
end
%
temp=P;
Q=[Q,temp];
%
end

%
F=exp(C(T(:,z),:)*log(Q)); 


%%% ML
lb = zeros(size(F,2),1);
ub = ones(size(F,2),1);
Aeq = ones(1,size(F,2));
beq = 1;

[pi_par_new] = fmincon(@(pi_par) Log_lik_EB(pi_par,F), pi_par_old',[],[],Aeq,beq,lb,ub,[],options);
pi_par_new = pi_par_new';
%%%%


lb=0;
for i=1:size(p_par_old,1)-1    
    lb = [lb;p_par_old(i)];
end
ub=[];
for i=1:size(p_par_old,1)-1 
ub  = [ub;p_par_old(1+i)];
end
ub=[ub;1];

% lb = zeros(3,1);
% ub= ones(3,1);

p_par_new = fmincon(@(p_par) log_lik_model(p_par, pi_par_new, PER, lc, R, C(T(:,z),:)), p_par_old, [], [], [], [], lb, ub, [], options);

% LL_dist = log_lik_attempt(p_par_old, pi_par_old, PER, lc, R, C) - log_lik_attempt(p_par_new, pi_par_new, PER, lc, R, C)
LL_dist = log_lik_model(p_par_old, pi_par_new, PER, lc, R, C(T(:,z),:)) - log_lik_model(p_par_new, pi_par_new, PER, lc, R, C(T(:,z),:));

% par_dist=norm(pi_par_new-pi_par_old);
%
pi_par_old = pi_par_new;
p_par_old=p_par_new;
it=it+1;
end

parameters3{treatment,h}(:,z) = p_par_new;
preferences3{treatment,h}(z,:) = pi_par_new;

LL3{treatment}(z,h) = log_lik_model(p_par_new, pi_par_new, PER, lc, R, C(T(:,z),:));

z
end
end

end

%% Expected consideration parameter

for treatment = 1:2
    for h = 1:3
    if h==1
        for z=1:12
        marg_pref{treatment,h}(z,:) = [sum(preferences3{treatment,h}(z,1:24)),sum(preferences3{treatment,h}(z,25:48))]; 
        end
    elseif h==2
        for z=1:12
       marg_pref{treatment,h}(z,:) = [sum(preferences3{treatment,h}(z,1:24)),sum(preferences3{treatment,h}(z,25:48)),sum(preferences3{treatment,h}(z,49:72))];  
        end
    elseif h==3
        for z=1:12
       marg_pref{treatment,h}(z,:) = [sum(preferences3{treatment,h}(z,1:24)),sum(preferences3{treatment,h}(z,25:48)),sum(preferences3{treatment,h}(z,49:72)),sum(preferences3{treatment,h}(z,73:end))];  
        end
    end
    end
end

for treatment = 1:2
    for h = 1:3
        for z=1:12
    rho_mean{treatment, h}(z,1) = marg_pref{treatment,h}(z,:)*parameters3{treatment,h}(:,z);
        end
    end
end

RHO{1,1} = [parameters2{1,1}', rho_mean{1,1}, rho_mean{1,2}, rho_mean{1,3}];
RHO{1,2} = [parameters2{1,2}', rho_mean{2,1}, rho_mean{2,2}, rho_mean{2,3}];


x = [1 2 3 4 5 6];
x1 = x-0.1;
x2 = x+0.1;

subplot(1,2,1)
for i=1:4
P = RHO{1}([1:5 11],i);
plot(x1(1:5),P(1:5),'*','MarkerSize',8,'Color',[1-0.15*i 0+0.1*i 0],'LineStyle','--')
hold on
plot(x1(6),P(6),'*','MarkerSize',8,'Color',[1-0.15*i 0+0.1*i 0],'LineStyle','none')
hold on
P = RHO{1}([6:10 12],i);
plot(x2(1:5),P(1:5),'*','MarkerSize',8,'Color',[0 0+0.1*i 1-0.15*i ],'LineStyle','--')
hold on
plot(x2(6),P(6),'*','MarkerSize',8,'Color',[0 0+0.1*i 1-0.15*i ],'LineStyle','none')
hold on
xline(5.5,'--')
ylim([0.5 1])
xlim([0.5 6.5])
xticks([1 2 3 4 5 6]);
xticklabels({'1st grade', '2nd grade', '3rd grade', '4th grade', '5th grade', 'Aggregate'});
set(gca,'FontName','Times')
end
legend('School L (1)','','School H (1)','','','School L (2)','','School H (2)','','',...
    'School L (3)','','School H (3)','','','School L (4)','','School H (4)','','','Location','southeast')
hold off


subplot(1,2,2)
for i=1:4
P = RHO{2}([1:5 11],i);
plot(x1(1:5),P(1:5),'*','MarkerSize',8,'Color',[1-0.15*i 0+0.1*i 0],'LineStyle','--')
hold on
plot(x1(6),P(6),'*','MarkerSize',8,'Color',[1-0.15*i 0+0.1*i 0],'LineStyle','none')
hold on
P = RHO{2}([6:10 12],i);
plot(x2(1:5),P(1:5),'*','MarkerSize',8,'Color',[0 0+0.1*i 1-0.15*i ],'LineStyle','--')
hold on
plot(x2(6),P(6),'*','MarkerSize',8,'Color',[0 0+0.1*i 1-0.15*i ],'LineStyle','none')
hold on
xline(5.5,'--')
ylim([0.5 1])
xlim([0.5 6.5])
xticks([1 2 3 4 5 6]);
xticklabels({'1st grade', '2nd grade', '3rd grade', '4th grade', '5th grade', 'Aggregate'});
set(gca,'FontName','Times')
end
legend('School L (1)','','School H (1)','','','School L (2)','','School H (2)','','',...
    'School L (3)','','School H (3)','','','School L (4)','','School H (4)','','','Location','southeast')
hold off

