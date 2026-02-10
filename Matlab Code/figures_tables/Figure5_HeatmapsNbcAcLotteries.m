%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 5: Joint Distributions NBC/AC and Ind/Corr %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Load key variables and datasets
create_variables          
create_pachinko_dataset   

%%% Create a dummy variable for classes covered by the second wave
covered = zeros(length(group), 1); % Initialize covered variable
for i = 1:length(group)
    covered(i, 1) = ismember(group(i), groups_pachinko2ndwave); % Check if the group is part of the second wave
end
covered = logical(covered); % Convert to logical values

% Among the classes covered in November 2022 some pupils were not at school
% in Spring 2023.
% The check isnan(ind1_2w(i)) selects those pupils who answered our 
% experiment in Spring 2023


% 87% of the pupils that we covered in November 2022, were also covered in
% Spring 2023
attrition = zeros(length(group), 1); % Initialize attrition variable
for i = 1:length(group)
    attrition(i, 1) = isnan(ind1_2w(i)) & covered(i); % Indicate attrition based on NaN checks and coverage
end

% Calculate overall attrition rate
ATTRITION = 1 - sum(covered .* attrition) / sum(covered);

newdata = covered & ~attrition;  % These are the pupils that solved the coin-drop game in Spring 2023

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

groups_p = DATA_pachinko.group; % Retrieve groups from pachinko dataset

% Determine which schools are in the pachinko dataset
school_pachinko = ismember(cell2mat(groups_classes(:, 1)), groups_p);
temp = [cell2mat(groups_classes(:, 1)), cell2mat(groups_classes(:, 4))];
temp = temp(school_pachinko, :); % Filter relevant data based on school membership

% Create a mapping of groups to their numerical identifiers
for i = 1:size(groups_p, 1)
    for j = 1:size(groups_p, 1)
        if groups_p(i, 1) == temp(j, 1)
            tt(i) = temp(j, 2); % Map school identifier to previously defined index
            break  
        end
    end
end
school_pachinko = tt'; % Update school_pachinko with mapped identifiers

