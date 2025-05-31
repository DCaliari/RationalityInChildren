%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Figure 8 - Joint distribution Coin drop game %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%% Correlation between the two waves
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

%% Joint distribution for independent/correlated choices for Marconi and Russo
M = school_pachinko == 4; % Marconi group
R = school_pachinko == 1; % Russo group
E = school_pachinko > 1 & school_pachinko < 4; % Other schools

% Sum valid data points for each class across the relevant categories
for i = 3:5
    sum(newdata & M & class == i & fail_corr == 0); % Sum for Marconi
    sum(newdata & R & class == i & fail_corr == 0); % Sum for Russo
    sum(newdata & E & class == i & fail_corr == 0); % Sum for other schools
end

% Titles for the heatmap plots
tt = {'Grade 3° - School H - (n = 48)', 'Grade 4° - School H - (n = 50)', 'Grade 5° - School H - (n = 48)'};
tl = {'Grade 3° - School L - (n = 36)', 'Grade 4° - School L - (n = 46)', 'Grade 5° - School L - (n = 44)'};
tm = {'Grade 3° - Schools M - (n = 16)', 'Grade 4° - Schools M - (n = 35)', 'Grade 5° - Schools M - (n = 40)'};

% Create heatmaps for Marconi's group
for i = 1:3
    subplot(2, 3, i) % Subplot layout
    i = i + 2;      % Adjust index for class selection
    joint = zeros(3); % Initialize joint distribution matrix

    % Calculate joint distribution for Marconi's school
    joint(1, 1) = sum(corr1_2w(newdata & M & class == i & fail_corr == 0) == 1 & ...
                      ind1_2w(newdata & M & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & M & class == i & fail_corr == 0);
    joint(1, 2) = sum(corr1_2w(newdata & M & class == i & fail_corr == 0) == 1 & ...
                      ind2_2w(newdata & M & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & M & class == i & fail_corr == 0);
    joint(1, 3) = sum(corr1_2w(newdata & M & class == i & fail_corr == 0) == 1 & ...
                      ind3_2w(newdata & M & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & M & class == i & fail_corr == 0);
    joint(2, 1) = sum(corr2_2w(newdata & M & class == i & fail_corr == 0) == 1 & ...
                      ind1_2w(newdata & M & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & M & class == i & fail_corr == 0);
    joint(2, 2) = sum(corr2_2w(newdata & M & class == i & fail_corr == 0) == 1 & ...
                      ind2_2w(newdata & M & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & M & class == i & fail_corr == 0);
    joint(2, 3) = sum(corr2_2w(newdata & M & class == i & fail_corr == 0) == 1 & ...
                      ind3_2w(newdata & M & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & M & class == i & fail_corr == 0);
    joint(3, 1) = sum(corr3_2w(newdata & M & class == i & fail_corr == 0) == 1 & ...
                      ind1_2w(newdata & M & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & M & class == i & fail_corr == 0);
    joint(3, 2) = sum(corr3_2w(newdata & M & class == i & fail_corr == 0) == 1 & ...
                      ind2_2w(newdata & M & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & M & class == i & fail_corr == 0);
    joint(3, 3) = sum(corr3_2w(newdata & M & class == i & fail_corr == 0) == 1 & ...
                      ind3_2w(newdata & M & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & M & class == i & fail_corr == 0);

    % Create heatmap for joint distribution 
    cat = categorical({'5', '6', '7'}); % Define categories for heatmap
    heatmap(cat, cat, joint, 'ColorLimits', [0, 0.5], 'FontName', 'Times New Roman'); % Generate heatmap
    xlabel('Independent'); % Label x-axis
    ylabel('Correlated');   % Label y-axis
    title(tt{i - 2});       % Title for the subplot
    set(gca, 'Fontname', "Times"); % Set font for the axes
end

% Create heatmaps for Russo's group
for i = 1:3
    subplot(2, 3, i + 3) % Subplot layout
    i = i + 2;          % Adjust index again for class selection

    R = school_pachinko == 1; % Russo group

    joint = zeros(3); % Initialize joint distribution matrix for Russo
    joint(1, 1) = sum(corr1_2w(newdata & R & class == i & fail_corr == 0) == 1 & ...
                      ind1_2w(newdata & R & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & R & class == i & fail_corr == 0);
    joint(1, 2) = sum(corr1_2w(newdata & R & class == i & fail_corr == 0) == 1 & ...
                      ind2_2w(newdata & R & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & R & class == i & fail_corr == 0);
    joint(1, 3) = sum(corr1_2w(newdata & R & class == i & fail_corr == 0) == 1 & ...
                      ind3_2w(newdata & R & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & R & class == i & fail_corr == 0);
    joint(2, 1) = sum(corr2_2w(newdata & R & class == i & fail_corr == 0) == 1 & ...
                      ind1_2w(newdata & R & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & R & class == i & fail_corr == 0);
    joint(2, 2) = sum(corr2_2w(newdata & R & class == i & fail_corr == 0) == 1 & ...
                      ind2_2w(newdata & R & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & R & class == i & fail_corr == 0);
    joint(2, 3) = sum(corr2_2w(newdata & R & class == i & fail_corr == 0) == 1 & ...
                      ind3_2w(newdata & R & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & R & class == i & fail_corr == 0);
    joint(3, 1) = sum(corr3_2w(newdata & R & class == i & fail_corr == 0) == 1 & ...
                      ind1_2w(newdata & R & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & R & class == i & fail_corr == 0);
    joint(3, 2) = sum(corr3_2w(newdata & R & class == i & fail_corr == 0) == 1 & ...
                      ind2_2w(newdata & R & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & R & class == i & fail_corr == 0);
    joint(3, 3) = sum(corr3_2w(newdata & R & class == i & fail_corr == 0) == 1 & ...
                      ind3_2w(newdata & R & class == i & fail_corr == 0) == 1) / ...
                   sum(newdata & R & class == i & fail_corr == 0);

    % Create heatmap for joint distribution 
    cat = categorical({'5', '6', '7'}); % Define categories for heatmap
    heatmap(cat, cat, joint, 'ColorLimits', [0, 0.5], 'FontName', 'Times New Roman'); % Generate heatmap
    xlabel('Independent'); % Label x-axis
    ylabel('Correlated');   % Label y-axis
    title(tl{i - 2});       % Title for the subplot
    set(gca, 'Fontname', "Times"); % Set font for the axes
end