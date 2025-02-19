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

for treatment=1:2
    if treatment==1
        C = C_pencils;
    elseif treatment==2
        C = C_pens;
    end
iter=1;
for r = 1:732

clearvars N p_par_new pi_par_new F y p_par

p_par = 0.5;

g=1;

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
tol_LL = 1e-5; % Log-likelihood differences for the while loop

while   LL_dist>tol_LL
clearvars Q P % I clear the conditional probabilities matrices to recalculate them with the new estimated parameters
Q=[];
p_par = p_par_old;

temp_par = repmat(p_par,1,4); % Here, unique gamma per each alternative

%%% Here, we calculate the conditional probabilities matrices

%for i=1:size(p_par,1)
for i=1:size(p_par,1)
for u=1:lc
P(:,u) = P_Rho_varying_type(temp_par(i,:),PER,u,R); 
end

temp=P;
Q=[Q,temp];

end

% end

%%%


F=exp(C(r,:)*log(Q)); % This is the likelihood function


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

[p_par_new,~,~,~,~,grad,hessian] = fmincon(@(p_par) log_lik_model(p_par, pi_par_new, PER, lc, R, C(r,:)), p_par_old, [], [], [], [], lb, ub, [], options); % maximization of the likelihood w.r.t. to gamma

LL_dist = log_lik_model(p_par_old, pi_par_new, PER, lc, R, C(r,:)) - log_lik_model(p_par_new, pi_par_new, PER, lc, R, C(r,:)); % likelihood distance


pi_par_old = pi_par_new; % re-set the parameters in the while loop
p_par_old=p_par_new;
it=it+1;
end

parametersIND{treatment}(:,r) = p_par_new; % store the estimated gammas
preferencesIND{treatment}(r,:) = pi_par_new; % store the estimated probability distribution
HESSIAN{r,treatment} = hessian; % store the hessian matrix for the second maximization problem


LLIND{treatment}(r) = log_lik_model(exp(p_par_new)./(1+exp(p_par_new)), pi_par_new, PER, lc, R, C(r,:));



SS{treatment}(r,1) = sqrt(diag(inv(HESSIAN{r,treatment})));

r
end

end

rhoIND_av = (parametersIND{1}' + parametersIND{2}')./2;



%% PLOTS

load sliders.mat
load groups.mat
load gender_class_school.mat

spring = group < 8;

vote_pencils = Slider_pencils(:,7:end);
vote_pens = Slider_pens(:,7:end);

cv_pencils = std(vote_pencils,[],2)./mean(vote_pencils,2);
cv_pens = std(vote_pens,[],2)./mean(vote_pens,2);

cv_tot = cv_pencils + cv_pens;


%%% CONSIDERATION AND PREFERENCE INTENSITY pooled 


colors = ["#0072BD","#D95319",	"#EDB120",	"#7E2F8E",	"#77AC30"];

colors1 = ['b','r','y','m','g'];

subplot(1,2,1)
for i=1:5
[f1,x1,up1,low1] = ecdf(rhoIND_av(class==i & ~spring & (school==4 | school==1)));
up1(1)=0;
up2(1)=0;
low1(1)=0;
low2(1)=0;
up1(end)=1;
up2(end)=1;
low1(end)=1;
low2(end)=1;
b=plot(x1, f1);
b.Color = colors(i);
hold on
patch([x1; flipud(x1)], [up1; flipud(low1)], colors1(i), 'FaceAlpha',0.15, 'EdgeColor','none')
grid
xlabel('Consideration parameter')
title('Development of the consideration parameter','FontWeight','normal')
set(gca,'FontName','Times')
hold on
end
hold off
xlim([0.15 1])
legend('1° Grade','','2° Grade','','3° Grade','','4° Grade','','5° Grade','','Location','northwest')

subplot(1,2,2)
for i=1:5
[f1,x1,up1,low1] = ecdf(cv_tot(class==i & ~spring & (school==4 | school==1)));
up1(1)=0;
up2(1)=0;
low1(1)=0;
low2(1)=0;
up1(end)=1;
up2(end)=1;
low1(end)=1;
low2(end)=1;
b=plot(x1, f1);
b.Color = colors(i);
hold on
patch([x1; flipud(x1)], [up1; flipud(low1)], colors1(i), 'FaceAlpha',0.15, 'EdgeColor','none')
grid
xlabel('Coefficient of variation in the stated preferences')
title('Development of preference intensity','FontWeight','normal')
set(gca,'FontName','Times')
hold on
end
hold off
legend('1° Grade','','2° Grade','','3° Grade','','4° Grade','','5° Grade','','Location','northwest')



