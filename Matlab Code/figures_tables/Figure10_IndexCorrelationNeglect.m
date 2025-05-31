%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Figure 10: Index of Correlation Neglect %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Loading essential variables
create_variables                   % Load key variables
create_pachinko_dataset            % Create pachinko dataset

%%% Number of bootstrapped samples (in the paper: 10000)
B = 10;                            % Set the number of bootstrap samples

%%% Create a dummy variable for classes covered by the second wave
covered = zeros(length(group), 1); % Initialize coverage array
for i = 1:length(group)
    covered(i, 1) = ismember(group(i), groups_pachinko2ndwave); % Check coverage
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

% Calculate ATTRITION percentage
ATTRITION = 1 - sum(covered .* attrition) / sum(covered);


newdata = covered & ~attrition; % These are the pupils that solved the coin-drop game in Spring 2023

%%% Create school_pachinko variable
for i = 1:size(groups_classes, 1)     % Loop through all class groups
    if strcmp(groups_classes(i, 2), 'russo')
        groups_classes{i, 4} = 1;       % Assign code for 'russo'
    elseif strcmp(groups_classes(i, 2), 'trincone')
        groups_classes{i, 4} = 2;       % Assign code for 'trincone'
    elseif strcmp(groups_classes(i, 2), 'fatale')
        groups_classes{i, 4} = 3;       % Assign code for 'fatale'
    elseif strcmp(groups_classes(i, 2), 'marconi')
        groups_classes{i, 4} = 4;       % Assign code for 'marconi'
    end
end

% Determine the school_pachinko variable
groups_p = DATA_pachinko.group;         % Get the group data
school_pachinko = ismember(cell2mat(groups_classes(:, 1)), groups_p); % Check group membership
temp = [cell2mat(groups_classes(:, 1)), cell2mat(groups_classes(:, 4))]; % Create temp variable
temp = temp(school_pachinko, :);       % Filter temp based on school_pachinko

tt = zeros(size(groups_p, 1), 1);      % Initialize temporary variable

for i = 1:size(groups_p, 1)            % Loop through groups
    for j = 1:size(groups_p, 1)        % Loop through temp groups
        if groups_p(i, 1) == temp(j, 1)
            tt(i) = temp(j, 2);         % Assign corresponding school code
            break;                      % Exit the inner loop
        end
    end
end
school_pachinko = tt;                  % Assign values to school_pachinko 

% Create a matrix for school class pachinko
school_class_pachinko = [reshape(repmat([1,2,3,4], 3, 1), [], 1), ...
                          repmat([3,4,5], 1, 4)']; 

% Dummy for those pupils that did not answer correctly the correlated task
% Only 1% of the pupils!
fail_corr = (corr1_2w + corr2_2w + corr3_2w) > 1 | ...
            (corr1_2w + corr2_2w + corr3_2w) == 0; % Define fail correlation

%% Bootstrapping Standard Errors for All Estimates

% Create SAMPLE SIZE for all sub-populations

N = [sum(newdata & fail_corr==0);
    sum(newdata & fail_corr==0 & class==5);
    sum(newdata & fail_corr==0 & class==4);
    sum(newdata & fail_corr==0 & class==3);
    sum(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4));
    sum(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==5);
    sum(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==4);
    sum(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==3);
    sum(newdata & fail_corr==0 & school_pachinko==1);
    sum(newdata & fail_corr==0 & school_pachinko==1 & class==5);
    sum(newdata & fail_corr==0 & school_pachinko==1 & class==4);
    sum(newdata & fail_corr==0 & school_pachinko==1 & class==3);
    sum(newdata & fail_corr==0 & school_pachinko==4);
    sum(newdata & fail_corr==0 & school_pachinko==4 & class==5);
    sum(newdata & fail_corr==0 & school_pachinko==4 & class==4);
    sum(newdata & fail_corr==0 & school_pachinko==4 & class==3);
    sum(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4);
    sum(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==5);
    sum(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==4);
    sum(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==3)];

