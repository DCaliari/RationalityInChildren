%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Code to compute the chi square test %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create datasets needed for the analysis
create_warp_datasets

% Obtain the dataset for estimation using the function "dataset_constructions"
[DATA1, DATA2, ~, ~, ~, ~] = dataset_constructions(DATASET(:, 1:6), n); 

C_pencils = DATA1; % Store the choices from the pencils
C_pens = DATA2;    % Store the choices from the pens

%% Load additional data on school, groups, class, etc...
load groups.mat 
load gender_class_school.mat

% Identify pupils who participated in the autumn experiment
spring = group < 8; 

%% Create subpopulations based on school and class

for fig = 1:2

    if fig == 1
T(:,1) = gender & ~spring & (school ==1 | school == 4);
T(:,2) = ~gender & ~spring & (school ==1 | school == 4);
    elseif fig == 2
T(:,1) = ~spring & school ==1;
T(:,2) = ~spring & school == 4;
    end

%% Begin the estimation process
for treatment = 1:2
    if treatment == 1 % Focus on pencils
        C = C_pencils;
    elseif treatment == 2 % Focus on pens
        C = C_pens;
    end

    clearvars N p_par_new pi_par_new F y % Clear previous variables

    g = 1; % Number of gamma parameters = 1 (unique consideration parameter)

    N1 = size(C(T(:, 1), :), 1); % Number of individuals in the current subpopulation

    N2 = size(C(T(:, 2), :), 1); % Number of individuals in the current subpopulation

    % Initial value for gamma parameter
    p_par(1,1) = 0.5; % gamma school l
    p_par(2,1) = 0.5; % gamma school h
    
    pi_par = ones(1, (g) * lc*2) / ((g) * lc*2); 
 
    % Starting old parameters 
    pi_par_old = pi_par; 

    tol_par = 1e-9; % Tolerance for parameter convergence
    par_dist = 1; it = 1; % Initialize distances and iteration counter
    p_par_old = p_par; % Store the old gamma parameter

    % Optimization options
    options = optimoptions('fmincon', 'display', 'off', 'MaxFunctionEvaluations', 1e7,...
        'StepTolerance', 1e-9, 'FunctionTolerance', 1e-9, 'OptimalityTolerance', 1e-9, ...
        'FiniteDifferenceType', 'central' );

    LL_dist = 1; % Initialize log-likelihood distance
    tol_LL = 1e-8; % Tolerance for log-likelihood differences

    % Optimization loop for parameters
    while LL_dist > tol_LL
        clearvars Q P 
        Q = []; 
        p_par = p_par_old;

        temp_par = repmat(p_par, 1, 4); % Replicate gamma parameter for alternatives (unique consideration parameter)

        % Calculate conditional probabilities matrices
        for i = 1:size(p_par, 1)
            for u = 1:lc
                P(:, u) = P_Rho_varying_type(temp_par(i, :), PER, u, R); 
            end
            temp = P;
            Q = [Q, temp];
        end

        % Calculate the likelihood function
        F1 = exp(C(T(:, 1), :) * log(Q(:,1:24))); 
        F2 = exp(C(T(:, 2), :) * log(Q(:,25:48))); 

        % Constraints for the first optimization problem
        lb = zeros(lc*2, 1); % Lower bound
        ub = ones(lc*2, 1);  % Upper bound
        Aeq = [ones(1, lc),zeros(1,lc); zeros(1,lc),ones(1,lc)];  % Vector for probabilities to sum to one
        beq = [1;1];                     % Equality constraint value
        

        % Maximization of the likelihood with respect to the probability distribution
        [pi_par_new] = fmincon(@(pi_par) Log_lik_EB_pooled(pi_par, F1,F2), pi_par_old', [], [], Aeq, ...
            beq, lb, ub, [], options); 
        pi_par_new = pi_par_new'; % Transpose to match dimensions

        % Constraints for maximizing gamma
        lb = [0;0];
        ub = [1;1];

        % Maximization of the likelihood with respect to gamma
        [p_par_new, ~, ~, ~, ~, grad, hessian] = fmincon(@(p_par) log_lik_model_pooled(p_par, pi_par_new, PER, lc, R, C(T(:, 1), :), C(T(:, 2), :)), ...
            p_par_old, [], [], [], [], lb, ub, [], options); 

        % Calculate log-likelihood distance for convergence check
        LL_dist = log_lik_model_pooled(p_par_old, pi_par_new, PER, lc, R, C(T(:, 1), :), C(T(:, 2), :)) - ...
                  log_lik_model_pooled(p_par_new, pi_par_new, PER, lc, R, C(T(:, 1), :), C(T(:, 2), :)); 

        % Update parameters for next iteration of the while loop
        pi_par_old = pi_par_new;
        p_par_old = p_par_new; 
        it = it + 1; % Increment iteration counter
    end

    % Store the estimated gamma and probability distribution
    parameters{treatment}(:, 1) = p_par_new; 
    preferences{treatment}(1, :) = pi_par_new; 
