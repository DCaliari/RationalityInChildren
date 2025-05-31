%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 6: Distribution of the preference types by gender %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load datasets needed for the analysis
create_warp_datasets

[DATA1,DATA2,~,~,~,~] = dataset_constructions(DATASET(:,1:6),n); 

C_pencils = DATA1; % Store the choices from the pencils
C_pens = DATA2; % Store the choices from the pens

%% Load data on school, groups, class, etc...

load groups.mat 

load gender_class_school.mat

% Pupils who participated in the autumn experiment (see footnote
% 27)
spring = group < 8; 

% number of bootstrapped samples (in the paper 1000)
B = 5;

%% Create subpopulations based on class and gender


T(:,1) = gender & class == 1 & ~spring & (school ==1 | school == 4);
T(:,2) = gender & class == 2 & ~spring & (school ==1 | school == 4);
T(:,3) = gender & class == 3 & ~spring & (school ==1 | school == 4);
T(:,4) = gender & class == 4 & ~spring & (school ==1 | school == 4);
T(:,5) = gender & class == 5 & ~spring & (school ==1 | school == 4);
T(:,6) = ~gender & class == 1 & ~spring & (school ==1 | school == 4);
T(:,7) = ~gender & class == 2 & ~spring & (school ==1 | school == 4);
T(:,8) = ~gender & class == 3 & ~spring & (school ==1 | school == 4);
T(:,9) = ~gender & class == 4 & ~spring & (school ==1 | school == 4);
T(:,10) = ~gender & class == 5 & ~spring & (school ==1 | school == 4);
T(:,11) = gender & ~spring & (school ==1 | school == 4);
T(:,12) = ~gender & ~spring & (school ==1 | school == 4);


%% Begin the estimation process
for treatment = 1:2
    if treatment == 1 % Focus on pencils
        C = C_pencils;
    elseif treatment == 2 % Focus on pens
        C = C_pens;
    end

    iter = 1; % Dummy that sets the starting poin at the uniform distribution, one can try different starting points for the process

    % Loop through each subpopulation
for z = 1:size(T, 2) 

        clearvars N p_par_new pi_par_new F y % Clear previous variables

        g = 1; % Number of gamma parameters = 1 (unique consideration parameter)

        N = size(C(T(:, z), :), 1); % Number of individuals in the current subpopulation

        % Initial value for gamma parameter
        p_par = 0.5;

        % Check if the starting point modifies the estimates
        if iter == 1
            % Starting point for the probability distribution "pi" (uniform distribution)
            pi_par = ones(1, (g) * lc) / ((g) * lc); 
        else
            % Random starting point for the probability distribution "pi"
            pi_par = rand(1, (g) * lc); 
            pi_par = pi_par ./ sum(pi_par); % Normalize to sum to one
        end

        pi_par_old = pi_par;

        tol_par = 1e-9; % Tolerance for parameter convergence
        par_dist = 1; it = 1; % Initialize distances
        p_par_old = p_par; 

        % Optimization options
        options = optimoptions('fmincon', 'display', 'off', 'MaxFunctionEvaluations', 1e7,...
            'StepTolerance', 1e-9, 'FunctionTolerance', 1e-9, 'OptimalityTolerance', 1e-9, ...
            'FiniteDifferenceType', 'central' );

        LL_dist = 1; % Initialize log-likelihood distance
        tol_LL = 1e-8; % Tolerance for log-likelihood differences

        % Optimization loop for parameters
        while LL_dist > tol_LL
            clearvars Q P % Clear matrices for conditional probabilities
            Q = []; 
            p_par = p_par_old; 

            temp_par = repmat(p_par, 1, 4); % Replicate the gamma parameter for alternatives (unique consideration parameter)

            % Calculate conditional probabilities matrices
            for i = 1:size(p_par, 1)
                for u = 1:lc
                    P(:, u) = P_Rho_varying_type(temp_par(i, :), PER, u, R); 
                end
                temp = P;
                Q = [Q, temp]; 
            end

            % Calculate the likelihood function
            F = exp(C(T(:, z), :) * log(Q)); 

            % Constraints for the first optimization problem
            lb = zeros(size(F, 2), 1); % Lower bound
            ub = ones(size(F, 2), 1); % Upper bound
            Aeq = ones(1, size(F, 2)); % Equality constraint: sum to one
            beq = 1;

            % Maximization of the likelihood with respect to the probability distribution
            [pi_par_new] = fmincon(@(pi_par) Log_lik_EB(pi_par, F), pi_par_old', [], [], Aeq, ...
                beq, lb, ub, [], options); 
            pi_par_new = pi_par_new'; % Transpose to match dimensions

            % Constraints for the second maximization problem (gamma parameters)
            % This is for multiple gammas, to ensure Low gamma is below
            % High gamma. In the main specification, we have a unique
            % gamma, hence this is simply lower/upper bound [0,1]
            
            lb = 0;
            for i = 1:size(p_par_old, 1) - 1    
                lb = [lb; p_par_old(i)];
            end
            ub = [];
            for i = 1:size(p_par_old, 1) - 1 
                ub = [ub; p_par_old(1 + i)];
            end
            ub = [ub; 1]; 

            % Maximization of the likelihood with respect to gamma
            [p_par_new, ~, ~, ~, ~, grad, hessian] = fmincon(@(p_par) log_lik_model(p_par, pi_par_new, PER, lc, R, C(T(:, z), :)), p_par_old, [], [], [], [], lb, ub, [], options); 

            % Calculate log-likelihood distance for convergence check
            LL_dist = log_lik_model(p_par_old, pi_par_new, PER, lc, R, C(T(:, z), :)) - log_lik_model(p_par_new, pi_par_new, PER, lc, R, C(T(:, z), :)); 

            % Update parameters for the next iteration of the while loop
            pi_par_old = pi_par_new;
            p_par_old = p_par_new;
            it = it + 1; % Increment iteration counter
        end

        % Store the estimated gamma and probability distribution
        parameters{treatment}(:, z) = p_par_new; 
        preferences{treatment}(z, :) = pi_par_new; 

        % Store average gamma if there are more than one
        RHO{treatment}(z, 1) = sum(reshape(preferences{treatment}(z, :), 24, g)) * parameters{treatment}(:, z); 

        HESSIAN{treatment}{z, 1} = hessian; % Store the hessian matrix for the second optimization problem
        fs{treatment}{z, 1} = F; % Store the likelihood function values

    

