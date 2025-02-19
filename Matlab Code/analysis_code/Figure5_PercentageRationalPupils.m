%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Figure on percentage of rational pupils %%%%%%%%%
%%%%%%%% and statistical tests %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

fail_corr = (corr1_2w + corr2_2w + corr3_2w)>1 | (corr1_2w + corr2_2w + corr3_2w)==0; % number of pupils who failed to answer the "Choice with risk" part

%% Only school L and H 

clear a b c

%% CLASS 5
N=sum(newdata & fail_corr==0 & class==5 & (school_pachinko==1 | school_pachinko==4));
% independent
a(1,3) = sum(ind1_2w(newdata & fail_corr==0 & class==5 & (school_pachinko==1 | school_pachinko==4)))/N;
b(1,3) = sum(ind2_2w(newdata & fail_corr==0 & class==5 & (school_pachinko==1 | school_pachinko==4)))/N;
c(1,3) = sum(ind3_2w(newdata & fail_corr==0 & class==5 & (school_pachinko==1 | school_pachinko==4)))/N;
% correlated
a(2,3) = sum(corr1_2w(newdata & fail_corr==0 & class==5 & (school_pachinko==1 | school_pachinko==4)))/N;
b(2,3) = sum(corr2_2w(newdata & fail_corr==0 & class==5 & (school_pachinko==1 | school_pachinko==4)))/N;
c(2,3) = sum(corr3_2w(newdata & fail_corr==0 & class==5 & (school_pachinko==1 | school_pachinko==4)))/N;
% independent and correlated
c(3,3) = sum(corr3_2w(newdata & fail_corr==0 & class==5 & (school_pachinko==1 | school_pachinko==4))==1 & ind3_2w(newdata & fail_corr==0 & class==5 & (school_pachinko==1 | school_pachinko==4))==1)/N;

%% CLASS 4
N=sum(newdata & fail_corr==0 & class==4 & (school_pachinko==1 | school_pachinko==4));
% independent
a(1,2) = sum(ind1_2w(newdata & fail_corr==0 & class==4 & (school_pachinko==1 | school_pachinko==4)))/N;
b(1,2) = sum(ind2_2w(newdata & fail_corr==0 & class==4 & (school_pachinko==1 | school_pachinko==4)))/N;
c(1,2) = sum(ind3_2w(newdata & fail_corr==0 & class==4 & (school_pachinko==1 | school_pachinko==4)))/N;
% correlated
a(2,2) = sum(corr1_2w(newdata & fail_corr==0 & class==4 & (school_pachinko==1 | school_pachinko==4)))/N;
b(2,2) = sum(corr2_2w(newdata & fail_corr==0 & class==4 & (school_pachinko==1 | school_pachinko==4)))/N;
c(2,2) = sum(corr3_2w(newdata & fail_corr==0 & class==4 & (school_pachinko==1 | school_pachinko==4)))/N;
% independent and correlated
c(3,2) = sum(corr3_2w(newdata & fail_corr==0 & class==4 & (school_pachinko==1 | school_pachinko==4))==1 & ind3_2w(newdata & fail_corr==0 & class==4 & (school_pachinko==1 | school_pachinko==4))==1)/N;

%% CLASS 3
N=sum(newdata & fail_corr==0 & class==3 & (school_pachinko==1 | school_pachinko==4));
% independent
a(1,1) = sum(ind1_2w(newdata & fail_corr==0 & class==3 & (school_pachinko==1 | school_pachinko==4)))/N;
b(1,1) = sum(ind2_2w(newdata & fail_corr==0 & class==3 & (school_pachinko==1 | school_pachinko==4)))/N;
c(1,1) = sum(ind3_2w(newdata & fail_corr==0 & class==3 & (school_pachinko==1 | school_pachinko==4)))/N;
% correlated
a(2,1) = sum(corr1_2w(newdata & fail_corr==0 & class==3 & (school_pachinko==1 | school_pachinko==4)))/N;
b(2,1) = sum(corr2_2w(newdata & fail_corr==0 & class==3 & (school_pachinko==1 | school_pachinko==4)))/N;
c(2,1) = sum(corr3_2w(newdata & fail_corr==0 & class==3 & (school_pachinko==1 | school_pachinko==4)))/N;
% independent and correlated
c(3,1) = sum(corr3_2w(newdata & fail_corr==0 & class==3 & (school_pachinko==1 | school_pachinko==4))==1 & ind3_2w(newdata & fail_corr==0 & class==3 & (school_pachinko==1 | school_pachinko==4))==1)/N;


