%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ECMA MODEL ESTIMATIONS %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

create_warp_datasets

[DATA1,DATA2,~,~,~,~] = dataset_constructions(DATASET(:,1:6),n); % use the function "dataset_constructions" to obtain the dataset for estimation

C_pencils = DATA1; % These are the choices from the pencils
C_pens = DATA2; % These are the choices from the pens

%% Here I load data on school, groups, class, etc...

load groups.mat 

load gender_class_school.mat

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

%% Here the estimation's loop starts

for treatment = 1:2
    if treatment==1 % Focus on pencils
        C = C_pencils;
    elseif treatment==2 % Focus on pens
        C = C_pens;
    end


iter=1;

for z=1:size(T,2) % Here we go through the subpopulations

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

parameters{treatment}(:,z) = p_par_new; % store the estimated gammas
preferences{treatment}(z,:) = pi_par_new; % store the estimated probability distribution



RHO{treatment}(z,1) = sum(reshape(preferences{treatment}(z,:),24,g))*parameters{treatment}(:,z); % store the average gamma if there are more than one

HESSIAN{treatment}{z,1} = hessian; % store the hessian matrix for the second maximization problem

fs{treatment}{z,1} =F;

%end
%end

%% BOOTSTRAP STANDARD ERRORS

B=10000; % number of re-sampling for the bootstrap

y = randi(N,N,B); % random re-sampling

for b=1:B
    clearvars N p_par_new pi_par_new

%%% choices from the new sample

y_temp = y(:,b);
tempC = C(T(:,z),:);
tempC = tempC(y_temp,:);

%%%

p_par = 0.5;

pi_par=ones(1,(g)*lc)/((g)*lc);

pi_par_old=pi_par;

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
F=exp(tempC*log(Q)); 


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

p_par_new = fmincon(@(p_par) log_lik_model(p_par, pi_par_new, PER, lc, R, tempC), p_par_old, [], [], [], [], lb, ub, [], options);

% LL_dist = log_lik_attempt(p_par_old, pi_par_old, PER, lc, R, C) - log_lik_attempt(p_par_new, pi_par_new, PER, lc, R, C)
LL_dist = log_lik_model(p_par_old, pi_par_new, PER, lc, R, tempC) - log_lik_model(p_par_new, pi_par_new, PER, lc, R, tempC);

% par_dist=norm(pi_par_new-pi_par_old);
%
pi_par_old = pi_par_new;
p_par_old=p_par_new;
it=it+1;
end

RHObootstrap{treatment}(b,z) = sum(reshape(pi_par_new,24,g))*p_par_new;


b
end


z
end

STANDARDERR{treatment} = std(RHObootstrap{treatment});


treatment
end



x = [1 2 3 4 5 6];
x1 = x-0.1;
x2 = x+0.1;

subplot(1,2,1)

P_L = RHO{1}([1:5 11]);
S_L = STANDARDERR{1}([1:5 11]);
plot(x1(1:5),P_L(1:5),'*','MarkerSize',8,'Color','r')
hold on
errorbar(x1(1:5),P_L(1:5),S_L(1:5),S_L(1:5),'LineStyle','--','LineWidth',0.8)
hold on
plot(x1(6),P_L(6),'*','MarkerSize',8,'Color','r','LineStyle','none')
hold on
errorbar(x1(6),P_L(6),S_L(6),S_L(6),'LineStyle','none','LineWidth',0.8,'Color','r')
hold on


% Adding numbers next to the stars for School L (offset to the right)
for i = 1:length(P_L)
    text(x1(i) + 0.1, P_L(i), num2str(P_L(i), '%.2f'), 'FontSize', 13, 'FontName', 'Times', 'Color', 'r', 'HorizontalAlignment', 'left');
end

P_H = RHO{1}([6:10 12]);
S_H = STANDARDERR{1}([6:10 12]);
plot(x2(1:5),P_H(1:5),'*','MarkerSize',8,'Color','b')
hold on
errorbar(x2(1:5),P_H(1:5),S_H(1:5),S_H(1:5),'LineStyle','--','LineWidth',0.8,'Color','b')
hold on
plot(x2(6),P_H(6),'*','MarkerSize',8,'Color','b','LineStyle','none')
hold on
errorbar(x2(6),P_H(6),S_H(6),S_H(6),'LineStyle','none','LineWidth',0.8,'Color','b')
hold on


% Adding numbers next to the stars for School H (offset to the left)
for i = 1:length(P_H)
    text(x2(i) - 0.1, P_H(i), num2str(P_H(i), '%.2f'), 'FontSize', 13, 'FontName', 'Times', 'Color', 'b', 'HorizontalAlignment', 'right');
end


xline(5.5,'--')
ylim([0.5 1])
xlim([0.5 6.5])
xticks([1 2 3 4 5 6]);
xticklabels({'1st grade', '2nd grade', '3rd grade', '4th grade', '5th grade', 'Aggregate'});
legend('School L','','','','School H','','','','','Location','southeast')
set(gca,'FontName','Times')
hold off




subplot(1,2,2)

P_L = RHO{2}([1:5 11]);
S_L = STANDARDERR{2}([1:5 11]);
plot(x1(1:5),P_L(1:5),'*','MarkerSize',8,'Color','r')
hold on
errorbar(x1(1:5),P_L(1:5),S_L(1:5),S_L(1:5),'LineStyle','--','LineWidth',0.8)
hold on
plot(x1(6),P_L(6),'*','MarkerSize',8,'Color','r','LineStyle','none')
hold on
errorbar(x1(6),P_L(6),S_L(6),S_L(6),'LineStyle','none','LineWidth',0.8,'Color','r')
hold on


% Adding numbers next to the stars for School L (offset to the right)
for i = 1:length(P_L)
    text(x1(i) + 0.1, P_L(i), num2str(P_L(i), '%.2f'), 'FontSize', 13, 'FontName', 'Times', 'Color', 'r', 'HorizontalAlignment', 'left');
end

P_H = RHO{2}([6:10 12]);
S_H = STANDARDERR{2}([6:10 12]);
plot(x2(1:5),P_H(1:5),'*','MarkerSize',8,'Color','b')
hold on
errorbar(x2(1:5),P_H(1:5),S_H(1:5),S_H(1:5),'LineStyle','--','LineWidth',0.8,'Color','b')
hold on
plot(x2(6),P_H(6),'*','MarkerSize',8,'Color','b','LineStyle','none')
hold on
errorbar(x2(6),P_H(6),S_H(6),S_H(6),'LineStyle','none','LineWidth',0.8,'Color','b')
hold on


% Adding numbers next to the stars for School H (offset to the left)
for i = 1:length(P_H)
    text(x2(i) - 0.1, P_H(i), num2str(P_H(i), '%.2f'), 'FontSize', 13, 'FontName', 'Times', 'Color', 'b', 'HorizontalAlignment', 'right');
end


xline(5.5,'--')
ylim([0.5 1])
xlim([0.5 6.5])
xticks([1 2 3 4 5 6]);
xticklabels({'1st grade', '2nd grade', '3rd grade', '4th grade', '5th grade', 'Aggregate'});
legend('School L','','','','School H','','','','','Location','southeast')
set(gca,'FontName','Times')
hold off