%% BOOTSTRAP STANDARD ERRORS

% Generate random indices for bootstrapping
y = randi(N, N, B); % Random resampling

for b = 1:B % Loop through bootstrap samples
    clearvars N p_par_new pi_par_new % Clear previous variables

    % Choices from the new resample
    y_temp = y(:, b);
    tempC = C(T(:, z), :);
    tempC = tempC(y_temp, :); % Apply the resample to the choices

    % Initial values for optimization
    p_par = 0.5;
    pi_par = ones(1, (g) * lc) / ((g) * lc);
    pi_par_old = pi_par; % Old value for distribution parameters

    par_dist = 1; it = 1; % Initialize distances and iteration counter
    p_par_old = p_par;

    % Optimization options for the bootstrap process
    options = optimoptions('fmincon', 'display', 'off', 'MaxFunctionEvaluations', 1e7,...
        'StepTolerance', 1e-9, 'FunctionTolerance', 1e-9, 'OptimalityTolerance', 1e-9, ...
        'FiniteDifferenceType', 'central' );

    LL_dist = 1; % Initialize log-likelihood distance
    tol_LL = 1e-6; % Tolerance for the log-likelihood distance

    % Optimization loop for bootstrap sample
    while LL_dist > tol_LL
        clearvars Q P 
        Q = []; 
        p_par = p_par_old; 
        temp_par = repmat(p_par, 1, 4); 

        % Calculate conditional probabilities matrices
        for i = 1:size(p_par, 1)
            for u = 1:lc
                P(:, u) = P_Rho_varying_type(temp_par(i, :), PER, u, R); 
            end
            temp = P;
            Q = [Q, temp]; 
        end

        % Calculate the likelihood function for the bootstrap sample
        F = exp(tempC * log(Q)); 

        % Constraints for the first optimization problem
        lb = zeros(size(F, 2), 1);
        ub = ones(size(F, 2), 1);
        Aeq = ones(1, size(F, 2));
        beq = 1;

        % Maximization of the likelihood for the probability distribution
        [pi_par_new] = fmincon(@(pi_par) Log_lik_EB(pi_par, F), pi_par_old', [], [], Aeq, ...
            beq, lb, ub, [], options); 
        pi_par_new = pi_par_new'; % Transpose to match dimensions

        % Constraints for maximizing gamma
        lb = 0;
        for i = 1:size(p_par_old, 1) - 1    
            lb = [lb; p_par_old(i)];
        end
        ub = [];
        for i = 1:size(p_par_old, 1) - 1 
            ub = [ub; p_par_old(1 + i)];
        end
        ub = [ub; 1];

        % Maximization of the likelihood with respect to gamma
        p_par_new = fmincon(@(p_par) log_lik_model(p_par, pi_par_new, PER, lc, R, tempC), ...
            p_par_old, [], [], [], [], lb, ub, [], options);

        % Check for log-likelihood distance for convergence 
        LL_dist = log_lik_model(p_par_old, pi_par_new, PER, lc, R, tempC) - log_lik_model(p_par_new, pi_par_new, PER, lc, R, tempC);

        % Update parameters
        pi_par_old = pi_par_new; 
        p_par_old = p_par_new;
        it = it + 1; % Increment iteration counter
    end

    % Store bootstrap results
    RHObootstrap{treatment}(b, z) = sum(reshape(pi_par_new, 24, g)) * p_par_new; 

