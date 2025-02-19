%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% PLOTS and STATISTICS pachinko %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% loading key variables

create_variables

create_pachinko_dataset

%%% dummy for classes covered by second wave
covered = zeros(length(group),1);
for i=1:length(group)
    covered(i,1) = ismember(group(i),groups_pachinko2ndwave);
end
covered = logical(covered);

%%% dummy for attrition

attrition = zeros(length(group),1);
for i=1:length(group)
    attrition(i,1) = isnan(ind1_2w(i)) & covered(i);
end

ATTRITION = 1-sum(covered.*attrition)/sum(covered);

% generate the variable win/lose

win = (threes_twos==1 & esito<5 & esito>0) | (threes_ones == 1 & esito<8 & esito>0) | (twos_ones==1 & esito<8 & esito>0);
win=double(win);
win(esito==0)=99;

newdata = covered & ~attrition;


%%% create school_pachinko variable

for i=1:size(groups_classes,1)
if strcmp(groups_classes(i,2),'russo')
    groups_classes{i,4}=1;
elseif strcmp(groups_classes(i,2),'trincone')
    groups_classes{i,4}=2;
elseif strcmp(groups_classes(i,2),'fatale')
    groups_classes{i,4}=3;
elseif strcmp(groups_classes(i,2),'marconi')
    groups_classes{i,4}=4;
end
end

groups_p = DATA_pachinko.group;


school_pachinko = ismember(cell2mat(groups_classes(:,1)),groups_p);
temp = [cell2mat(groups_classes(:,1)),cell2mat(groups_classes(:,4))];
temp = temp(school_pachinko,:);

for i=1:size(groups_p,1)
    for j=1:size(groups_p,1)
        if groups_p(i,1)==temp(j,1)
            tt(i)=temp(j,2);
            break  
        end
    end
end
school_pachinko = tt';

school_class_pachinko = [reshape(repmat([1,2,3,4],3,1),[],1),repmat([3,4,5],1,4)'];

fail_corr = (corr1_2w + corr2_2w + corr3_2w)>1 | (corr1_2w + corr2_2w + corr3_2w)==0;



%% BOOTSTRAP STANDARD ERRORS FOR ALL ESTIMATES

% SAMPLE SIZE for all sub-populations

N = [sum(newdata & fail_corr==0);
    sum(newdata & fail_corr==0 & class==5);
    sum(newdata & fail_corr==0 & class==4);
    sum(newdata & fail_corr==0 & class==3);
    sum(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4));
    sum(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==5);
    sum(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==4);
    sum(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==3);
    sum(newdata & fail_corr==0 & school_pachinko==1);
    sum(newdata & fail_corr==0 & school_pachinko==1 & class==5);
    sum(newdata & fail_corr==0 & school_pachinko==1 & class==4);
    sum(newdata & fail_corr==0 & school_pachinko==1 & class==3);
    sum(newdata & fail_corr==0 & school_pachinko==4);
    sum(newdata & fail_corr==0 & school_pachinko==4 & class==5);
    sum(newdata & fail_corr==0 & school_pachinko==4 & class==4);
    sum(newdata & fail_corr==0 & school_pachinko==4 & class==3);
    sum(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4);
    sum(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==5);
    sum(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==4);
    sum(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==3)];


