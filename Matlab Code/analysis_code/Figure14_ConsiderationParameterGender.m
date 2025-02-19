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


%% ESTIMATES BY GENDER


TT(:,1) = gender & class == 1 & ~spring & (school ==1 | school == 4);
TT(:,2) = gender & class == 2 & ~spring & (school ==1 | school == 4);
TT(:,3) = gender & class == 3 & ~spring & (school ==1 | school == 4);
TT(:,4) = gender & class == 4 & ~spring & (school ==1 | school == 4);
TT(:,5) = gender & class == 5 & ~spring & (school ==1 | school == 4);
TT(:,6) = ~gender & class == 1 & ~spring & (school ==1 | school == 4);
TT(:,7) = ~gender & class == 2 & ~spring & (school ==1 | school == 4);
TT(:,8) = ~gender & class == 3 & ~spring & (school ==1 | school == 4);
TT(:,9) = ~gender & class == 4 & ~spring & (school ==1 | school == 4);
TT(:,10) = ~gender & class == 5 & ~spring & (school ==1 | school == 4);
TT(:,11) = gender & ~spring & (school ==1 | school == 4);
TT(:,12) = ~gender & ~spring & (school ==1 | school == 4);


iter=1;


for treatment = 1:2
    if treatment==1
        C = C_pencils;
    elseif treatment==2
        C = C_pens;
    end

for z=1:12


clearvars N p_par_new pi_par_new F y

h=0;

g = h+2;

N=size(C(TT(:,z),:),1);


p_par = 0.5;

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
tol_LL = 1e-7;


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
F=exp(C(TT(:,z),:)*log(Q)); 


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


[p_par_new,~,~,~,~,grad,hessian] = fmincon(@(p_par) log_lik_model(p_par, pi_par_new, PER, lc, R, C(TT(:,z),:)), p_par_old, [], [], [], [], lb, ub, [], options);

LL_dist = log_lik_model(p_par_old, pi_par_new, PER, lc, R, C(TT(:,z),:)) - log_lik_model(p_par_new, pi_par_new, PER, lc, R, C(TT(:,z),:));


pi_par_old = pi_par_new;
p_par_old=p_par_new;
it=it+1;
end

PREF{treatment}(z,:) = pi_par_new;
RHO_gender{treatment}(z) = p_par_new



B=10000;
y = randi(N,N,B);

for b=1:B
    clearvars N p_par_new pi_par_new 

y_temp = y(:,b);
tempC = C(TT(:,z),:);
tempC = tempC(y_temp,:);

p_par = 0.5;

%%%% This is to check that the starting point does not modify the estimates

pi_par=ones(1,(g-1)*lc)/((g-1)*lc);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

p_par_new = fmincon(@(p_par) log_lik_model(p_par, pi_par_new, PER, lc, R, tempC), p_par_old, [], [], [], [], lb, ub, [], options);

LL_dist = log_lik_model(p_par_old, pi_par_new, PER, lc, R, tempC) - log_lik_model(p_par_new, pi_par_new, PER, lc, R, tempC);

pi_par_old = pi_par_new;
p_par_old=p_par_new;
it=it+1;
end

RHObootstrap_gender{treatment}(b,z) = sum(reshape(pi_par_new,24,g-1))*p_par_new;


b
end


z
end

STANDARDERR_gender{treatment} = std(RHObootstrap_gender{treatment});


treatment
end


cat1 = categorical({'DLFS','DLSF','DFLS','DFSL','DSLF','DSFL','LDFS','LDSF','LFDS','LFSD','LSDF',...
    'LSFD','FDLS','FDSL','FLDS','FLSD','FSDL','FSLD','SDLF','SDFL','SLDF','SLFD','SFDL','SFLD'});

cat1 = reordercats(cat1,{'DLFS','DLSF','DFLS','DFSL','DSLF','DSFL','LDFS','LDSF','LFDS','LFSD','LSDF',...
    'LSFD','FDLS','FDSL','FLDS','FLSD','FSDL','FSLD','SDLF','SDFL','SLDF','SLFD','SFDL','SFLD'});

cat2 = categorical({'YRBG','YRGB','YBRG','YBGR','YGRB','YGBR','RYBG','RYGB','RBYG','RBGY','RGYB',...
    'RGBY','BYRG','BYGR','BRYG','BRGY','BGYR','BGRY','GYRB','GYBR','GRYB','GRBY','GBYR','GBRY'});

cat2 = reordercats(cat2,{'YRBG','YRGB','YBRG','YBGR','YGRB','YGBR','RYBG','RYGB','RBYG','RBGY','RGYB',...
    'RGBY','BYRG','BYGR','BRYG','BRGY','BGYR','BGRY','GYRB','GYBR','GRYB','GRBY','GBYR','GBRY'});


x = [1 2 3 4 5];
x1 = x-0.1;
x2 = x+0.1;

subplot(2,2,1)
P_gen = RHO_gender{1}(1:5);
S_gen = STANDARDERR_gender{1}(1:5);
plot(x1,P_gen,'*','MarkerSize',8,'Color','r')
hold on
errorbar(x1,P_gen,S_gen,S_gen,'LineStyle','--','Color','r')
hold on
P_gen = RHO_gender{1}(6:10);
S_gen = STANDARDERR_gender{1}(6:10);
plot(x2,P_gen,'*','MarkerSize',8,'Color','b')
hold on
errorbar(x2,P_gen,S_gen,S_gen,'LineStyle','--','Color','b')
ylim([0.5 1])
xlim([0.5 5.5])
xticks([1 2 3 4 5]);
xticklabels({'1st grade', '2nd grade', '3rd grade', '4th grade', '5th grade'});
legend('Female','','Male','','Location','southeast')
set(gca,'FontName','Times')
hold off
subplot(2,2,2)
b1 = bar(cat1,PREF{1}(11:12,:));
ylim([0 0.3])
legend('Female','Male')
set(gca,'FontName','Times')
b1(1).FaceColor = 'r';
b1(2).FaceColor = 'b';
subplot(2,2,3)
P_gen = RHO_gender{2}(1:5);
S_gen = STANDARDERR_gender{2}(1:5);
plot(x1,P_gen,'*','MarkerSize',8,'Color','r')
hold on
errorbar(x1,P_gen,S_gen,S_gen,'LineStyle','--','Color','r')
hold on
P_gen = RHO_gender{2}(6:10);
S_gen = STANDARDERR_gender{2}(6:10);
plot(x2,P_gen,'*','MarkerSize',8,'Color','b')
hold on
errorbar(x2,P_gen,S_gen,S_gen,'LineStyle','--','Color','b')
ylim([0.5 1])
xlim([0.5 5.5])
xticks([1 2 3 4 5]);
xticklabels({'1st grade', '2nd grade', '3rd grade', '4th grade', '5th grade'});
legend('Female','','Male','','Location','southeast')
set(gca,'FontName','Times')
hold off
subplot(2,2,4)
b2 = bar(cat2,PREF{2}(11:12,:));
set(gca,'FontName','Times')
ylim([0 0.3])
legend('Female','Male')
set(gca,'FontName','Times')
b2(1).FaceColor = 'r';
b2(2).FaceColor = 'b';