% Calculate correlated task proportions 
CORR = [sum(corr1_2w(newdata & fail_corr==0))/N(1), sum(corr2_2w(newdata & fail_corr==0))/N(1), sum(corr3_2w(newdata & fail_corr==0))/N(1);
    sum(corr1_2w(newdata & fail_corr==0 & class==5))/N(2), sum(corr2_2w(newdata & fail_corr==0 & class==5))/N(2), sum(corr3_2w(newdata & fail_corr==0 & class==5))/N(2);
    sum(corr1_2w(newdata & fail_corr==0 & class==4))/N(3), sum(corr2_2w(newdata & fail_corr==0 & class==4))/N(3), sum(corr3_2w(newdata & fail_corr==0 & class==4))/N(3);
    sum(corr1_2w(newdata & fail_corr==0 & class==3))/N(4), sum(corr2_2w(newdata & fail_corr==0 & class==3))/N(4), sum(corr3_2w(newdata & fail_corr==0 & class==3))/N(4);
    sum(corr1_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4)))/N(5), sum(corr2_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4)))/N(5), sum(corr3_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4)))/N(5);
    sum(corr1_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==5))/N(6), sum(corr2_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==5))/N(6), sum(corr3_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==5))/N(6);
    sum(corr1_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==4))/N(7), sum(corr2_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==4))/N(7), sum(corr3_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==4))/N(7);
    sum(corr1_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==3))/N(8), sum(corr2_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==3))/N(8), sum(corr3_2w(newdata & fail_corr==0 & (school_pachinko==1 | school_pachinko==4) & class==3))/N(8);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko==1))/N(9), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko==1))/N(9), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko==1))/N(9);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko==1 & class==5))/N(10), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko==1 & class==5))/N(10), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko==1 & class==5))/N(10);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko==1 & class==4))/N(11), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko==1 & class==4))/N(11), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko==1 & class==4))/N(11);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko==1 & class==3))/N(12), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko==1 & class==3))/N(12), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko==1 & class==3))/N(12);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko==4))/N(13), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko==4))/N(13), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko==4))/N(13);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko==4 & class==5))/N(14), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko==4 & class==5))/N(14), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko==4 & class==5))/N(14);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko==4 & class==4))/N(15), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko==4 & class==4))/N(15), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko==4 & class==4))/N(15);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko==4 & class==3))/N(16), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko==4 & class==3))/N(16), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko==4 & class==3))/N(16);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4))/N(17), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4))/N(17), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4))/N(17);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==5))/N(18), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==5))/N(18), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==5))/N(18);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==4))/N(19), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==4))/N(19), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==4))/N(19);
    sum(corr1_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==3))/N(20), sum(corr2_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==3))/N(20), sum(corr3_2w(newdata & fail_corr==0 & school_pachinko>1 & school_pachinko<4 & class==3))/N(20)];

%% Estimates correlated task

% Set optimization options
options = optimoptions('fmincon', 'display', 'off', 'MaxFunctionEvaluations', 1e6, ...
                       'StepTolerance', 1e-8, 'FunctionTolerance', 1e-8, ...
                       'OptimalityTolerance', 1e-8, 'FiniteDifferenceType', 'central');

BOOTSTRAP2 = cell(size(N, 1), 1);  % Initialize cell for bootstrap results
for z = 1:size(N, 1)                % Loop over all samples
    BOOTSTRAP2{z, 1} = zeros(B, 1); % Prepare to hold bootstrap results
end

