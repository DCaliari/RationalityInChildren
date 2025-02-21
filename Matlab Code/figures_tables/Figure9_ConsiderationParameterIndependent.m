%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Figure 9: Consideration Parameter Independent %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load Key Variables
create_variables;               % Load essential variables
create_pachinko_dataset;       % Create dataset for Pachinko analysis

% Number of bootstrapped samples (as in the paper: 10000)
B = 10;

%% Create Dummy Variables for Classes Covered by Second Wave
covered = zeros(length(group), 1); % Initialize coverage array
for i = 1:length(group)
    covered(i, 1) = ismember(group(i), groups_pachinko2ndwave); % Check coverage
end
covered = logical(covered); % Convert to logical array

%% Create Dummy Variable for Attrition
attrition = zeros(length(group), 1); % Initialize attrition array
for i = 1:length(group)
    attrition(i, 1) = isnan(ind1_2w(i)) & covered(i); % Check for attrition
end

% Calculate ATTRITION percentage
ATTRITION = 1 - sum(covered .* attrition) / sum(covered);

%% Generate the Variable Win/Lose
win = (threes_twos == 1 & esito < 5 & esito > 0) | ...
      (threes_ones == 1 & esito < 8 & esito > 0) | ...
      (twos_ones == 1 & esito < 8 & esito > 0);
win = double(win);
win(esito == 0) = 99; % Assign 99 for cases where esito is 0

newdata = covered & ~attrition; % Filter data based on coverage and attrition

%% Create School Pachinko Variable
for i = 1:size(groups_classes, 1)
    switch groups_classes{i, 2}
        case 'russo'
            groups_classes{i, 4} = 1;
        case 'trincone'
            groups_classes{i, 4} = 2;
        case 'fatale'
            groups_classes{i, 4} = 3;
        case 'marconi'
            groups_classes{i, 4} = 4;
    end
end

groups_p = DATA_pachinko.group; % Access group data

school_pachinko = ismember(cell2mat(groups_classes(:, 1)), groups_p);
temp = [cell2mat(groups_classes(:, 1)), cell2mat(groups_classes(:, 4))];
temp = temp(school_pachinko, :); % Filter relevant school data

% Map school_pachinko to tt variable
for i = 1:size(groups_p, 1)
    for j = 1:size(groups_p, 1)
        if groups_p(i, 1) == temp(j, 1)
            tt(i) = temp(j, 2);
            break;  
        end
    end
end
school_pachinko = tt'; % Transpose for consistency