end % End of subpopulation loop

% Store the resulting likelihoods for pencils and pens
LLu_pencils = -log_lik_model_pooled(parameters{1}(:, 1), preferences{1}(1, :), PER, lc, R, C_pencils(T(:, 1), :), C_pencils(T(:, 2), :));

LLu_pens = -log_lik_model_pooled(parameters{2}(:, 1), preferences{2}(1, :), PER, lc, R, C_pens(T(:, 1), :), C_pens(T(:, 2), :));

prefu_pencils = preferences{1}(1, :);
prefu_pens = preferences{2}(1, :);

%% Begin the estimation process
for treatment = 1:2
    if treatment == 1 % Focus on pencils
        C = C_pencils;
    elseif treatment == 2 % Focus on pens
        C = C_pens;
    end

    clearvars N p_par_new pi_par_new F y % Clear previous variables

    g = 1; % Number of gamma parameters = 1 (unique consideration parameter)

    N1 = size(C(T(:, 1), :), 1); % Number of individuals in the current subpopulation

    N2 = size(C(T(:, 2), :), 1); % Number of individuals in the current subpopulation

    % Initial value for gamma parameter
    p_par(1,1) = 0.5; % gamma school l
    p_par(2,1) = 0.5; % gamma school h
    
    pi_par = ones(1, (g) * lc*2) / ((g) * lc*2); 
 
    % Starting old parameters 
    pi_par_old = pi_par; 

    tol_par = 1e-9; % Tolerance for parameter convergence
    par_dist = 1; it = 1; % Initialize distances and iteration counter
    p_par_old = p_par; % Store the old gamma parameter

    % Optimization options
    options = optimoptions('fmincon', 'display', 'off', 'MaxFunctionEvaluations', 1e7,...
        'StepTolerance', 1e-9, 'FunctionTolerance', 1e-9, 'OptimalityTolerance', 1e-9, ...
        'FiniteDifferenceType', 'central' );

    LL_dist = 1; % Initialize log-likelihood distance
    tol_LL = 1e-8; % Tolerance for log-likelihood differences

    % Optimization loop for parameters
    while LL_dist > tol_LL
        clearvars Q P 
        Q = []; 
        p_par = p_par_old;

        temp_par = repmat(p_par, 1, 4); % Replicate gamma parameter for alternatives (unique consideration parameter)

        % Calculate conditional probabilities matrices
        for i = 1:size(p_par, 1)
            for u = 1:lc
                P(:, u) = P_Rho_varying_type(temp_par(i, :), PER, u, R); 
            end
            temp = P;
            Q = [Q, temp]; % Concatenate calculated Q values
        end

        % Calculate the likelihood function
        F1 = exp(C(T(:, 1), :) * log(Q(:,1:24))); 
        F2 = exp(C(T(:, 2), :) * log(Q(:,25:48))); 

        % Constraints for the first optimization problem
        lb = zeros(lc*2, 1); % Lower bound
        ub = ones(lc*2, 1);  % Upper bound
        Aeq = [ones(1, lc),zeros(1,lc); zeros(1,lc),ones(1,lc);
            eye(lc),eye(lc).*-1
        
        
        ];
        Aeq = Aeq(1:end-1,:);% Vector for probabilities to sum to one + the constraint of equality for the distributions
        beq = [1;1;zeros(lc-1,1)];                     % Equality constraint value
        
            


        % Maximization of the likelihood with respect to the probability distribution
        [pi_par_new] = fmincon(@(pi_par) Log_lik_EB_pooled(pi_par, F1,F2), pi_par_old', [], [], Aeq, ...
            beq, lb, ub, [], options); 
        pi_par_new = pi_par_new'; % Transpose to match dimensions

        % Constraints for maximizing gamma
        lb = [0;0];
        ub = [1;1];

        % Maximization of the likelihood with respect to gamma
        [p_par_new, ~, ~, ~, ~, grad, hessian] = fmincon(@(p_par) log_lik_model_pooled(p_par, pi_par_new, PER, lc, R, C(T(:, 1), :), C(T(:, 2), :)), ...
            p_par_old, [], [], [], [], lb, ub, [], options); 

        % Calculate log-likelihood distance for convergence check
        LL_dist = log_lik_model_pooled(p_par_old, pi_par_new, PER, lc, R, C(T(:, 1), :), C(T(:, 2), :)) - ...
                  log_lik_model_pooled(p_par_new, pi_par_new, PER, lc, R, C(T(:, 1), :), C(T(:, 2), :)); 

        % Update parameters for next iteration of the while loop
        pi_par_old = pi_par_new;
        p_par_old = p_par_new; 
        it = it + 1; % Increment iteration counter
    end

    % Store the estimated gamma and probability distribution
    parameters{treatment}(:, 1) = p_par_new; 
    preferences{treatment}(1, :) = pi_par_new; 
