%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Table 5 - Odds ratios %%%%%%%%%%%%%%%%%
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

% PROPORTIONS IN INDEPENDENT TASK

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

% PROPORTIONS IN CORRELATED TASK

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


% Collect the relevant proportions and the numerosity of the samples
Correlated = [N(9:16,:),CORR(9:16,:)];

Independent = [N(9:16,:),IND(9:16,:)];

% Calculate the odds-ratios and create the tables

TABLE5_1 = [ (  Independent(6,4)*(1 - Independent(8,4))  )/ ((1-Independent(6,4))*Independent(8,4) )
    (  Independent(2,4)*(1 - Independent(4,4))  )/ ( (1-Independent(2,4))*Independent(4,4) );
                ]

TABLE5_1 = array2table(TABLE5_1,"RowNames",{'School H', 'School L'},...
    "VariableNames",{'Independent Task'})



TABLE5_2 = [ (  Correlated(8,2)*(1 - Independent(8,2))  )/ ( (1-Correlated(8,2))*Independent(8,2) ),  (  Correlated(7,2)*(1 - Independent(7,2))  )/ ( (1-Correlated(7,2))*Independent(7,2) ),  (  Correlated(6,2)*(1 - Independent(6,2))  )/ ( (1-Correlated(6,2))*Independent(6,2) );
             (  Correlated(4,2)*(1 - Independent(4,2))  )/ ( (1-Correlated(4,2))*Independent(4,2) ),  (  Correlated(3,2)*(1 - Independent(3,2))  )/ ( (1-Correlated(3,2))*Independent(3,2) ),  (  Correlated(2,2)*(1 - Independent(2,2))  )/ ( (1-Correlated(2,2))*Independent(2,2) );
                ]

TABLE5_2 = array2table(TABLE5_2,"RowNames",{'School H', 'School L'},...
    "VariableNames",{'3rd','4th','5th'})