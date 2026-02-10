
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Figure 17 %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% loading variables

create_variables

create_pachinko_dataset


%% RISK AVERSION BY GENDER

cat = {'Male','Female'};
al_goodplot(ra_2w(gender==0 & ~isnan(ra_2w) & ra_2w>0 & ra_2w<8), 1,0.25)
al_goodplot(ra_2w(gender==1 & ~isnan(ra_2w) & ra_2w>0 & ra_2w<8), 2,0.25)
set(gca,'xtick',1:1:2,'xticklabel',cat)
ylabel('Risk')
set(gca,'FontName','Times')

