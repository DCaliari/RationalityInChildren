%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure on Raven development %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear

load groups.mat
load kids_raven.mat
load gender_class_school.mat

raven=kids_raven';

raven = raven./8;


for i=1:5
    R(i) = mean(raven(class==i & school==1));
    R(5+i) = mean(raven(class==i & school==4));
    STANDARDERR(i) = std(raven(class==i & school==1))/sqrt(sum(class==i & school==1));
    STANDARDERR(5+i) = std(raven(class==i & school==4))/sqrt(sum(class==i & school==4));
end
R(11) = mean(raven(school==1));
R(12) = mean(raven(school==4));
STANDARDERR(11) = std(raven(school==1))/sqrt(sum(school==1));
STANDARDERR(12) = std(raven(school==4))/sqrt(sum(school==4));


x = [1 2 3 4 5 6];
x1 = x-0.1;
x2 = x+0.1;


P = R([1:5 11]);
S = STANDARDERR([1:5 11]);
plot(x1(1:5),P(1:5),'*','MarkerSize',8,'Color','r')
hold on
errorbar(x1(1:5),P(1:5),S(1:5),S(1:5),'LineStyle','--','LineWidth',0.8)
hold on
plot(x1(6),P(6),'*','MarkerSize',8,'Color','r','LineStyle','none')
hold on
errorbar(x1(6),P(6),S(6),S(6),'LineStyle','none','LineWidth',0.8,'Color','r')
hold on
P = R([6:10 12]);
S = STANDARDERR([6:10 12]);
plot(x2(1:5),P(1:5),'*','MarkerSize',8,'Color','b')
hold on
errorbar(x2(1:5),P(1:5),S(1:5),S(1:5),'LineStyle','--','LineWidth',0.8,'Color','b')
hold on
plot(x2(6),P(6),'*','MarkerSize',8,'Color','b','LineStyle','none')
hold on
errorbar(x2(6),P(6),S(6),S(6),'LineStyle','none','LineWidth',0.8,'Color','b')
hold on
xline(5.5,'--')
ylim([0.3 0.9])
xlim([0.5 6.5])
xticks([1 2 3 4 5 6]);
xticklabels({'1st grade', '2nd grade', '3rd grade', '4th grade', '5th grade', 'Aggregate'});
legend('School L','','','','School H','','','','','Location','southeast')
set(gca,'FontName','Times')
hold off

