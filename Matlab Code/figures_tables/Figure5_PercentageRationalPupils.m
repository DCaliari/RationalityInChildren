%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Figure on percentage of rational pupils %%%%%%%%%
%%%%%%%% and statistical tests %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Loading key variables and datasets
create_variables     
create_pachinko_dataset

%%% Create a dummy variable for classes covered by the second wave
covered = zeros(length(group), 1); % Initialize covered array
for i = 1:length(group)
    % Check if each group is a part of the second wave
    covered(i, 1) = ismember(group(i), groups_pachinko2ndwave);
end
covered = logical(covered); % Convert to logical array


% Among the classes covered in November 2022 some pupils were not at school
% in Spring 2023.
% The check isnan(ind1_2w(i)) selects those pupils who answered our 
% experiment in Spring 2023

% 87% of the pupils that we covered in November 2022, were also covered in
% Spring 2023
attrition = zeros(length(group), 1); 
for i = 1:length(group)
    attrition(i, 1) = isnan(ind1_2w(i)) & covered(i);
end
ATTRITION = 1 - sum(covered .* attrition) / sum(covered);

% These are the pupils that solved the coin-drop game in Spring 2023
newdata = covered & ~attrition;


%%% Create a school_pachinko variable based on class groups
for i = 1:size(groups_classes, 1)
    % Assign numeric codes based on the group names
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

groups_p = DATA_pachinko.group; % Group information from pachinko dataset

school_pachinko = ismember(cell2mat(groups_classes(:, 1)), groups_p);
temp = [cell2mat(groups_classes(:, 1)), cell2mat(groups_classes(:, 4))];
temp = temp(school_pachinko, :); % Filter relevant data 

% Mapping groups to their respective school levels
for i = 1:size(groups_p, 1)
    for j = 1:size(groups_p, 1)
        if groups_p(i, 1) == temp(j, 1)
            tt(i) = temp(j, 2); % Assign mapped school level
            break  
        end
    end
end
school_pachinko = tt'; % Transform into column vector

