% Clear workspace and command window
clear
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 4 - Cumulative distributions of parental education %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load necessary data files
load gender_class_school.mat  % Data containing gender and school class info
load parent_edu.mat          % Data containing parental education levels
load groups.mat              % Data containing grouping information

% Define categorical levels for parental education
edu = categorical({'primary school', 'secondary school', 'high school', 'bachelor', 'master', 'doctorate'});
% Reorder the categories for consistent plotting
edu = reordercats(edu, {'primary school', 'secondary school', 'high school', 'bachelor', 'master', 'doctorate'});

% Create a logical index to filter out groups that faced the experiment
% twice in Spring and Autumn
rep = group == 52 | group == 55;  % Exclude groups 52 and 55 to avoid duplication

% Initialize arrays for cumulative distribution functions (CDF)
cdf1 = zeros(1, 6);
cdf2 = zeros(1, 6);
cdf3 = zeros(1, 6);
cdf4 = zeros(1, 6);

% Loop through each level of education (1 to 6)
for i = 1:6
    % Calculate probability density function (PDF) for each school group
    pdf1(i) = sum(parent_edu == i & school == 1 & ~rep) / sum(school == 1 & parent_edu > 0 & ~rep);
    pdf2(i) = sum(parent_edu == i & school == 2 & ~rep) / sum(school == 2 & parent_edu > 0 & ~rep);
    pdf3(i) = sum(parent_edu == i & school == 3 & ~rep) / sum(school == 3 & parent_edu > 0 & ~rep);
    pdf4(i) = sum(parent_edu == i & school == 4 & ~rep) / sum(school == 4 & parent_edu > 0 & ~rep);
    
    % Calculate cumulative distribution function (CDF) based on the PDF
    if i == 1
        cdf1(i) = pdf1(i);  % For the first education level, CDF is the same as PDF
        cdf2(i) = pdf2(i);
        cdf3(i) = pdf3(i);
        cdf4(i) = pdf4(i);
    elseif i > 1
        cdf1(i) = pdf1(i) + cdf1(i - 1);  % CDF is the sum of current PDF and previous CDF
        cdf2(i) = pdf2(i) + cdf2(i - 1);
        cdf3(i) = pdf3(i) + cdf3(i - 1);
        cdf4(i) = pdf4(i) + cdf4(i - 1);
    end
end

% Combine CDFs into a matrix for plotting
cdf = [cdf1; cdf2; cdf3; cdf4];

% Plotting the CDFs
plot(edu, cdf, '-*');  % Plot CDFs with markers at data points
set(gca, 'FontName', 'Times');  % Set font for the axes

% Adjust y-axis limits for better visibility
ylim([-0.1, 1.1]);
grid on;  % Add grid to the plot

% Add legend to differentiate between school groups
legend('School 1', 'School 2', 'School 3', 'School 4', 'Location', 'northwest');