%% Plots

n = [sum(newdata & fail_corr==0 & class==3 & (school_pachinko==1 | school_pachinko==4)),sum(newdata & fail_corr==0 & class==4 & (school_pachinko==1 | school_pachinko==4)),sum(newdata & fail_corr==0 & class==5 & (school_pachinko==1 | school_pachinko==4));
    sum(newdata & fail_corr==0 & class==3 & (school_pachinko==1 | school_pachinko==4)),sum(newdata & fail_corr==0 & class==4 & (school_pachinko==1 | school_pachinko==4)),sum(newdata & fail_corr==0 & class==5 & (school_pachinko==1 | school_pachinko==4));
    sum(newdata & fail_corr==0 & class==3 & (school_pachinko==1 | school_pachinko==4)),sum(newdata & fail_corr==0 & class==4 & (school_pachinko==1 | school_pachinko==4)),sum(newdata & fail_corr==0 & class==5 & (school_pachinko==1 | school_pachinko==4))];

se = sqrt((c.*(1-c))./n); % standard errors

grade = categorical({'3rd grade','4th grade', '5th grade'});

subplot(1,2,2)
plot(grade,c(3,:),'-*','MarkerSize',8,'Color','g')
hold on
errorbar(grade, c(3,:), se(3,:), -se(3,:),'LineStyle','none','Linewidth',1.1,'Color','g')
hold on
plot(grade,c(1,:),'-*','MarkerSize',8,'Color','b')
hold on
errorbar(grade, c(1,:), se(1,:), -se(1,:),'LineStyle','none','Linewidth',1.1,'Color','b')
hold on
plot(grade,c(2,:),'-*','MarkerSize',8,'Color','r')
hold on
errorbar(grade, c(2,:), se(2,:), -se(2,:),'LineStyle','none','Linewidth',1.1,'Color','r')
hold off
ylim([0 1])
set(gca,'FontName','Times')
legend('Both','','Independent','', 'Correlated','', 'Location', 'northwest')


%% 

load dataset_WARP
load kids_raven
load gender_class_school

rational = dataset_WARP(:,1)==0 & dataset_WARP(:,2)==0;
rational1 = dataset_WARP(:,1)==0;
rational2 = dataset_WARP(:,2)==0;


for i=1:5
a(1,i) = sum(rational(class==i & (school==1 | school==4)))/sum(class==i & (school==1 | school==4));
a(2,i) = sum(rational1(class==i & (school==1 | school==4)))/sum(class==i & (school==1 | school==4));
a(3,i) = sum(rational2(class==i & (school==1 | school==4)))/sum(class==i & (school==1 | school==4));
end

clear nn
for i=1:5
nn(1,i) = sum(class==i & (school==1 | school==4));
end
nn = repmat(nn,3,1);

grade = categorical({'1st grade','2nd grade','3rd grade','4th grade', '5th grade'});

sse = sqrt((a.*(1-a))./nn);

subplot(1,2,1)
plot(grade,a(1,:),'-*','MarkerSize',8,'Color','g')
hold on
errorbar(grade, a(1,:), sse(1,:), -sse(1,:),'LineStyle','none','Linewidth',1.1,'Color','g')
hold on
plot(grade,a(2,:),'-*','MarkerSize',8,'Color','b')
hold on
errorbar(grade, a(2,:), sse(2,:), -sse(2,:),'LineStyle','none','Linewidth',1.1,'Color','b')
hold on
plot(grade,a(3,:),'-*','MarkerSize',8,'Color','r')
hold on
errorbar(grade, a(3,:), sse(3,:), -sse(3,:),'LineStyle','none','Linewidth',1.1,'Color','r')
hold off
ylim([0 1])
set(gca,'FontName','Times')
legend('Both','', 'Pencils','', 'Pens','')



