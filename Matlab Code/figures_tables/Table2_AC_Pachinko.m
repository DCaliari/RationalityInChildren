%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Table 2: Joint Distributions AC/Ind/Corr %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Load key variables and datasets
create_variables          
create_pachinko_dataset   

[~, idx] = sort(Pachinko(:,1));
Pachinkosorted = Pachinko(idx,:); % order the dataset by groups to allow the analysis with the AC/BC dataset

ind1_2w = Pachinkosorted(:,19); %2w means second wave
ind2_2w = Pachinkosorted(:,20);
ind3_2w = Pachinkosorted(:,21);

corr1_2w = Pachinkosorted(:,27); %2w means second wave
corr2_2w = Pachinkosorted(:,28);
corr3_2w = Pachinkosorted(:,29);

fail_corr = (corr1_2w + corr2_2w + corr3_2w) > 1 | ...
             (corr1_2w + corr2_2w + corr3_2w) == 0;

%%% Create school_pachinko variable
% Assign numeric identifiers to school classes
for i = 1:size(groups_classes, 1)
    if strcmp(groups_classes(i, 2), 'russo')
        groups_classes{i, 4} = 1;
    elseif strcmp(groups_classes(i, 2), 'trincone')
        groups_classes{i, 4} = 2;
    elseif strcmp(groups_classes(i, 2), 'fatale')
        groups_classes{i, 4} = 3;
    elseif strcmp(groups_classes(i, 2), 'marconi')
        groups_classes{i, 4} = 4;
    end
end




%% load data to calculate always chosen and no binary cycle

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


AC_pencilsPachinko = AC_pencilsR(ismember(cell2mat(groups_classes(:, 1)), groups_pachinko2ndwave));
AC_pensPachinko = AC_pensR(ismember(cell2mat(groups_classes(:, 1)), groups_pachinko2ndwave));

school_pachinko = school(ismember(cell2mat(groups_classes(:, 1)), groups_pachinko2ndwave));

M = school_pachinko == 1 | school_pachinko == 4; % focus on School L and School H


    joint_pencils(1, 1) = sum(ind1_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pencilsPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 1) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
    joint_pencils(1, 2) = sum(ind2_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pencilsPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 1) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
    joint_pencils(1, 3) = sum(ind3_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pencilsPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 1) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
joint_pencils(1, 4) = sum(corr1_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pencilsPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 1) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
    joint_pencils(1, 5) = sum(corr2_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pencilsPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 1) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
    joint_pencils(1, 6) = sum(corr3_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pencilsPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 1) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);    
    joint_pencils(2, 1) = sum(ind1_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pencilsPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) ==0) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
    joint_pencils(2, 2) = sum(ind2_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pencilsPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) ==0) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
    joint_pencils(2, 3) = sum(ind3_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pencilsPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) ==0) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
joint_pencils(2, 4) = sum(corr1_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pencilsPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) ==0) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
    joint_pencils(2, 5) = sum(corr2_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pencilsPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) ==0) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
    joint_pencils(2, 6) = sum(corr3_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pencilsPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) ==0) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);




    joint_pens(1, 1) = sum(ind1_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pensPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 1) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
    joint_pens(1, 2) = sum(ind2_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pensPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 1) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
    joint_pens(1, 3) = sum(ind3_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pensPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 1) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
joint_pens(1, 4) = sum(corr1_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pensPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 1) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
    joint_pens(1, 5) = sum(corr2_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pensPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 1) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
    joint_pens(1, 6) = sum(corr3_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pensPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 1) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);    

    joint_pens(2, 1) = sum(ind1_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pensPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 0) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
    joint_pens(2, 2) = sum(ind2_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pensPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 0) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
    joint_pens(2, 3) = sum(ind3_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pensPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 0) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
joint_pens(2, 4) = sum(corr1_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pensPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 0) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
    joint_pens(2, 5) = sum(corr2_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pensPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 0) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);
    joint_pens(2, 6) = sum(corr3_2w(~isnan(corr1_2w) & M &  fail_corr == 0) == 1 & ...
                      AC_pensPachinko(~isnan(corr1_2w) & M &  fail_corr == 0) == 0) / ...
                   sum(~isnan(corr1_2w) & M &  fail_corr == 0);    




% create the vectors for chi-square test
corr = corr1_2w(~isnan(corr1_2w) & M &  fail_corr == 0) + ...
    corr2_2w(~isnan(corr1_2w) & M &  fail_corr == 0).*2 + ...
corr3_2w(~isnan(corr1_2w) & M &  fail_corr == 0).*3;

ind = ind1_2w(~isnan(corr1_2w) & M &  fail_corr == 0) + ...
    ind2_2w(~isnan(corr1_2w) & M &  fail_corr == 0).*2 + ...
ind3_2w(~isnan(corr1_2w) & M &  fail_corr == 0).*3;


acpencils = double(AC_pencilsPachinko(~isnan(corr1_2w) & M &  fail_corr == 0));
acpens = double(AC_pensPachinko(~isnan(corr1_2w) & M &  fail_corr == 0));


% Crosstabulation and chi-square test
[~,chi2stat,pval] = crosstab(corr, acpencils );
% chi2stat = chi-square test statistic
% pval = p-value of the test
disp(['Chi-square statistic: ' num2str(chi2stat)]);
disp(['p-value: ' num2str(pval)]);
[~,chi2stat,pval] = crosstab(ind, acpencils );
% chi2stat = chi-square test statistic
% pval = p-value of the test
disp(['Chi-square statistic: ' num2str(chi2stat)]);
disp(['p-value: ' num2str(pval)]);
% Crosstabulation and chi-square test
[~,chi2stat,pval] = crosstab(corr, acpens );
% chi2stat = chi-square test statistic
% pval = p-value of the test
disp(['Chi-square statistic: ' num2str(chi2stat)]);
disp(['p-value: ' num2str(pval)]);
[~,chi2stat,pval] = crosstab(ind, acpens );
% chi2stat = chi-square test statistic
% pval = p-value of the test
disp(['Chi-square statistic: ' num2str(chi2stat)]);
disp(['p-value: ' num2str(pval)]);





% Create the table

TABLE2 = array2table([joint_pencils, joint_pens],"RowNames",{'AC - yes', 'AC - no'},...
    "VariableNames",{'5ind','6ind','7ind','5corr','6corr','7corr','5indPens','6indPens','7indPens','5corrPens','6corrPens','7corrPens'});