% Create a variable for school-class combinations
school_class_pachinko = [reshape(repmat([1, 2, 3, 4], 3, 1), [], 1), ...
                         repmat([3, 4, 5], 1, 4)'];

% Dummy for those pupils that did not answer correctly the correlated task
% Only 1% of the pupils!
fail_corr = (corr1_2w + corr2_2w + corr3_2w) > 1 | ...
             (corr1_2w + corr2_2w + corr3_2w) == 0;

class_pachinko = class;

clearvars -except school_pachinko fail_corr newdata class_pachinko ...
    corr1_2w corr2_2w corr3_2w ind1_2w ind2_2w ind3_2w groups_classes groups_p

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




%% PLOTS OF JOINT DISTRIBUTIONS


F = 14; % fontsize



M = school_pachinko == 4 | school_pachinko == 1; % Both schools L and H

% Sum valid data points for each class across the relevant categories

% Create heatmaps for Marconi's group
    joint = zeros(3); % Initialize joint distribution matrix

    % Calculate joint distribution for Marconi's school
    joint(1, 1) = sum(corr1_2w(newdata & M &  fail_corr == 0) == 1 & ...
                      ind1_2w(newdata & M &  fail_corr == 0) == 1) / ...
                   sum(newdata & M &  fail_corr == 0);
    joint(1, 2) = sum(corr1_2w(newdata & M &  fail_corr == 0) == 1 & ...
                      ind2_2w(newdata & M &  fail_corr == 0) == 1) / ...
                   sum(newdata & M &  fail_corr == 0);
    joint(1, 3) = sum(corr1_2w(newdata & M &  fail_corr == 0) == 1 & ...
                      ind3_2w(newdata & M &  fail_corr == 0) == 1) / ...
                   sum(newdata & M &  fail_corr == 0);
    joint(2, 1) = sum(corr2_2w(newdata & M &  fail_corr == 0) == 1 & ...
                      ind1_2w(newdata & M &  fail_corr == 0) == 1) / ...
                   sum(newdata & M &  fail_corr == 0);
    joint(2, 2) = sum(corr2_2w(newdata & M &  fail_corr == 0) == 1 & ...
                      ind2_2w(newdata & M &  fail_corr == 0) == 1) / ...
                   sum(newdata & M &  fail_corr == 0);
    joint(2, 3) = sum(corr2_2w(newdata & M &  fail_corr == 0) == 1 & ...
                      ind3_2w(newdata & M &  fail_corr == 0) == 1) / ...
                   sum(newdata & M &  fail_corr == 0);
    joint(3, 1) = sum(corr3_2w(newdata & M &  fail_corr == 0) == 1 & ...
                      ind1_2w(newdata & M &  fail_corr == 0) == 1) / ...
                   sum(newdata & M &  fail_corr == 0);
    joint(3, 2) = sum(corr3_2w(newdata & M &  fail_corr == 0) == 1 & ...
                      ind2_2w(newdata & M &  fail_corr == 0) == 1) / ...
                   sum(newdata & M &  fail_corr == 0);
    joint(3, 3) = sum(corr3_2w(newdata & M &  fail_corr == 0) == 1 & ...
                      ind3_2w(newdata & M &  fail_corr == 0) == 1) / ...
                   sum(newdata & M &  fail_corr == 0);

joint_rounded = round(joint, 2);

% Fix rounding to make sure sum is exactly 100:
diff = 1 - sum(joint_rounded(:));
% Add the difference to the largest element to keep the sum consistent
[~, idx] = max(joint_rounded(:));
joint_rounded(idx) = joint_rounded(idx) + diff;

subplot(1,3,3)

    % Create heatmap for joint distribution 
    cat = categorical({'5', '6', '7'}); % Define categories for heatmap
    heatmap(cat, cat, joint_rounded, 'ColorLimits', [0, 0.5], 'FontName', 'Times New Roman','FontSize',F); % Generate heatmap
    xlabel('Independent'); % Label x-axis
    ylabel('Correlated');   % Label y-axis
    set(gca, 'Fontname', "Times"); % Set font for the axes





    temp = (school==1 | school==4) & ~spring;
    subplot(1, 3, 1) % Subplot layout
    joint = zeros(2); % Initialize joint distribution matrix
    n = size(AC_pencils(temp),1);
    % Calculate joint distribution for Marconi's school
    joint(2, 1) = sum(AC_pencils(temp)==0 & BC_pencils(temp)>0)  / ...
                   size(AC_pencils(temp),1);
    joint(2, 2) = sum(AC_pencils(temp)>0 & BC_pencils(temp)>0)  / ...
                   size(AC_pencils(temp),1);
    joint(1, 1) = sum(AC_pencils(temp)==0 & BC_pencils(temp)==0)  / ...
                   size(AC_pencils(temp),1);
    joint(1, 2) = sum(AC_pencils(temp)>0 & BC_pencils(temp)==0)  / ...
                   size(AC_pencils(temp),1);

    % Round to 2 decimals
   
b(i) = joint(2,1)/joint(2,2);
a(i) = joint(1,1)/joint(1,2);

joint_rounded = round(joint, 2);

% Fix rounding to make sure sum is exactly 100:
diff = 1 - sum(joint_rounded(:));
% Add the difference to the largest element to keep the sum consistent
[~, idx] = max(joint_rounded(:));
joint_rounded(idx) = joint_rounded(idx) + diff;

    % Create heatmap for joint distribution 
    cat1 = categorical({'AC', '~AC'});
    cat2 = categorical({'NBC', '~NBC'}); % Define categories for heatmap
    heatmap(cat1, cat2, joint_rounded, 'ColorLimits', [0, 1], 'FontName', 'Times New Roman','FontSize',F); % Generate heatmap
    title('Pencils')
    xlabel('Always Chosen'); % Label x-axis
    ylabel('No Binary Cycle');   % Label y-axis
    set(gca, 'Fontname', "Times"); % Set font for the axes






    temp = (school==1 | school==4) & ~spring;
    subplot(1, 3, 2) % Subplot layout
    joint = zeros(2); % Initialize joint distribution matrix
    n = size(AC_pens(temp),1);
    % Calculate joint distribution for Marconi's school
    joint(2, 1) = sum(AC_pens(temp)==0 & BC_pens(temp)>0)  / ...
                   size(AC_pens(temp),1);
    joint(2, 2) = sum(AC_pens(temp)>0 & BC_pens(temp)>0)  / ...
                   size(AC_pens(temp),1);
    joint(1, 1) = sum(AC_pens(temp)==0 & BC_pens(temp)==0)  / ...
                   size(AC_pens(temp),1);
    joint(1, 2) = sum(AC_pens(temp)>0 & BC_pens(temp)==0)  / ...
                   size(AC_pens(temp),1);

    % Round to 2 decimals
   
b(i) = joint(2,1)/joint(2,2);
a(i) = joint(1,1)/joint(1,2);

joint_rounded = round(joint, 2);

% Fix rounding to make sure sum is exactly 100:
diff = 1 - sum(joint_rounded(:));
% Add the difference to the largest element to keep the sum consistent
[~, idx] = max(joint_rounded(:));
joint_rounded(idx) = joint_rounded(idx) + diff;

    % Create heatmap for joint distribution 
    cat1 = categorical({'AC', '~AC'});
    cat2 = categorical({'NBC', '~NBC'}); % Define categories for heatmap
    heatmap(cat1, cat2, joint_rounded, 'ColorLimits', [0, 1], 'FontName', 'Times New Roman','FontSize',F); % Generate heatmap
    title('Pens')
    xlabel('Always Chosen'); % Label x-axis
    ylabel('No Binary Cycle');   % Label y-axis
    set(gca, 'Fontname', "Times"); % Set font for the axes



%% Chi-square tests

% create the vectors for chi-square test
corr = corr1_2w(newdata & M &  fail_corr == 0) + ...
    corr2_2w(newdata & M &  fail_corr == 0).*2 + ...
corr3_2w(newdata & M &  fail_corr == 0).*3;

ind = ind1_2w(newdata & M &  fail_corr == 0) + ...
    ind2_2w(newdata & M &  fail_corr == 0).*2 + ...
ind3_2w(newdata & M &  fail_corr == 0).*3;

% Crosstabulation and chi-square test
[~,chi2stat,pval] = crosstab(corr, ind);
% chi2stat = chi-square test statistic
% pval = p-value of the test
disp(['Chi-square statistic: ' num2str(chi2stat)]);
disp(['p-value: ' num2str(pval)]);


% Crosstabulation and chi-square test
[~,chi2stat,pval] = crosstab(AC_pencilsR(temp), BC_pencilsR(temp));
% chi2stat = chi-square test statistic
% pval = p-value of the test
disp(['Chi-square statistic: ' num2str(chi2stat)]);
disp(['p-value: ' num2str(pval)]);

% Crosstabulation and chi-square test
[~,chi2stat,pval] = crosstab(AC_pensR(temp), BC_pensR(temp));
% chi2stat = chi-square test statistic
% pval = p-value of the test
disp(['Chi-square statistic: ' num2str(chi2stat)]);
disp(['p-value: ' num2str(pval)]);


