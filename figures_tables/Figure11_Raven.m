%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure on Raven development %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear                           % Clear workspace

% Load required datasets
load groups.mat                % Load group information
load kids_raven.mat            % Load Raven test scores for kids
load gender_class_school.mat    % Load gender, class, and school data

% Transpose Raven scores to have the desired orientation
raven = kids_raven';           % Transpose the kids_raven matrix

raven = raven ./ 8;            % Normalize the Raven scores by dividing by 8

% Calculate mean Raven scores and standard errors for different classes and schools
for i = 1:5                    % Loop through each class (1 to 5)
    % For School L (school number 1)
    R(i) = mean(raven(class == i & school == 1)); % Mean score for each class in School L
    STANDARDERR(i) = std(raven(class == i & school == 1)) / sqrt(sum(class == i & school == 1)); % Standard error for each class in School L
    
    % For School H (school number 4)
    R(5 + i) = mean(raven(class == i & school == 4)); % Mean score for each class in School H
    STANDARDERR(5 + i) = std(raven(class == i & school == 4)) / sqrt(sum(class == i & school == 4)); % Standard error for each class in School H
end

% Calculate overall mean and standard error for both schools
R(11) = mean(raven(school == 1));                   % Overall mean for School L
R(12) = mean(raven(school == 4));                   % Overall mean for School H
STANDARDERR(11) = std(raven(school == 1)) / sqrt(sum(school == 1));   % Standard error for School L overall
STANDARDERR(12) = std(raven(school == 4)) / sqrt(sum(school == 4));   % Standard error for School H overall

% Set up x-axis values for plot positioning
x = [1 2 3 4 5 6];            % Define x values for each class and aggregate
x1 = x - 0.1;                 % Adjust x values for School L (moving slightly left)
x2 = x + 0.1;                 % Adjust x values for School H (moving slightly right)

% Prepare data for plot
P = R([1:5 11]);              % Get the mean scores for School L and overall
S = STANDARDERR([1:5 11]);   % Get the standard errors for School L and overall

% Plot mean scores and error bars for School L
plot(x1(1:5), P(1:5), '*', 'MarkerSize', 8, 'Color', 'r') % Plot first five classes for School L
hold on
errorbar(x1(1:5), P(1:5), S(1:5), S(1:5), 'LineStyle', '--', 'LineWidth', 0.8) % Add error bars for School L

hold on
plot(x1(6), P(6), '*', 'MarkerSize', 8, 'Color', 'r', 'LineStyle', 'none') % Plot overall for School L
hold on
errorbar(x1(6), P(6), S(6), S(6), 'LineStyle', 'none', 'LineWidth', 0.8, 'Color', 'r') % Error bar for overall School L
hold on

% Prepare data for School H
P = R([6:10 12]);            % Get mean scores for School H and overall
S = STANDARDERR([6:10 12]); % Get standard errors for School H and overall

% Plot mean scores and error bars for School H
plot(x2(1:5), P(1:5), '*', 'MarkerSize', 8, 'Color', 'b') % Plot first five classes for School H
hold on
errorbar(x2(1:5), P(1:5), S(1:5), S(1:5), 'LineStyle', '--', 'LineWidth', 0.8, 'Color', 'b') % Add error bars for School H

hold on
plot(x2(6), P(6), '*', 'MarkerSize', 8, 'Color', 'b', 'LineStyle', 'none') % Plot overall for School H
hold on
errorbar(x2(6), P(6), S(6), S(6), 'LineStyle', 'none', 'LineWidth', 0.8, 'Color', 'b') % Error bar for overall School H

% Draw a vertical line at x = 5.5
xline(5.5, '--');             % Add a dashed line separating the two schools

% Set plot limits and labels
ylim([0.3 0.9])               % Set y-axis limits for better visibility
xlim([0.5 6.5])               % Set x-axis limits for better visibility
xticks([1 2 3 4 5 6]);        % Define x-ticks
xticklabels({'1st grade', '2nd grade', '3rd grade', '4th grade', '5th grade', 'Aggregate'}); % Label x-ticks

% Add a legend to the plot
legend('School L','','','','School H','','','','','Location','southeast') % Define legend entries

% Set font for axes
set(gca, 'FontName', 'Times')  % Set font name for better appearance
hold off                        % Release hold for further plotting

% T-tests

P1p = R([1:5 11]);
P2p = R([6:10 12]);

S1p = STANDARDERR([1:5 11]);
S2p = STANDARDERR([6:10 12]);

% t-tests 
t5_bet(1) = (P1p(5)-P2p(5))/(sqrt(S1p(5)^2 + S2p(5)^2));

t1_bet(1) = (P1p(1)-P2p(1))/(sqrt(S1p(1)^2 + S2p(1)^2));

tt = [t1_bet;t5_bet];

% p-values

pvalue = normpdf(tt)*2; % two-tailed test

section_7 = array2table([[P1p(1); P1p(5)], [P2p(1); P2p(5)], pvalue], "RowNames", {'1st', '5th'}, "VariableNames", {'School L', 'School H', 'pvalue'})

