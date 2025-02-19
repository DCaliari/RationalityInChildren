clear
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Code for Figure on Parental Education %%%%%%%%%%%
%%%%% and statistical tests %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load gender_class_school.mat

load parent_edu.mat

load groups.mat


edu = categorical({'primary school','secondary school','high school', 'bachelor','master','doctorate'});
edu = reordercats(edu,{'primary school','secondary school','high school', 'bachelor','master','doctorate'});

rep = group==52 | group==55; % I get rid of two groups that repeated the experiment twice to avoid duplication of data on parental education

% the next for loop creates the CDF to plot

cdf1 = zeros(1,6);
cdf2 = zeros(1,6);
cdf3 = zeros(1,6);
cdf4 = zeros(1,6);
for i=1:6
pdf1(i) = sum(parent_edu==i & school==1 & ~rep)/sum(school==1 & parent_edu>0 & ~rep); 
pdf2(i) = sum(parent_edu==i & school==2 & ~rep)/sum(school==2 & parent_edu>0 & ~rep); 
pdf3(i) = sum(parent_edu==i & school==3 & ~rep)/sum(school==3 & parent_edu>0 & ~rep); 
pdf4(i) = sum(parent_edu==i & school==4 & ~rep)/sum(school==4 & parent_edu>0 & ~rep); 
if i==1
cdf1(i) = pdf1(i);
cdf2(i) = pdf2(i);
cdf3(i) = pdf3(i);
cdf4(i) = pdf4(i);
elseif i>1
cdf1(i) = pdf1(i) + cdf1(i-1);
cdf2(i) = pdf2(i) + cdf2(i-1);
cdf3(i) = pdf3(i) + cdf3(i-1);
cdf4(i) = pdf4(i) + cdf4(i-1);
end
end

% Plotting the CDF

cdf = [cdf1;cdf2;cdf3;cdf4];
plot(edu,cdf, '-*')
set(gca,'FontName','Times')
ylim([-0.1,1.1])
grid
legend('School L','School 2', 'School 3', 'School H', 'Location', 'northwest')