b

end % End of bootstrap sample loop

% Calculate standard errors from bootstrap results
STANDARDERR{treatment} = std(RHObootstrap{treatment}); % Store standard errors for the treatment

z % Display current subsample
end 

treatment % Display current treatment iteration

end % End of treatment loop


% load the saved bootstrapped estimates with 1000 samples that we used in the paper (this is for
% replication!!)

load bootstrap_Experiment1_gender.mat


% Define x values for the x-axis
x = [1 2 3 4 5 6];             % Grades and Aggregate
x1 = x - 0.1;                  % Adjust x for Girls (left offset)
x2 = x + 0.1;                  % Adjust x for Boys (right offset)


% Retrieve data for School L
P_L = RHO{1}([1:5 11]);        % Preference data for Girls (grades and aggregate)
S_L = STANDARDERR{1}([1:5 11]); % Standard errors for Girls

% Plot preference data for Girls
plot(x1(1:5), P_L(1:5), '*', 'MarkerSize', 8, 'Color', 'r') % Markers for each grade
hold on
errorbar(x1(1:5), P_L(1:5), S_L(1:5), S_L(1:5), 'LineStyle', '--', 'LineWidth', 0.8) % Error bars for grades

% Plot aggregate data for Girls (6th point)
plot(x1(6), P_L(6), '*', 'MarkerSize', 8, 'Color', 'r', 'LineStyle', 'none')
errorbar(x1(6), P_L(6), S_L(6), S_L(6), 'LineStyle', 'none', 'LineWidth', 0.8, 'Color', 'r')

% Add numeric labels next to the stars for Girls (offset right)
for i = 1:length(P_L)
    text(x1(i) + 0.1, P_L(i), num2str(P_L(i), '%.2f'), ...
        'FontSize', 10, 'FontName', 'Times', 'Color', 'r', 'HorizontalAlignment', 'left');
end

% Retrieve data for Boys
P_H = RHO{1}([6:10 12]);       % Preference data for School H
S_H = STANDARDERR{1}([6:10 12]); % Standard errors for School H

% Plot preference data for Boys
plot(x2(1:5), P_H(1:5), '*', 'MarkerSize', 8, 'Color', 'b') % Markers for each grade
hold on
errorbar(x2(1:5), P_H(1:5), S_H(1:5), S_H(1:5), 'LineStyle', '--', 'LineWidth', 0.8, 'Color', 'b') % Error bars for grades

% Plot aggregate data for Boys (6th point)
plot(x2(6), P_H(6), '*', 'MarkerSize', 8, 'Color', 'b', 'LineStyle', 'none')
errorbar(x2(6), P_H(6), S_H(6), S_H(6), 'LineStyle', 'none', 'LineWidth', 0.8, 'Color', 'b')

% Add numeric labels next to the stars for Boys (offset left)
for i = 1:length(P_H)
    text(x2(i) - 0.1, P_H(i), num2str(P_H(i), '%.2f'), ...
        'FontSize', 10, 'FontName', 'Times', 'Color', 'b', 'HorizontalAlignment', 'right');
end

% Add a vertical dashed line at x = 5.5
xline(5.5, '--')

% Set the y-axis limits, x-axis limits, and tick labels
ylim([0.5 1]) % Limits for y-axis
xlim([0.5 6.5]) % Limits for x-axis
xticks([1 2 3 4 5 6]); % X-Tick positions
xticklabels({'1st grade', '2nd grade', '3rd grade', '4th grade', '5th grade', 'Aggregate'}); % X-Tick labels

% Add legend to the plot
legend('Female', '', '', '', 'Male', '', '', '', '', 'Location', 'southeast');

% Set font for current axes
set(gca, 'FontName', 'Times')
hold off


% Repeat the data retrieval and plotting for Girls in the second subplot
P_L = RHO{2}([1:5 11]);        % Preference data for Girls (2nd data set)
S_L = STANDARDERR{2}([1:5 11]); % Standard errors for Girls

% Plot preference data for Girls
plot(x1(1:5), P_L(1:5), '*', 'MarkerSize', 8, 'Color', 'r')
hold on
errorbar(x1(1:5), P_L(1:5), S_L(1:5), S_L(1:5), 'LineStyle', '--', 'LineWidth', 0.8)