end % End of subpopulation loop


% Below we show the likelihood-ratio test, notice that
% The likelihood-ratio test cannot be used in this case due to the nature
% of the maximization problem which is constrained. 
% In fact, the p-values are incredibly small which is a standard
% observation for LLT in these problems


LLc_pencils = -log_lik_model_pooled(parameters{1}(:, 1), preferences{1}(1, :), PER, lc, R, C_pencils(T(:, 1), :), C_pencils(T(:, 2), :));

LLc_pens = -log_lik_model_pooled(parameters{2}(:, 1), preferences{2}(1, :), PER, lc, R, C_pens(T(:, 1), :), C_pens(T(:, 2), :));


[h,pvalue] = lratiotest(LLu_pencils,LLc_pencils,23)
[h,pvalue] = lratiotest(LLu_pens,LLc_pens,23)


% We, therefore, use a Chi-square test for which we simulate the
% distribution of the test under the null to correct for small sample
% biases


%% Distribution of the chi-square test under the null

NschoolL = sum(T(:,1));
NschoolH = sum(T(:,2));

clearvars tsim sL sH test

B=10000; % set number of bootstrap iterations

for b=1:B
        tsim(b,:) = zeros(1,3);
    while tsim(b,2) == 0 || tsim(b,2) == 1 
sL(b,:) = randsample(1:24, NschoolL, true, preferences{1}(1,1:24));  % sample schools for group L with replacement using estimated constrained preference distribution
sH(b,:) = randsample(1:24, NschoolH, true, preferences{1}(1,25:48)); % sample schools for group H with replacement using estimated constrained preference distribution
[tsim(b,1), tsim(b,2)] = chi2test2(sL(b,:), sH(b,:)); % compute chi-squared statistic and p-value for sampled data
tsim(b,3) = chi2inv(tsim(b,2),23); % compute inverse chi-squared cdf value with 23 degrees of freedom (statistic)
    end