%% Define School Class Pachinko
school_class_pachinko = [reshape(repmat([1, 2, 3, 4], 3, 1), [], 1), ...
                          repmat([3, 4, 5], 1, 4)'];

% Define failure criteria based on correlation
fail_corr = (corr1_2w + corr2_2w + corr3_2w > 1) | ...
            (corr1_2w + corr2_2w + corr3_2w == 0);

% Sample Size Calculation for All Sub-populations
N = [sum(newdata & fail_corr == 0);
    sum(newdata & fail_corr == 0 & class == 5);
    sum(newdata & fail_corr == 0 & class == 4);
    sum(newdata & fail_corr == 0 & class == 3);
    sum(newdata & fail_corr == 0 & (school_pachinko == 1 | school_pachinko == 4));
    sum(newdata & fail_corr == 0 & (school_pachinko == 1 | school_pachinko == 4) & class == 5);
    sum(newdata & fail_corr == 0 & (school_pachinko == 1 | school_pachinko == 4) & class == 4);
    sum(newdata & fail_corr == 0 & (school_pachinko == 1 | school_pachinko == 4) & class == 3);
    sum(newdata & fail_corr == 0 & school_pachinko == 1);
    sum(newdata & fail_corr == 0 & school_pachinko == 1 & class == 5);
    sum(newdata & fail_corr == 0 & school_pachinko == 1 & class == 4);
    sum(newdata & fail_corr == 0 & school_pachinko == 1 & class == 3);
    sum(newdata & fail_corr == 0 & school_pachinko == 4);
    sum(newdata & fail_corr == 0 & school_pachinko == 4 & class == 5);
    sum(newdata & fail_corr == 0 & school_pachinko == 4 & class == 4);
    sum(newdata & fail_corr == 0 & school_pachinko == 4 & class == 3);
    sum(newdata & fail_corr == 0 & school_pachinko > 1 & school_pachinko < 4);
    sum(newdata & fail_corr == 0 & school_pachinko > 1 & school_pachinko < 4 & class == 5);
    sum(newdata & fail_corr == 0 & school_pachinko > 1 & school_pachinko < 4 & class == 4);
    sum(newdata & fail_corr == 0 & school_pachinko > 1 & school_pachinko < 4 & class == 3)];

% Independent Proportion Estimates
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


%% Estimates Independent
options = optimoptions('fmincon', 'display', 'off', 'MaxFunctionEvaluations', 1e6, ...
    'StepTolerance', 1e-8, 'FunctionTolerance', 1e-8, 'OptimalityTolerance', 1e-8, ...
    'FiniteDifferenceType', 'central');

% Initialize Bootstrap Cell Array
BOOTSTRAP = cell(size(N, 1), 1);
for z = 1:size(N, 1)
    BOOTSTRAP{z, 1} = zeros(B, 1);
end

% Bootstrapping Process
for z = 1:size(N, 1) % Loop over all samples
    for b = 1:B
        p = [IND(z, 1), IND(z, 2), IND(z, 3)]; % Multinomial distribution
        R = mnrnd(N(z, 1), p, 1) ./ N(z, 1); % Bootstrap sample

        % Initial Guess for Optimization
        x0 = [0.5, 0.5, 0.5];

        % Define Equality Constraints
        Aeq = [1, -1, 0; 1, 0, -1];
        beq = [0; 0];
        lb = [0; 0; 0]; % Lower bounds
        ub = [1; 1; 1]; % Upper bounds

        % Optimize
        [xc] = fmincon(@(x) independent(x, R(1), R(2), R(3), N(z, 1)), x0', [], [], Aeq, beq, lb, ub, [], options);
        BOOTSTRAP{z, 1}(b, 1) = xc(1);
    end
    fprintf('Completed bootstrap for sample %d\n', z); % Track progress
end

% Compute Standard Error
for z = 1:size(N, 1)
    STANDARDERR(z, 1) = std(BOOTSTRAP{z, 1});
end

%% PLOT RESULTS

% load the saved bootstrapped estimates with 10000 samples

load bootstrap_Experiment2.mat

clearvars xu xc
x0 = [0.5, 0.5, 0.5]; % Initial guess for optimization
Aeq = [1, -1, 0; 1, 0, -1]; % Equality constraints
beq = [0; 0];
lb = [0; 0; 0]; % Lower bounds for optimization
ub = [1; 1; 1]; % Upper bounds for optimization

% Optimize for each sample
for z = 1:size(N, 1)
    [xc(:, z)] = fmincon(@(x) independent(x, IND(z, 1), IND(z, 2), IND(z, 3), N(z, 1)), x0', [], [], Aeq, beq, lb, ub, [], options);
end
xc = xc(1, :)'; % Keep the first row

% Define plotting thresholds
th = 0.1; % Threshold for x-axis adjustments
x(1, :) = [0 0 0 0];
x(2, :) = [1 2 3 4] - th;
x(3, :) = [1 2 3 4];
x(4, :) = [1 2 3 4] + th;

% Plotting Loop for School L and School H
for i = 3:4
    if i == 3
        P_L = [xc(4 * i); xc(4 * i - 1); xc(4 * i - 2); xc(4 * i - 3)];
        S_L = [STANDARDERR(4 * i); STANDARDERR(4 * i - 1); STANDARDERR(4 * i - 2); STANDARDERR(4 * i - 3)];
        
        % Plot with error bars for School L
        plot(x(i - 1, 1:3), P_L(1:3), '*', 'MarkerSize', 8, 'Color', 'r'); hold on;
        errorbar(x(i - 1, 1:3), P_L(1:3), S_L(1:3), S_L(1:3), 'LineStyle', '--', 'LineWidth', 0.8, 'Color', 'r');
        plot(x(i - 1, 4), P_L(4), '*', 'MarkerSize', 8, 'Color', 'r'); hold on;
        errorbar(x(i - 1, 4), P_L(4), S_L(4), S_L(4), 'LineStyle', 'none', 'LineWidth', 0.8, 'Color', 'r');
        
        % Adding numerical annotations for School L
        for j = 1:length(P_L)
            text(x(3, j) + 0.1, P_L(j), num2str(P_L(j), '%.2f'), 'FontSize', 12, 'FontName', 'Times', 'Color', 'r', 'HorizontalAlignment', 'center');
        end
    else
        P_H = [xc(4 * i); xc(4 * i - 1); xc(4 * i - 2); xc(4 * i - 3)];
        S_H = [STANDARDERR(4 * i); STANDARDERR(4 * i - 1); STANDARDERR(4 * i - 2); STANDARDERR(4 * i - 3)];
        
        % Plot with error bars for School H
        plot(x(i, 1:3), P_H(1:3), '*', 'MarkerSize', 8, 'Color', 'b'); hold on;
        errorbar(x(i, 1:3), P_H(1:3), S_H(1:3), S_H(1:3), 'LineStyle', '--', 'LineWidth', 0.8, 'Color', 'b');
        plot(x(i, 4), P_H(4), '*', 'MarkerSize', 8, 'Color', 'b'); hold on;
        errorbar(x(i, 4), P_H(4), S_H(4), S_H(4), 'LineStyle', 'none', 'LineWidth', 0.8, 'Color', 'b');
        
        % Adding numerical annotations for School H
        for j = 1:length(P_H)
            text(x(3, j) - 0.1, P_H(j), num2str(P_H(j), '%.2f'), 'FontSize', 12, 'FontName', 'Times', 'Color', 'b', 'HorizontalAlignment', 'center');
        end
    end
end

% Additional plot formatting
xline(3.5, '--'); % Vertical line
xlim([0 4.5]); % Set x-axis limits
xticks([1 2 3 4]); % Set x-axis tick marks
xticklabels({'3rd grade', '4th grade', '5th grade', 'Aggregate'}); % Set x-axis labels
ylim([0 1]); % Set y-axis limits
legend('', 'School L', '', '', '', 'School H', '', ''); % Legend configuration
set(gca, 'FontName', 'Times'); % Set font for axes




% T-tests 
for i=3:4
    T3rd5thGradeIND(i-2,1) = (xc(4*i)-xc(4*i-2))/(sqrt(STANDARDERR(4*i)^2 + STANDARDERR(4*i-2)^2));
end

Pvalue3rd5thGradeIND = normcdf(T3rd5thGradeIND)*2; % two-tailed p-value

i=3;
j=4;

TacroossSchoolsIND = [(xc(4*i)-xc(4*j))/(sqrt(STANDARDERR(4*i)^2 + STANDARDERR(4*j)^2));  
     (xc(4*i-1)-xc(4*j-1))/(sqrt(STANDARDERR(4*i-1)^2 + STANDARDERR(4*j-1)^2));
     (xc(4*i-2)-xc(4*j-2))/(sqrt(STANDARDERR(4*i-2)^2 + STANDARDERR(4*j-2)^2));
     (xc(4*i-3)-xc(4*j-3))/(sqrt(STANDARDERR(4*i-3)^2 + STANDARDERR(4*j-3)^2));]; % Here the t-tests are 3rd, 4th, 5th, Aggregate, in order

PvalueAcroosSchoolsIND = normcdf(TacroossSchoolsIND)*2; % two-tailed p-value

% summary of the estimates and t-tests

section_5_3_11 = array2table([xc([12 16]), xc([10 14]), Pvalue3rd5thGradeIND],"RowNames",{'School L', 'School H'},"VariableNames",{'3rd', '5th', 'pavlue'})

section_5_3_12 = array2table([xc([12 10 9]), xc([16 14 13]), PvalueAcroosSchoolsIND([1 3 4])],"RowNames",{'3rd', '5th', 'aggregate'},"VariableNames",{'School L', 'School H', 'pavlue'})