% Create a school_class_pachinko variable for analysis
school_class_pachinko = [reshape(repmat([1, 2, 3, 4], 3, 1), [], 1), ...
                         repmat([3, 4, 5], 1, 4)'];

% Dummy for those pupils that did not answer correctly the correlated task
% Only 1% of the pupils!
fail_corr = (corr1_2w + corr2_2w + corr3_2w) > 1 | ...
            (corr1_2w + corr2_2w + corr3_2w) == 0; 

%% Only analyze data from School L and H

clear a b c % Clear previous declarations for new calculations


% Empirical distributions of the independent task. 
% We exclude 

%% CLASS 5 Analysis
N = sum(newdata & fail_corr == 0 & class == 5 & (school_pachinko == 1 | school_pachinko == 4)); % Total number of non-failures
% Independent responses
a(1, 3) = sum(ind1_2w(newdata & fail_corr == 0 & class == 5 & (school_pachinko == 1 | school_pachinko == 4))) / N;
b(1, 3) = sum(ind2_2w(newdata & fail_corr == 0 & class == 5 & (school_pachinko == 1 | school_pachinko == 4))) / N;
c(1, 3) = sum(ind3_2w(newdata & fail_corr == 0 & class == 5 & (school_pachinko == 1 | school_pachinko == 4))) / N;

% Correlated responses
a(2, 3) = sum(corr1_2w(newdata & fail_corr == 0 & class == 5 & (school_pachinko == 1 | school_pachinko == 4))) / N;
b(2, 3) = sum(corr2_2w(newdata & fail_corr == 0 & class == 5 & (school_pachinko == 1 | school_pachinko == 4))) / N;
c(2, 3) = sum(corr3_2w(newdata & fail_corr == 0 & class == 5 & (school_pachinko == 1 | school_pachinko == 4))) / N;

% Independent and correlated responses
c(3, 3) = sum(corr3_2w(newdata & fail_corr == 0 & class == 5 & (school_pachinko == 1 | school_pachinko == 4)) == 1 & ...
                ind3_2w(newdata & fail_corr == 0 & class == 5 & (school_pachinko == 1 | school_pachinko == 4)) == 1) / N;

%% CLASS 4 Analysis
N = sum(newdata & fail_corr == 0 & class == 4 & (school_pachinko == 1 | school_pachinko == 4)); % Total non-failures
% Independent responses
a(1, 2) = sum(ind1_2w(newdata & fail_corr == 0 & class == 4 & (school_pachinko == 1 | school_pachinko == 4))) / N;
b(1, 2) = sum(ind2_2w(newdata & fail_corr == 0 & class == 4 & (school_pachinko == 1 | school_pachinko == 4))) / N;
c(1, 2) = sum(ind3_2w(newdata & fail_corr == 0 & class == 4 & (school_pachinko == 1 | school_pachinko == 4))) / N;

% Correlated responses
a(2, 2) = sum(corr1_2w(newdata & fail_corr == 0 & class == 4 & (school_pachinko == 1 | school_pachinko == 4))) / N;
b(2, 2) = sum(corr2_2w(newdata & fail_corr == 0 & class == 4 & (school_pachinko == 1 | school_pachinko == 4))) / N;
c(2, 2) = sum(corr3_2w(newdata & fail_corr == 0 & class == 4 & (school_pachinko == 1 | school_pachinko == 4))) / N;

% Independent and correlated responses
c(3, 2) = sum(corr3_2w(newdata & fail_corr == 0 & class == 4 & (school_pachinko == 1 | school_pachinko == 4)) == 1 & ...
                ind3_2w(newdata & fail_corr == 0 & class == 4 & (school_pachinko == 1 | school_pachinko == 4)) == 1) / N;

%% CLASS 3 Analysis
N = sum(newdata & fail_corr == 0 & class == 3 & (school_pachinko == 1 | school_pachinko == 4)); % Total non-failures
% Independent responses
a(1, 1) = sum(ind1_2w(newdata & fail_corr == 0 & class == 3 & (school_pachinko == 1 | school_pachinko == 4))) / N;
b(1, 1) = sum(ind2_2w(newdata & fail_corr == 0 & class == 3 & (school_pachinko == 1 | school_pachinko == 4))) / N;
c(1, 1) = sum(ind3_2w(newdata & fail_corr == 0 & class == 3 & (school_pachinko == 1 | school_pachinko == 4))) / N;

% Correlated responses
a(2, 1) = sum(corr1_2w(newdata & fail_corr == 0 & class == 3 & (school_pachinko == 1 | school_pachinko == 4))) / N;
b(2, 1) = sum(corr2_2w(newdata & fail_corr == 0 & class == 3 & (school_pachinko == 1 | school_pachinko == 4))) / N;
c(2, 1) = sum(corr3_2w(newdata & fail_corr == 0 & class == 3 & (school_pachinko == 1 | school_pachinko == 4))) / N;

% Independent and correlated responses
c(3, 1) = sum(corr3_2w(newdata & fail_corr == 0 & class == 3 & (school_pachinko == 1 | school_pachinko == 4)) == 1 & ...
                ind3_2w(newdata & fail_corr == 0 & class == 3 & (school_pachinko == 1 | school_pachinko == 4)) == 1) / N;

%% Plotting the results

% Preparing data for plotting
n = [sum(newdata & fail_corr == 0 & class == 3 & (school_pachinko == 1 | school_pachinko == 4)), ...
     sum(newdata & fail_corr == 0 & class == 4 & (school_pachinko == 1 | school_pachinko == 4)), ...
     sum(newdata & fail_corr == 0 & class == 5 & (school_pachinko == 1 | school_pachinko == 4));
    
    sum(newdata & fail_corr == 0 & class == 3 & (school_pachinko == 1 | school_pachinko == 4)), ...
    sum(newdata & fail_corr == 0 & class == 4 & (school_pachinko == 1 | school_pachinko == 4)), ...
    sum(newdata & fail_corr == 0 & class == 5 & (school_pachinko == 1 | school_pachinko == 4));
    
    sum(newdata & fail_corr == 0 & class == 3 & (school_pachinko == 1 | school_pachinko == 4)), ...
    sum(newdata & fail_corr == 0 & class == 4 & (school_pachinko == 1 | school_pachinko == 4)), ...
    sum(newdata & fail_corr == 0 & class == 5 & (school_pachinko == 1 | school_pachinko == 4))];

% Calculate standard errors
se = sqrt((c .* (1 - c)) ./ n); 

% Define categories for grades
grade = categorical({'3rd grade', '4th grade', '5th grade'});

% Create the plot with standard errors
subplot(1, 2, 2)
plot(grade, c(3,:), '-*', 'MarkerSize', 8, 'Color', 'g'); hold on; % Plot Both
errorbar(grade, c(3,:), se(3,:), -se(3,:), 'LineStyle', 'none', 'LineWidth', 1.1, 'Color', 'g'); % Add error bars
hold on
plot(grade, c(1,:), '-*', 'MarkerSize', 8, 'Color', 'b'); % Plot Independent
errorbar(grade, c(1,:), se(1,:), -se(1,:), 'LineStyle', 'none', 'LineWidth', 1.1, 'Color', 'b'); % Add error bars
hold on
plot(grade, c(2,:), '-*', 'MarkerSize', 8, 'Color', 'r'); % Plot Correlated
errorbar(grade, c(2,:), se(2,:), -se(2,:), 'LineStyle', 'none', 'LineWidth', 1.1, 'Color', 'r'); % Add error bars
hold off
ylim([0 1]); % Set y-axis limits
set(gca, 'FontName', 'Times'); % Set font for axes
legend('Both', '', 'Independent', '', 'Correlated', '', 'Location', 'northwest'); % Add legend


test = (c(:,1)-c(:,3))./(sqrt(c(:,1)./n(:,1) + c(:,3)./n(:,3))); % z-test for proportions
pvalues = normcdf(test)*2; % two tailed test

section_5_1_1 = array2table([c(:,1),c(:,3),pvalues],"RowNames",{'Independent', 'Correlated', 'Both'}, "VariableNames",{'3rd grade', '5th grade', 'pvalue'});


%% Load the data from Experiment 1 (pencils and pens task)

load dataset_WARP        % Load WARP dataset for rationality analysis
load kids_raven          % Load Raven dataset
load gender_class_school  % Load gender and class data

% Determine rational decision-making based on WARP responses
rational = dataset_WARP(:, 1) == 0 & dataset_WARP(:, 2) == 0; % Both responses are zero
rational1 = dataset_WARP(:, 1) == 0; % First response is zero
rational2 = dataset_WARP(:, 2) == 0; % Second response is zero

% Calculate the proportion of rational students by class and school
for i = 1:5
    a(1, i) = sum(rational(class == i & (school == 1 | school == 4))) / sum(class == i & (school == 1 | school == 4)); % Overall rationality
    a(2, i) = sum(rational1(class == i & (school == 1 | school == 4))) / sum(class == i & (school == 1 | school == 4)); % Rationality for Pencils
    a(3, i) = sum(rational2(class == i & (school == 1 | school == 4))) / sum(class == i & (school == 1 | school == 4)); % Rationality for Pens
end

clear nn;
for i = 1:5
    nn(1, i) = sum(class == i & (school == 1 | school == 4)); % Count students by class
end
nn = repmat(nn, 3, 1);

% Create plot
grade = categorical({'1st grade', '2nd grade', '3rd grade', '4th grade', '5th grade'});

% Calculate standard errors for rationality percentages
sse = sqrt((a .* (1 - a)) ./ nn);

% Create first subplot for rationality results
subplot(1, 2, 1)
plot(grade, a(1,:), '-*', 'MarkerSize', 8, 'Color', 'g'); % Plot "Both" rationality
hold on
errorbar(grade, a(1,:), sse(1,:), -sse(1,:), 'LineStyle', 'none', 'LineWidth', 1.1, 'Color', 'g'); % Add error bars
hold on
plot(grade, a(2,:), '-*', 'MarkerSize', 8, 'Color', 'b'); % Plot "Pencils" rationality
hold on
errorbar(grade, a(2,:), sse(2,:), -sse(2,:), 'LineStyle', 'none', 'LineWidth', 1.1, 'Color', 'b'); % Add error bars
hold on
plot(grade, a(3,:), '-*', 'MarkerSize', 8, 'Color', 'r'); % Plot "Pens" rationality
hold on
errorbar(grade, a(3,:), sse(3,:), -sse(3,:), 'LineStyle', 'none', 'LineWidth', 1.1, 'Color', 'r'); % Add error bars
hold off
ylim([0 1]); % Set y-axis limits
set(gca, 'FontName', 'Times'); % Set font for axes
legend('Both', '', 'Pencils', '', 'Pens', ''); % Add legend


test2 = (a(:,1)-a(:,5))./(sqrt(a(:,1)./nn(:,1) + a(:,5)./nn(:,5)));
pvalues2 = normpdf(test2)*2; % two-tailed test

section_5_1_2 = array2table([a(:,1),a(:,5),pvalues2],"RowNames",{'Both', 'Pencils', 'Pens'}, "VariableNames",{'1st grade', '5th grade', 'pvalue'});