end
tsim_pencils = tsim;
for b=1:B
        tsim(b,:) = zeros(1,3);
    while tsim(b,2) == 0 || tsim(b,2) == 1 
sL(b,:) = randsample(1:24, NschoolL, true, preferences{2}(1,1:24)); % sample schools for group L with replacement using estimated constrained preference distribution
sH(b,:) = randsample(1:24, NschoolH, true, preferences{2}(1,25:48)); % sample schools for group H with replacement using estimated constrained preference distribution
[tsim(b,1), tsim(b,2)] = chi2test2(sL(b,:), sH(b,:)); % compute chi-squared statistic and p-value for sampled data
tsim(b,3) = chi2inv(tsim(b,2),23); % compute inverse chi-squared cdf value with 23 degrees of freedom (statistic)
    end 
end
tsim_pens = tsim;



% pencils: I simulate 10000 samples and for each I compute the chi2
% statistic. Then I average the resulting chi2 statistic to compute the
% p-value
% This is the chi-square from our observed sample. This is a quick
% methodology to obtain it, one could also look at the euclidean distance
% between the distributions

for t=1:10000
    test(t,:) = zeros(1,3);
    while test(t,2) == 0 || test(t,2) == 1
sampleL = randsample(1:24, NschoolL, true, prefu_pencils(1,1:24)); % sample schools for group L with replacement using estimated unconstrained preference distribution
sampleH = randsample(1:24, NschoolH, true, prefu_pencils(1,25:48)); % sample schools for group H with replacement using estimated unconstrained preference distribution

[test(t,1), test(t,2)] = chi2test2(sampleL, sampleH);
test(t,3) = chi2inv(test(t,2),23);
    end
end

chiPencils = chi2cdf(mean(test(:,3)),23); % This is the chi-square from our observed sample.

chistatPencils(fig) = mean(test(:,3)); % This is the chi-square from our observed sample.

% pens: I simulate 10000 samples and for each I compute the chi2
% statistic. Then I average the resulting chi2 statistic to compute the
% p-value
% This is the chi-square from our observed sample. This is a quick
% methodology to obtain it, one could also look at the euclidean distance
% between the distributions

for t=1:10000
    test(t,:) = zeros(1,3);
    while test(t,2) == 0 || test(t,2) == 1
sampleL = randsample(1:24, NschoolL, true, prefu_pens(1,1:24)); % sample schools for group L with replacement using estimated unconstrained preference distribution
sampleH = randsample(1:24, NschoolH, true, prefu_pens(1,25:48)); % sample schools for group H with replacement using estimated unconstrained preference distribution

[test(t,1), test(t,2)] = chi2test2(sampleL, sampleH);
test(t,3) = chi2inv(test(t,2),23);
    end
end

chiPens = chi2cdf(mean(test(:,3)),23); % This is the chi-square from our observed sample.

chistatPens(fig) = mean(test(:,3)); % This is the chi-square from our observed sample.


% Here I used the bootstraped distribution of the test statistic to obtain
% the p-value controlling from small sample

chiCDF = sort(tsim_pencils(:,3));
[~,temp_pvalue_pencils] =min(abs(chiCDF-chistatPencils(fig)));
pvalue_pencils(fig) = temp_pvalue_pencils/B

chiCDF = sort(tsim_pens(:,3));
[~,temp_pvalue_pens] =min(abs(chiCDF-chistatPens(fig)));
pvalue_pens(fig) = temp_pvalue_pens/B

end

section_4_3_chisquare_pencils = array2table(pvalue_pencils' , ...
    "RowNames", {'Pencils - between genders', 'Pencils - between schools'}, "VariableNames",{'Chi2 - pvalue'})

section_A1OA_chisquare_pens = array2table(pvalue_pens' , ...
    "RowNames", {'Pens - between genders', 'Pens - between schools'}, "VariableNames",{'Chi2 - pvalue'})
