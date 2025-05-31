%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Table 4 - Correlated Task    %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


%% BOOTSTRAP STANDARD ERRORS FOR ALL ESTIMATES

% SAMPLE SIZE for all sub-populations

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

% PROPORTIONS IN THE CORRELATED TASK

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




%% Likelihood ratio tests

%%% Estimates correlated

% Set optimization options for fmincon with no display and strict tolerances
options=optimoptions('fmincon','display','off','MaxFunctionEvaluations',1e6,...
    'StepTolerance',1e-8,'FunctionTolerance',1e-8,'OptimalityTolerance',1e-8,'FiniteDifferenceType','central' );

for z=1:size(N,1)
x0 = [0.5, 0.5, 0.5]; % Initial guess for optimization variables (3 parameters set at 0.5)

% Equality constraints matrix (ensures some linear conditions on x)
Aeq = [1,-1,0; 1,0,-1];
% Right hand side vector for equality constraints (zeros)
beq = [0;0];
% Lower bounds for variables (all zero)
lb=[0;0;0];
% Upper bounds for variables (all one)
ub=[1;1;1];

% Run constrained optimization
[xc] = fmincon(@(x) correlated2(x,CORR(z,1),CORR(z,2),CORR(z,3),N(z,1)), x0', [],[],Aeq,beq,lb,ub,[],[])

% Run unconstrained optimization
[xu] = fmincon(@(x) correlated2(x,CORR(z,1),CORR(z,2),CORR(z,3),N(z,1)), x0', [],[],[0,1,0],0.5,lb,ub,[],[])

A = round(CORR(z,1)*N(z,1));
B = round(CORR(z,2)*N(z,1));
C = round(CORR(z,3)*N(z,1));

% Compute the log-likelihood constrained
R = 1-(xc(1)*(1-xc(2))*(1-xc(3)) + xc(2)*(1-xc(1))*(1-xc(3)) + xc(3)*(1-xc(1))*(1-xc(2)) + (1-xc(1))*(1-xc(2))*(1-xc(3)));
LL1 = - A*log((xc(1)*xc(2)*(1- xc(3)))/R) - B*log((xc(1)*xc(3)*(1- xc(2)))/R)- C*log((xc(2)*xc(3))/R);
P1 = [(xc(1)*xc(2)*(1- xc(3)))/R, (xc(1)*xc(3)*(1- xc(2)))/R, (xc(2)*xc(3))/R];

% Compute the log-likelihood unconstrained
R = 1-(xu(1)*(1-xu(2))*(1-xu(3)) + xu(2)*(1-xu(1))*(1-xu(3)) + xu(3)*(1-xu(1))*(1-xu(2)) + (1-xu(1))*(1-xu(2))*(1-xu(3)));
LL2 = - A*log((xu(1)*xu(2)*(1- xu(3)))/R) - B*log((xu(1)*xu(3)*(1- xu(2)))/R)- C*log((xu(2)*xu(3))/R);
P2 = [(xu(1)*xu(2)*(1- xu(3)))/R, (xu(1)*xu(3)*(1- xu(2)))/R, (xu(2)*xu(3))/R];

% Compute the empirical log-likelihood that should be the same as the
% unconstrained one
LL3 = - A*log(CORR(z,1)) - B*log(CORR(z,2)) - C*log(CORR(z,3));

% likelihood ratio test
[h(z), pvalue(z)] = lratiotest(-LL2, -LL1, 1)
end

% Create the table
Correlated = [N(9:16,:),CORR(9:16,:),pvalue(:,9:16)'];

TABLE4 = array2table(Correlated,"RowNames",{'Agg School L', '5th School L', '4th School L', '3rd School L','Agg School H', '5th School H', '4th School H', '3rd School H'},...
    "VariableNames",{'N','L5','L6','L7','LRT'});
