%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 8: No Binary Cycle and Always Chosen %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear

% Load datasets needed for the analysis
create_warp_datasets
data = NEW;

clearvars -except dataset_WARP data

%% Load additional data on school, groups, class, etc...
load groups.mat 
load gender_class_school

spring = group < 8; % I focus on the pupils who did the experiment in the autumn


%% Use function AC_BC to calculate No Binary Cycles and Always Chosen

for i=1:size(data{1,1},1)
PENCILS(:,i) = data{1,1}{i,1}(:,5);
PENS(:,i) = data{2,1}{i,1}(:,5);
end

[AC_pencils, BC_pencils, ~] = AC_BC(PENCILS);
[AC_pens, BC_pens, ~] = AC_BC(PENS); 

AC_pencilsR = AC_pencils == 0;
BC_pencilsR = BC_pencils == 0;

AC_pensR = AC_pens == 0;
BC_pensR = BC_pens == 0;

%% PLOT DEVELOPMENT BY SCHOOL




% Schools and grades
schoolList = [1, 4];
grades = 1:5;
labels = {'1st grade','2nd grade','3rd grade','4th grade','5th grade'};

for j = 1:2
    s = schoolList(j);
    for i = 1:5
        idx1 = ~spring & class==i & school==s;
        n1(j,i) = sum(idx1);
        p1(j,i) = sum(BC_pencilsR(idx1)) / n1(j,i);

        idx2 = ~spring & class==i & school==s & BC_pencilsR==1;
        n2(j,i) = sum(idx2);
        p2(j,i) = sum(AC_pencilsR(idx2)) / n2(j,i);
    end
end

% Standard errors (binomial)
se1 = sqrt( p1 .* (1 - p1) ./ n1 );
se2 = sqrt( p2 .* (1 - p2) ./ n2 );

% Example assumes p1, p2, se1, se2, grades, labels, schoolList are already computed.

% School 1 (red theme)
red_dark  = [1, 0, 0];   % darker red (NBC)
red_light = [1, 0, 0];   % lighter red (AC|NBC)

% School 4 (blue theme)
blue_dark  = [0, 0, 1];  % darker blue (NBC)
blue_light = [0, 0, 1];  % lighter blue (AC|NBC)

% Map per-school colors: rows correspond to schoolList order (school 1, school 4)
leftColor  = [red_dark;  blue_dark];   % left axis (NBC) uses darker shade
rightColor = [red_light; blue_light];  % right axis (AC|NBC) uses lighter shade

% Line styles / markers
ls_p1 = '-'; marker_p1 = 'o';   % NBC: solid, circle (left axis)
ls_p2 = ':'; marker_p2 = 's';   % AC|NBC: dotted, square (right axis)

figure;
for j = 1:2
    subplot(1,2,j);        % left: school 1, right: school 4

    % LEFT yyaxis (NBC)
    h1 = errorbar(grades, p1(j,:), se1(j,:), ...
        'LineStyle', ls_p1, 'Marker', marker_p1, ...
        'LineWidth', 0.8, 'MarkerSize', 3, 'Color', leftColor(j,:), ...
        'CapSize', 8);
    hold on
    % RIGHT yyaxis (AC | NBC)
    h2 = errorbar(grades, p2(j,:), se2(j,:), ...
        'LineStyle', ls_p2, 'Marker', marker_p2, ...
        'LineWidth', 0.8, 'MarkerSize', 3, 'Color', rightColor(j,:), ...
        'CapSize', 8);
    ylim([0 1]);
    yticks(0:0.2:1);
    xlim([0.8 5.2])
    set(gca, 'XTick', grades, 'XTickLabel', labels, 'FontName', 'Times');
    % title(sprintf('School %d', schoolList(j)));
    legend([h1, h2], {'NBC','AC|NBC'}, 'Location', 'best');
    % grid on
    hold off
end

drawnow;                           % ensure figure is rendered
fig = gcf;
% set figure size (inches) to control output size; adjust as needed
fig.Units = 'inches';
fig.Position = [1 1 8 4];         % [left bottom width height] in inches

% ensure paper size matches figure
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 fig.Position(3) fig.Position(4)];
fig.PaperSize = [fig.Position(3) fig.Position(4)];

filename = 'ACBCdevelopmentSchools.pdf';
exportgraphics(fig, filename, 'ContentType', 'vector');
fprintf('Saved PDF: %s\n', filename);


% -----------------------
% Tests: grade5 vs grade1 within each school
% -----------------------
% two-proportion z-test (pooled) - returns z and two-sided p
two_prop_z = @(xA,nA,xB,nB) deal( ...
    ( (xB/nB) - (xA/nA) ) ./ sqrt( ((xA+xB)/(nA+nB)) .* (1 - ((xA+xB)/(nA+nB))) .* (1/nA + 1/nB) ), ...
    2*(1 - normcdf(abs( ( (xB/nB) - (xA/nA) ) ./ sqrt( ((xA+xB)/(nA+nB)) .* (1 - ((xA+xB)/(nA+nB))) .* (1/nA + 1/nB) )))) ...
);

fprintf('\nComparisons: grade 5 vs grade 1 (within each school)\n-----------------------------------------------\n');

for j = 1:2
    s = schoolList(j);
    fprintf('School %d:\n', s);

    % NBC (p1)
    x1_p1 = sum( BC_pencilsR(~spring & class==1 & school==s) );
    n1_p1 = sum( ~spring & class==1 & school==s );
    x5_p1 = sum( BC_pencilsR(~spring & class==5 & school==s) );
    n5_p1 = sum( ~spring & class==5 & school==s );

    [z_p1, pval_z_p1] = two_prop_z(x1_p1, n1_p1, x5_p1, n5_p1);
    tbl_p1 = [ x1_p1, n1_p1 - x1_p1;  x5_p1, n5_p1 - x5_p1 ];

    fprintf('  NBC: grade1 = %d/%d (%.3f), grade5 = %d/%d (%.3f)\n', ...
        x1_p1, n1_p1, x1_p1/n1_p1, x5_p1, n5_p1, x5_p1/n5_p1);
    fprintf('    z = %.3f, two-sided p (z-test) = %.4f', z_p1, pval_z_p1);

    % AC | NBC (p2)
    x1_p2 = sum( AC_pencilsR(~spring & class==1 & school==s & BC_pencilsR==1) );
    n1_p2 = sum( ~spring & class==1 & school==s & BC_pencilsR==1 );
    x5_p2 = sum( AC_pencilsR(~spring & class==5 & school==s & BC_pencilsR==1) );
    n5_p2 = sum( ~spring & class==5 & school==s & BC_pencilsR==1 );

    [z_p2, pval_z_p2] = two_prop_z(x1_p2, n1_p2, x5_p2, n5_p2);
    tbl_p2 = [ x1_p2, n1_p2 - x1_p2;  x5_p2, n5_p2 - x5_p2 ];

    fprintf('  AC|NBC: grade1 = %d/%d (%.3f), grade5 = %d/%d (%.3f)\n', ...
        x1_p2, n1_p2, x1_p2/n1_p2, x5_p2, n5_p2, x5_p2/n5_p2);
    fprintf('    z = %.3f, two-sided p (z-test) = %.4f', z_p2, pval_z_p2);
end






