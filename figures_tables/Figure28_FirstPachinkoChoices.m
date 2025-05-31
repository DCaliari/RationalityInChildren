
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


st_err = [std(ra_2w(treatment==0 & ok_control==1 & threes_twos==1 & ~isnan(ra_2w)))/sqrt(sum(treatment==0 & ok_control==1 & threes_twos==1 & ~isnan(ra_2w)))
          std(ra_2w(treatment==0 & ok_control==1 & threes_ones==1 & ~isnan(ra_2w)))/sqrt(sum(treatment==0 & ok_control==1 & threes_ones==1 & ~isnan(ra_2w)))
          std(ra_2w(treatment==0 & ok_control==1 & twos_ones==1 & ~isnan(ra_2w)))/sqrt(sum(treatment==0 & ok_control==1 & twos_ones==1 & ~isnan(ra_2w)))
];

mean0 =  [mean(ra_2w(treatment==0 & ok_control==1 & threes_twos==1 & ~isnan(ra_2w)))
          mean(ra_2w(treatment==0 & ok_control==1 & threes_ones==1 & ~isnan(ra_2w)))
          mean(ra_2w(treatment==0 & ok_control==1 & twos_ones==1 & ~isnan(ra_2w)))
];


st_err1 = [std(ra_2w(treatment==1 & ok_control==1 & threes_twos==1 & ~isnan(ra_2w)))/sqrt(sum(treatment==1 & ok_control==1 & threes_twos==1 & ~isnan(ra_2w)))
          std(ra_2w(treatment==1 & ok_control==1 & threes_ones==1 & ~isnan(ra_2w)))/sqrt(sum(treatment==1 & ok_control==1 & threes_ones==1 & ~isnan(ra_2w)))
          std(ra_2w(treatment==1 & ok_control==1 & twos_ones==1 & ~isnan(ra_2w)))/sqrt(sum(treatment==1 & ok_control==1 & twos_ones==1 & ~isnan(ra_2w)))
];

mean1 =  [mean(ra_2w(treatment==1 & ok_control==1 & threes_twos==1 & ~isnan(ra_2w)))
          mean(ra_2w(treatment==1 & ok_control==1 & threes_ones==1 & ~isnan(ra_2w)))
          mean(ra_2w(treatment==1 & ok_control==1 & twos_ones==1 & ~isnan(ra_2w)))
];


cat = categorical({'3-2', '3-1', '2-1'});
cat = reordercats(cat,{'3-2', '3-1', '2-1'});
subplot(1,2,1)
plot(cat,mean0,'*','MarkerSize',8)
hold on
errorbar(cat,mean0,st_err,'LineStyle','none','Linewidth',1.1)
hold off
ylim([1 7])
yline(4,'--')
legend('Mean Risk','Standard errors','Risk Neutrality')
set(gca,'FontName','Times')
subplot(1,2,2)
plot(cat,mean1,'*','MarkerSize',8)
hold on
errorbar(cat,mean1,st_err1,'LineStyle','none','Linewidth',1.1)
hold off
ylim([1 7])
yline(4,'--')
legend('Mean Risk','Standard errors','Risk Neutrality')
set(gca,'FontName','Times')