CORR = [sum(corr1_2w(newdata & fail_corr==0))/N(1), sum(corr2_2w(newdata & fail_corr==0))/N(1), sum(corr3_2w(newdata & fail_corr==0))/N(1);
    sum(corr1_2w(newdata & fail_corr==0 & class==5))/N(2), sum(corr2_2w(newdata & fail_corr==0 & class==5))/N(2), sum(corr3_2w(newdata & fail_corr==0 & class==5))/N(2);
    sum(corr1_2w(newdata & fail_corr==0 & class==4))/N(3), sum(corr2_2w(newdata & fail_corr==0 & class==4))/N(3), sum(corr3_2w(newdata & fail_corr==0 & class==4))/N(3);
    sum(corr1_2w(newdata & fail_corr==0 & class==3))/N(4), sum(corr2_2w(newdata & fail_corr==0 & class==3))/N(4), sum(corr3_2w(newdata & fail_corr==0 & class==3))/N(4);
    sum(corr1_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4)))/N(5), sum(corr2_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4)))/N(5), sum(corr3_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4)))/N(5);
    sum(corr1_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==5))/N(6), sum(corr2_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==5))/N(6), sum(corr3_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==5))/N(6);
    sum(corr1_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==4))/N(7), sum(corr2_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==4))/N(7), sum(corr3_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==4))/N(7);
    sum(corr1_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==3))/N(8), sum(corr2_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==3))/N(8), sum(corr3_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==3))/N(8);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko==1))/N(9), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko==1))/N(9), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko==1))/N(9);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko==1 & class==5))/N(10), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko==1 & class==5))/N(10), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko==1 & class==5))/N(10);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko==1 & class==4))/N(11), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko==1 & class==4))/N(11), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko==1 & class==4))/N(11);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko==1 & class==3))/N(12), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko==1 & class==3))/N(12), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko==1 & class==3))/N(12);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko==4))/N(13), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko==4))/N(13), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko==4))/N(13);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko==4 & class==5))/N(14), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko==4 & class==5))/N(14), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko==4 & class==5))/N(14);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko==4 & class==4))/N(15), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko==4 & class==4))/N(15), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko==4 & class==4))/N(15);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko==4 & class==3))/N(16), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko==4 & class==3))/N(16), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko==4 & class==3))/N(16);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4))/N(17), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4))/N(17), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4))/N(17);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==5))/N(18), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==5))/N(18), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==5))/N(18);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==4))/N(19), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==4))/N(19), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==4))/N(19);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==3))/N(20), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==3))/N(20), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==3))/N(20)];




%% Likelihood ratio tests

options=optimoptions('fmincon','display','off','MaxFunctionEvaluations',1e6,...
    'StepTolerance',1e-8,'FunctionTolerance',1e-8,'OptimalityTolerance',1e-8,'FiniteDifferenceType','central' );

%%% Estimates correlated

for z=1:size(N,1)
x0 = [0.5, 0.5, 0.5];

Aeq = [1,-1,0; 1,0,-1];
beq = [0;0];
lb=[0;0;0];
ub=[1;1;1];

[xc] = fmincon(@(x) correlated2(x,CORR(z,1),CORR(z,2),CORR(z,3),N(z,1)), x0', [],[],Aeq,beq,lb,ub,[],[])

[xu] = fmincon(@(x) correlated2(x,CORR(z,1),CORR(z,2),CORR(z,3),N(z,1)), x0', [],[],[0,1,0],0.5,lb,ub,[],[])

A = round(CORR(z,1)*N(z,1));
B = round(CORR(z,2)*N(z,1));
C = round(CORR(z,3)*N(z,1));


R = 1-(xc(1)*(1-xc(2))*(1-xc(3)) + xc(2)*(1-xc(1))*(1-xc(3)) + xc(3)*(1-xc(1))*(1-xc(2)) + (1-xc(1))*(1-xc(2))*(1-xc(3)));
LL1 = - A*log((xc(1)*xc(2)*(1- xc(3)))/R) - B*log((xc(1)*xc(3)*(1- xc(2)))/R)- C*log((xc(2)*xc(3))/R);
P1 = [(xc(1)*xc(2)*(1- xc(3)))/R, (xc(1)*xc(3)*(1- xc(2)))/R, (xc(2)*xc(3))/R];

R = 1-(xu(1)*(1-xu(2))*(1-xu(3)) + xu(2)*(1-xu(1))*(1-xu(3)) + xu(3)*(1-xu(1))*(1-xu(2)) + (1-xu(1))*(1-xu(2))*(1-xu(3)));
LL2 = - A*log((xu(1)*xu(2)*(1- xu(3)))/R) - B*log((xu(1)*xu(3)*(1- xu(2)))/R)- C*log((xu(2)*xu(3))/R);
P2 = [(xu(1)*xu(2)*(1- xu(3)))/R, (xu(1)*xu(3)*(1- xu(2)))/R, (xu(2)*xu(3))/R];

LL3 = - A*log(CORR(z,1)) - B*log(CORR(z,2)) - C*log(CORR(z,3));

[h(z), pvalue(z)] = lratiotest(-LL2, -LL1, 1)
end


Correlated = [N(9:16,:),CORR(9:16,:),pvalue(:,9:16)'];

TABLE4 = array2table(Correlated,"RowNames",{'Agg School L', '5th School L', '4th School L', '3rd School L','Agg School H', '5th School H', '4th School H', '3rd School H'},...
    "VariableNames",{'N','L5','L6','L7','LRT'});
