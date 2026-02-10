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

% PROPORTIONS IN INDEPENDENT PACHINKO

IND = [sum(ind1_2w(newdata & fail_corr==0))/N(1), sum(ind2_2w(newdata & fail_corr==0))/N(1), sum(ind3_2w(newdata & fail_corr==0))/N(1);
    sum(ind1_2w(newdata & fail_corr==0 & class==5))/N(2), sum(ind2_2w(newdata & fail_corr==0 & class==5))/N(2), sum(ind3_2w(newdata & fail_corr==0 & class==5))/N(2);
    sum(ind1_2w(newdata & fail_corr==0 & class==4))/N(3), sum(ind2_2w(newdata & fail_corr==0 & class==4))/N(3), sum(ind3_2w(newdata & fail_corr==0 & class==4))/N(3);
    sum(ind1_2w(newdata & fail_corr==0 & class==3))/N(4), sum(ind2_2w(newdata & fail_corr==0 & class==3))/N(4), sum(ind3_2w(newdata & fail_corr==0 & class==3))/N(4);
    sum(ind1_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4)))/N(5), sum(ind2_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4)))/N(5), sum(ind3_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4)))/N(5);
    sum(ind1_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==5))/N(6), sum(ind2_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==5))/N(6), sum(ind3_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==5))/N(6);
    sum(ind1_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==4))/N(7), sum(ind2_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==4))/N(7), sum(ind3_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==4))/N(7);
    sum(ind1_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==3))/N(8), sum(ind2_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==3))/N(8), sum(ind3_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==3))/N(8);
    sum(ind1_2w(newdata & fail_corr==0 & school_pachinko==1))/N(9), sum(ind2_2w(newdata & fail_corr==0 & school_pachinko==1))/N(9), sum(ind3_2w(newdata & fail_corr==0 & school_pachinko==1))/N(9);
    sum(ind1_2w(newdata & fail_corr==0 & school_pachinko==1 & class==5))/N(10), sum(ind2_2w(newdata & fail_corr==0 & school_pachinko==1 & class==5))/N(10), sum(ind3_2w(newdata & fail_corr==0 & school_pachinko==1 & class==5))/N(10);
    sum(ind1_2w(newdata & fail_corr==0 & school_pachinko==1 & class==4))/N(11), sum(ind2_2w(newdata & fail_corr==0 & school_pachinko==1 & class==4))/N(11), sum(ind3_2w(newdata & fail_corr==0 & school_pachinko==1 & class==4))/N(11);
    sum(ind1_2w(newdata & fail_corr==0 & school_pachinko==1 & class==3))/N(12), sum(ind2_2w(newdata & fail_corr==0 & school_pachinko==1 & class==3))/N(12), sum(ind3_2w(newdata & fail_corr==0 & school_pachinko==1 & class==3))/N(12);
    sum(ind1_2w(newdata & fail_corr==0 & school_pachinko==4))/N(13), sum(ind2_2w(newdata & fail_corr==0 & school_pachinko==4))/N(13), sum(ind3_2w(newdata & fail_corr==0 & school_pachinko==4))/N(13);
    sum(ind1_2w(newdata & fail_corr==0 & school_pachinko==4 & class==5))/N(14), sum(ind2_2w(newdata & fail_corr==0 & school_pachinko==4 & class==5))/N(14), sum(ind3_2w(newdata & fail_corr==0 & school_pachinko==4 & class==5))/N(14);
    sum(ind1_2w(newdata & fail_corr==0 & school_pachinko==4 & class==4))/N(15), sum(ind2_2w(newdata & fail_corr==0 & school_pachinko==4 & class==4))/N(15), sum(ind3_2w(newdata & fail_corr==0 & school_pachinko==4 & class==4))/N(15);
    sum(ind1_2w(newdata & fail_corr==0 & school_pachinko==4 & class==3))/N(16), sum(ind2_2w(newdata & fail_corr==0 & school_pachinko==4 & class==3))/N(16), sum(ind3_2w(newdata & fail_corr==0 & school_pachinko==4 & class==3))/N(16);
    sum(ind1_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4))/N(17), sum(ind2_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4))/N(17), sum(ind3_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4))/N(17);
    sum(ind1_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==5))/N(18), sum(ind2_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==5))/N(18), sum(ind3_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==5))/N(18);
    sum(ind1_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==4))/N(19), sum(ind2_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==4))/N(19), sum(ind3_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==4))/N(19);
    sum(ind1_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==3))/N(20), sum(ind2_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==3))/N(20), sum(ind3_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==3))/N(20)];

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



%% PLOT

