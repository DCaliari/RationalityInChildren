%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Table 8-9 - Joint Distributions NBC and AC %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc

load data_heatmap_ACBC.mat
load groups.mat 
load gender_class_school

spring = group < 8; % I focus on the pupils who did the experiment in the autumn

for i=1:size(data{1,1},1)
PENCILS(:,i) = data{1,1}{i,1}(:,5);
PENS(:,i) = data{2,1}{i,1}(:,5);
end

[AC_pencils, BC_pencils, ~] = AC_BC(PENCILS);
[AC_pens, BC_pens, ~] = AC_BC(PENS); 

AC_pencilsR = AC_pencils == 0;
BC_pencilsR = BC_pencils == 0;

AC_pensR = AC_pens == 0;
BC_pensR = BC_pens == 0;

%% Table 8

T_pencils = [];

for i=1:5
[table,chi2,p] = crosstab(AC_pencilsR(~spring & class==i & (school==1 | school==4)),BC_pencilsR(~spring & class==i & (school==1 | school==4)));
[table(1,1),table(2,2)] = deal(table(2,2), table(1,1)); % same order as in the paper, with Yes-Yes top-left and No-No bottom-right
table = table/sum(~spring & class==i & (school==1 | school==4));
T_pencils = [T_pencils,table];
end

[table,chi2,p] = crosstab(AC_pencilsR(~spring & (school==1)),BC_pencilsR(~spring & (school==1)));
[table(1,1),table(2,2)] = deal(table(2,2), table(1,1)); % same order as in the paper, with Yes-Yes top-left and No-No bottom-right
table = table/sum(~spring & (school==1));
T_pencils = [T_pencils,table];

[table,chi2,p] = crosstab(AC_pencilsR(~spring & (school==4)),BC_pencilsR(~spring & (school==4)));
[table(1,1),table(2,2)] = deal(table(2,2), table(1,1)); % same order as in the paper, with Yes-Yes top-left and No-No bottom-right
table = table/sum(~spring & (school==4));
T_pencils = [T_pencils,table];

TABLE8 = array2table(T_pencils,"RowNames",{'NBC-yes', 'NBC-no'},...
    "VariableNames",{'AC-yes (1st)','AC-no (1st)','AC-yes (2nd)','AC-no (2nd)','AC-yes (3rd)','AC-no (3rd)', ...
    'AC-yes (4th)','AC-no (4th)','AC-yes (5th)','AC-no (5th)','AC-yes (L)','AC-no (L)','AC-yes (H)','AC-no (H)'});

%% Table 9 
T_pens = [];

for i=1:5
[table,chi2,p] = crosstab(AC_pensR(~spring & class==i & (school==1 | school==4)),BC_pensR(~spring & class==i & (school==1 | school==4)));
[table(1,1),table(2,2)] = deal(table(2,2), table(1,1)); % same order as in the paper, with Yes-Yes top-left and No-No bottom-right
table = table/sum(~spring & class==i & (school==1 | school==4));
T_pens = [T_pens,table];
end
% aggregate
% [table,chi2,p] = crosstab(AC_pensR(~spring & (school==1 | school==4)),BC_pensR(~spring & (school==1 | school==4)));
% [table(1,1),table(2,2)] = deal(table(2,2), table(1,1)); % same order as in the paper, with Yes-Yes top-left and No-No bottom-right
% table = table/sum(~spring & (school==1 | school==4));
% T_pens = [T_pens,table];


[table,chi2,p] = crosstab(AC_pensR(~spring & (school==1)),BC_pensR(~spring & (school==1)));
[table(1,1),table(2,2)] = deal(table(2,2), table(1,1)); % same order as in the paper, with Yes-Yes top-left and No-No bottom-right
table = table/sum(~spring & (school==1));
T_pens = [T_pens,table];

[table,chi2,p] = crosstab(AC_pensR(~spring & (school==4)),BC_pensR(~spring & (school==4)));
[table(1,1),table(2,2)] = deal(table(2,2), table(1,1)); % same order as in the paper, with Yes-Yes top-left and No-No bottom-right
table = table/sum(~spring & (school==4));
T_pens = [T_pens,table];

TABLE9 = array2table(T_pens,"RowNames",{'NBC-yes', 'NBC-no'},...
    "VariableNames",{'AC-yes (1st)','AC-no (1st)','AC-yes (2nd)','AC-no (2nd)','AC-yes (3rd)','AC-no (3rd)', ...
    'AC-yes (4th)','AC-no (4th)','AC-yes (5th)','AC-no (5th)','AC-yes (L)','AC-no (L)','AC-yes (H)','AC-no (H)'});