for z = 1:size(N, 1)                % Loop over all samples
    for b = 1:B                      % Loop for bootstrap samples
        p = [CORR(z, 1), CORR(z, 2), CORR(z, 3)]; % Create probability distribution
        R = mnrnd(N(z, 1), p, 1) ./ N(z, 1); % Generate bootstrapped sample

        x0 = [0.5, 0.5, 0.5];        % Initial guess for optimization

        lb = [0; 0; 0];              % Lower bounds for optimization
        ub = [1; 1; 1];              % Upper bounds for optimization

        % Unconstrained optimization
        [xu] = fmincon(@(x) correlated2(x, R(1), R(2), R(3), N(z, 1)), x0', [], [], [], [], lb, ub, [], options);
        
        BOOTSTRAP2{z, 1}(b, 1) = (xu(3) - xu(1) * (1 - xu(3))) / (xu(3) + xu(1) * (1 - xu(3))); % Compute index of correlation neglect
    end
    z                              % Output the current iteration
end

for z = 1:size(N, 1)                % Calculate standard errors for bootstrapped results
    STANDARDERR2(z, 1) = std(BOOTSTRAP2{z, 1}); % Compute standard error
end

%% PLOTS

% load the saved bootstrapped estimates with 10000 samples

load bootstrap_Experiment2.mat


% Re-initialize optimization options for plotting
options = optimoptions('fmincon', 'display', 'off', 'MaxFunctionEvaluations', 1e6, ...
                       'StepTolerance', 1e-8, 'FunctionTolerance', 1e-8, ...
                       'OptimalityTolerance', 1e-8, 'FiniteDifferenceType', 'central');

clearvars xu xc            % Clear previous variables
x0 = [0.5, 0.5, 0.5];     % Initialize guess again for plotting

%Aeq and beq could be defined here if needed
Aeq = [1, -1, 0; 1, 0, -1];  % Equality constraints
beq = [0; 0];                 % Right-hand side values for constraints
lb = [0; 0; 0];               % Lower bounds
ub = [1; 1; 1];               % Upper bounds

for z = 1:size(N, 1)         %  Unconstrained optimization
    [xu(:, z)] = fmincon(@(x) correlated2(x, CORR(z, 1), CORR(z, 2), CORR(z, 3), N(z, 1)), x0', [], [], [], [], lb, ub, [], options);
end

% Compute index of correlation neglect for the plot
xu = (xu(3, :)' - xu(1, :)' .* (1 - xu(3, :)')) ./ (xu(3, :)' + xu(1, :)' .* (1 - xu(3, :)'));

th = 0.1;  % Threshold for x-axis shifts
x(1, :) = [0 0 0 0];             % Data for first row (adding zeros)
x(2, :) = [1 2 3 4] - th;       % Adjusted positions for x-axis (for lower)
x(3, :) = [1 2 3 4];            % Original positions for x-axis
x(4, :) = [1 2 3 4] + th;       % Adjusted positions for x-axis (for upper)


% subplot(1,2,1)
for i=3:4
    if i==3
P_L = [xu(4*i);xu(4*i-1);xu(4*i-2);xu(4*i-3)];
S_L = [STANDARDERR2(4*i);STANDARDERR2(4*i-1);STANDARDERR2(4*i-2);STANDARDERR2(4*i-3)];
plot(x(i-1,1:3),P_L(1:3),'*','MarkerSize',8,'Color','r')
hold on
errorbar(x(i-1,1:3),P_L(1:3),S_L(1:3),S_L(1:3),'LineStyle','--','Linewidth',0.8,'Color','r')
hold on 
plot(x(i-1,4),P_L(4),'*','MarkerSize',8,'Color','r')
hold on
errorbar(x(i-1,4),P_L(4),S_L(4),S_L(4),'LineStyle','none','Linewidth',0.8,'Color','r')
hold on 
%yline(0.5,'--')
%yline(1,'--')
hold on

        % Adding numbers next to the stars for School L
        for j = 1:length(P_L)
            text(x(3,j) + 0.12, P_L(j), num2str(P_L(j), '%.2f'), 'FontSize', 12, 'FontName', 'Times', 'Color', 'r', 'HorizontalAlignment', 'center');
        end
    else
P_H = [xu(4*i);xu(4*i-1);xu(4*i-2);xu(4*i-3)];
S_H = [STANDARDERR2(4*i);STANDARDERR2(4*i-1);STANDARDERR2(4*i-2);STANDARDERR2(4*i-3)];
plot(x(i,1:3),P_H(1:3),'*','MarkerSize',8,'Color','b')
hold on
errorbar(x(i,1:3),P_H(1:3),S_H(1:3),S_H(1:3),'LineStyle','--','Linewidth',0.8,'Color','b')
hold on 
plot(x(i,4),P_H(4),'*','MarkerSize',8,'Color','b')
hold on
errorbar(x(i,4),P_H(4),S_H(4),S_H(4),'LineStyle','none','Linewidth',0.8,'Color','b')
hold on 
%yline(0.5,'--')
%yline(1,'--')
hold on   

        % Adding numbers next to the stars for School H
        for j = 1:length(P_H)
            text(x(3,j) - 0.1, P_H(j), num2str(P_H(j), '%.2f'), 'FontSize', 12, 'FontName', 'Times', 'Color', 'b', 'HorizontalAlignment', 'center');
        end

    end
end
xline(3.5,'--')
xlim([0 4.5])
xticks([1 2 3 4]);
xticklabels({'3rd grade', '4th grade', '5th grade', 'Aggregate'});
ylim([-1 1])
legend('','School L','','','','School H','','')
set(gca,'FontName','Times')
hold off


% T-tests 

for i=3:4
    T3rd5thGradeCORR(i-2,1) = (xu(4*i)-xu(4*i-2))/(sqrt(STANDARDERR2(4*i)^2 + STANDARDERR2(4*i-2)^2));
end

Pvalue3rd5thGradeCORR = normcdf(T3rd5thGradeCORR)*2; % two-tailed p-value

i=3;
j=4;

TacroossSchoolsCORR = [(xu(4*i)-xu(4*j))/(sqrt(STANDARDERR2(4*i)^2 + STANDARDERR2(4*j)^2));  
     (xu(4*i-1)-xu(4*j-1))/(sqrt(STANDARDERR2(4*i-1)^2 + STANDARDERR2(4*j-1)^2));
     (xu(4*i-2)-xu(4*j-2))/(sqrt(STANDARDERR2(4*i-2)^2 + STANDARDERR2(4*j-2)^2));
     (xu(4*i-3)-xu(4*j-3))/(sqrt(STANDARDERR2(4*i-3)^2 + STANDARDERR2(4*j-3)^2));]; % Here the t-tests are 3rd, 4th, 5th, Aggregate, in order

PvalueAcroosSchoolsCORR = normcdf(TacroossSchoolsCORR)*2; % two-tailed p-value

% summary of the estimates and t-tests

section_5_3_21 = array2table([xu([12 16]), xu([10 14]), Pvalue3rd5thGradeCORR],"RowNames",{'School L', 'School H'},"VariableNames",{'3rd', '5th', 'pavlue'})

section_5_3_22 = array2table([xu([12 10 9]), xu([16 14 13]), PvalueAcroosSchoolsCORR([1 3 4])],"RowNames",{'3rd', '5th', 'aggregate'},"VariableNames",{'School L', 'School H', 'pavlue'})



%% Chi2 test on distributions Independent vs Correlated

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


for i=1:length(N)
  X(:,:,i) =  [round(IND(i,:)'.*N(i)),round(CORR(i,:)'.*N(i))];
    CHI(i, 1) = (  ( (X(1,1,i)-X(1,2,i))^2 )/ (X(1,1,i)+X(1,2,i))  +  ...
                ( (X(2,1,i)-X(2,2,i))^2 )/ (X(2,1,i)+X(2,2,i))  +  ...
                ( (X(3,1,i)-X(3,2,i))^2 )/ (X(3,1,i)+X(3,2,i))  ); % calculate chi-square statistic
    PCHI(i, 1) = 1 - chi2cdf(CHI(i), 2); % there are two degrees of freedom because the sample size is the same and there are no empty bins.
end

section_5_3_23 = array2table([IND([9:16],:), CORR([9:16],:) ,PCHI([9:16])],"RowNames", ...
    {'School L aggregate', 'School L 5th','School L 4th','School L 3rd','School H aggregate', 'School H 5th','School H 4th','School H 3rd'},"VariableNames", ...
    {'L5 - IND', 'L6 - IND', 'L7 - IND', 'L5 - CORR', 'L6 - CORR', 'L7 - CORR' 'pvalue'})