options=optimoptions('fmincon','display','off','MaxFunctionEvaluations',1e6,...
    'StepTolerance',1e-8,'FunctionTolerance',1e-8,'OptimalityTolerance',1e-8,'FiniteDifferenceType','central' );

clearvars xu xc

x0 = [0.5, 0.5, 0.5];

Aeq = [1,-1,0; 1,0,-1];
beq = [0;0];
lb=[0;0;0];
ub=[1;1;1];

for z=1:size(N,1)
[xc(:,z)] = fmincon(@(x) independent(x,IND(z,1),IND(z,2),IND(z,3),N(z,1)), x0', [],[],Aeq,beq,lb,ub,[],options);
end
xc = xc(1,:)';



x0 = [0.5, 0.5, 0.5];

lb=[0;0;0];
ub=[1;1;1];



for z=1:size(N,1)
[xu(:,z)] = fmincon(@(x) correlated2(x,CORR(z,1),CORR(z,2),CORR(z,3),N(z,1)), x0', [],[],[],[],lb,ub,[],options);
end
xu = ( xu(3,:)' - xu(1,:)'.*(1 - xu(3,:)') )./( xu(3,:)' + xu(1,:)'.*(1 - xu(3,:)') );



th= 0.1;
%cat = categorical({'3rd grade', '4th grade', '5th grade', 'aggregate'});
%cat = reordercats(cat,{'3rd grade', '4th grade', '5th grade', 'aggregate'});
x(1,:) = [0 0 0 0];
x(2,:) = [1 2 3 4]-th;
x(3,:) = [1 2 3 4];
x(4,:) = [1 2 3 4]+th;



%% PLOT all schools


subplot(1,2,1)
for i=3:5
    if i==3
P = [xc(4*i);xc(4*i-1);xc(4*i-2);xc(4*i-3)];
plot(x(i-1,1:3),P(1:3),'-*','MarkerSize',8,'Color','r')
hold on
plot(x(i-1,4),P(4),'*','MarkerSize',8,'Color','r')
hold on
%yline(0.5,'--')
%yline(1,'--')
hold on
    elseif i==4
P = [xc(4*i);xc(4*i-1);xc(4*i-2);xc(4*i-3)];
plot(x(i-1,1:3),P(1:3),'-*','MarkerSize',8,'Color','b')
hold on
plot(x(i-1,4),P(4),'*','MarkerSize',8,'Color','b')
hold on
%yline(0.5,'--')
%yline(1,'--')
hold on   
    else
P = [xc(4*i);xc(4*i-1);xc(4*i-2);xc(4*i-3)];
plot(x(i-1,1:3),P(1:3),'-*','MarkerSize',8,'Color','g')
hold on
plot(x(i-1,4),P(4),'*','MarkerSize',8,'Color','g')
hold on
%yline(0.5,'--')
%yline(1,'--')
hold on           
    end
end
xline(3.5,'--')
xlim([0 5])
xticks([1 2 3 4]);
xticklabels({'3rd grade', '4th grade', '5th grade', 'Aggregate'});
ylim([0 1])
legend('','School L','','School H','','Schools M')
set(gca,'FontName','Times')

subplot(1,2,2)
for i=3:5
    if i==3
P = [xu(4*i);xu(4*i-1);xu(4*i-2);xu(4*i-3)];
plot(x(i-1,1:3),P(1:3),'-*','MarkerSize',8,'Color','r')
hold on
plot(x(i-1,4),P(4),'*','MarkerSize',8,'Color','r')
hold on
%yline(0.5,'--')
%yline(1,'--')
hold on
    elseif i==4
P = [xu(4*i);xu(4*i-1);xu(4*i-2);xu(4*i-3)];
plot(x(i-1,1:3),P(1:3),'-*','MarkerSize',8,'Color','b')
hold on
plot(x(i-1,4),P(4),'*','MarkerSize',8,'Color','b')
hold on
%yline(0.5,'--')
%yline(1,'--')
hold on   
    else
P = [xu(4*i);xu(4*i-1);xu(4*i-2);xu(4*i-3)];
plot(x(i-1,1:3),P(1:3),'-*','MarkerSize',8,'Color','g')
hold on
plot(x(i-1,4),P(4),'*','MarkerSize',8,'Color','g')
hold on
    end
end
xline(3.5,'--')
xlim([0 5])
xticks([1 2 3 4]);
xticklabels({'3rd grade', '4th grade', '5th grade', 'Aggregate'});
ylim([-1 1])
legend('','School L','','School H','','Schools M')
set(gca,'FontName','Times')

