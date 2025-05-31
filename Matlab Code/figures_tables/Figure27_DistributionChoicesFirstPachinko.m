
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


%% correlation between the 2 waves

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


%% CHOICES PACHINKO 1ST WAVE TREATMENT VS CONTROL


m_nt = [sum(treatment==0 & ok_control==1 & threes_twos==1)/sum(treatment==0 & ok_control==1)
    sum(treatment==0 & ok_control==1 & threes_ones==1)/sum(treatment==0 & ok_control==1)
    sum(treatment==0 & ok_control==1 & twos_ones==1)/sum(treatment==0 & ok_control==1)];

m_t = [sum(treatment==1 & ok_control==1 & threes_twos==1)/sum(treatment==1 & ok_control==1)
    sum(treatment==1 & ok_control==1 & threes_ones==1)/sum(treatment==1 & ok_control==1)
    sum(treatment==1 & ok_control==1 & twos_ones==1)/sum(treatment==1 & ok_control==1)];

st_err_nt = [sqrt((sum(treatment==0 & ok_control==1 & threes_twos==1)/sum(treatment==0 & ok_control==1))*(1-sum(treatment==0 & ok_control==1 & threes_twos==1)/sum(treatment==0 & ok_control==1))/sum(treatment==0 & ok_control==1))
sqrt((sum(treatment==0 & ok_control==1 & threes_ones==1)/sum(treatment==0 & ok_control==1))*(1-sum(treatment==0 & ok_control==1 & threes_ones==1)/sum(treatment==0 & ok_control==1))/sum(treatment==0 & ok_control==1))
sqrt((sum(treatment==0 & ok_control==1 & twos_ones==1)/sum(treatment==0 & ok_control==1))*(1-sum(treatment==0 & ok_control==1 & twos_ones==1)/sum(treatment==0 & ok_control==1))/sum(treatment==0 & ok_control==1))];

st_err_t = [sqrt((sum(treatment==1 & ok_control==1 & threes_twos==1)/sum(treatment==1 & ok_control==1))*(1-sum(treatment==1 & ok_control==1 & threes_twos==1)/sum(treatment==1 & ok_control==1))/sum(treatment==1 & ok_control==1))
sqrt((sum(treatment==1 & ok_control==1 & threes_ones==1)/sum(treatment==1 & ok_control==1))*(1-sum(treatment==1 & ok_control==1 & threes_ones==1)/sum(treatment==1 & ok_control==1))/sum(treatment==1 & ok_control==1))
sqrt((sum(treatment==1 & ok_control==1 & twos_ones==1)/sum(treatment==1 & ok_control==1))*(1-sum(treatment==1 & ok_control==1 & twos_ones==1)/sum(treatment==1 & ok_control==1))/sum(treatment==1 & ok_control==1))];


% chi2 for proportions
%[h1,p1, chi2stat1,df1] = prop_test([sum(threes_twos.*treatment), sum(threes_twos.*(~treatment))] , [sum(treatment), sum(~treatment)] , true); 
%[h2,p2, chi2stat2,df2] = prop_test([sum(threes_ones.*treatment), sum(threes_ones.*(~treatment))] , [sum(treatment), sum(~treatment)] , true); 
%[h3,p3, chi2stat3,df3] = prop_test([sum(twos_ones.*treatment), sum(twos_ones.*(~treatment))] , [sum(treatment), sum(~treatment)] , true); 


cat = categorical({'3-2', '3-1', '2-1'});
cat = reordercats(cat,{'3-2', '3-1', '2-1'});
for i=1:3
subplot(1,3,i)
bar(1,m_nt(i))
hold on
errorbar(1,m_nt(i),st_err_nt(i),'LineStyle','none','Linewidth',1.1)
hold on
bar(2,m_t(i))
hold on
errorbar(2,m_t(i),st_err_t(i),'LineStyle','none','Linewidth',1.1)
ylim([0 0.8])
xticks([])
legend('Independent','','Correlated','')
title(cat(i),'FontWeight','normal')
set(gca,'FontName','Times')
end
hold off