% Plot aggregate data for Girls (6th point)
plot(x1(6), P_L(6), '*', 'MarkerSize', 8, 'Color', 'r', 'LineStyle', 'none')
hold on
errorbar(x1(6), P_L(6), S_L(6), S_L(6), 'LineStyle', 'none', 'LineWidth', 0.8, 'Color', 'r')

% Add numeric labels next to the stars for Girls (offset right)
for i = 1:length(P_L)
    text(x1(i) + 0.1, P_L(i), num2str(P_L(i), '%.2f'), ...
        'FontSize', 10, 'FontName', 'Times', 'Color', 'r', 'HorizontalAlignment', 'left');
end

% Retrieve data for Boys in the second data set
P_H = RHO{2}([6:10 12]);       % Preference data for School H
S_H = STANDARDERR{2}([6:10 12]); % Standard errors for School H

% Plot preference data for Boys
plot(x2(1:5), P_H(1:5), '*', 'MarkerSize', 8, 'Color', 'b')
hold on
errorbar(x2(1:5), P_H(1:5), S_H(1:5), S_H(1:5), 'LineStyle', '--', 'LineWidth', 0.8, 'Color', 'b')

% Plot aggregate data for Boys (6th point)
plot(x2(6), P_H(6), '*', 'MarkerSize', 8, 'Color', 'b', 'LineStyle', 'none')
hold on
errorbar(x2(6), P_H(6), S_H(6), S_H(6), 'LineStyle', 'none', 'LineWidth', 0.8, 'Color', 'b')

% Add numeric labels next to the stars for Boys (offset left)
for i = 1:length(P_H)
    text(x2(i) - 0.1, P_H(i), num2str(P_H(i), '%.2f'), ...
        'FontSize', 10, 'FontName', 'Times', 'Color', 'b', 'HorizontalAlignment', 'right');
end

% Add a vertical dashed line at x = 5.5
xline(5.5, '--')

% Set the y-axis limits, x-axis limits, and tick labels for the second subplot
ylim([0.5 1]) % Limits for y-axis
xlim([0.5 6.5]) % Limits for x-axis
xticks([1 2 3 4 5 6]); % X-Tick positions
xticklabels({'1st grade', '2nd grade', '3rd grade', '4th grade', '5th grade', 'Aggregate'}); % X-Tick labels

% Add legend to the plot
legend('Female', '', '', '', 'Male', '', '', '', '', 'Location', 'southeast');

% Set font for current axes in the second subplot
set(gca, 'FontName', 'Times')
hold off

%% t-tests

% Collect the estimation of the consideration parameter
P1p = RHO{1}([1:5 11]);
P2p = RHO{1}([6:10 12]);


% Collect the standard errors
S1p = STANDARDERR{1}([1:5 11]);
S2p = STANDARDERR{1}([6:10 12]);


% T-test between 1st and 5th grade pencils in School L and H
T1st5thGrade_G_pencils = (P1p(1)-P1p(5))/sqrt(S1p(1)^2 + S1p(5)^2);
T1st5thGrade_B_pencils = (P2p(1)-P2p(5))/sqrt(S2p(1)^2 + S2p(5)^2);


% T-test acroos schools at grade 1st, 5th, and total pencils
TacrossGender_1st_pencils = (P1p(1)-P2p(1))/sqrt(S1p(1)^2 + S2p(1)^2);
TacrossGender_5th_pencils = (P1p(5)-P2p(5))/sqrt(S1p(5)^2 + S2p(5)^2);
TacrossGender_Tot_pencils = (P1p(6)-P2p(6))/sqrt(S1p(6)^2 + S2p(6)^2);


% Collect the results in an array
TT = [T1st5thGrade_G_pencils
    T1st5thGrade_B_pencils;


TacrossGender_1st_pencils;
TacrossGender_5th_pencils ;
TacrossGender_Tot_pencils ;

];

Pvalue = normcdf(TT)*2; % two-tailed p-value

% Saving tables summarizing the t-tests and the comparisons

section_5_2_11 = array2table([[P1p(1);P2p(1)], [P1p(5);P2p(5)], Pvalue(1:2)] , ...
    "RowNames", {'Pencils - Female', 'Pencils - Male'}, "VariableNames",{'1st','5th','pvalue'})

section_5_2_21 = array2table([[P1p(1);P1p(5);P1p(6)], [P2p(1);P2p(5);P2p(6)], Pvalue(3:end)], ...
    "RowNames", {'Pencils - 1st', 'Pencils - 5th', 'Pencils - aggregate'}, "VariableNames",{'Female','Male','pvalue'})

