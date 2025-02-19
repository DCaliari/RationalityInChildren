%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% PLOTS and STATISTICS pachinko %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% loading key variables

create_variables

create_pachinko_dataset

%%% dummy for classes covered by second wave
covered = zeros(length(group),1);
for i=1:length(group)
    covered(i,1) = ismember(group(i),groups_pachinko2ndwave);
end
covered = logical(covered);

%%% dummy for attrition

attrition = zeros(length(group),1);
for i=1:length(group)
    attrition(i,1) = isnan(ind1_2w(i)) & covered(i);
end

ATTRITION = 1-sum(covered.*attrition)/sum(covered);

% generate the variable win/lose

win = (threes_twos==1 & esito<5 & esito>0) | (threes_ones == 1 & esito<8 & esito>0) | (twos_ones==1 & esito<8 & esito>0);
win=double(win);
win(esito==0)=99;


%% correlation between the 2 waves

newdata = covered & ~attrition;

%%% create school_pachinko variable

for i=1:size(groups_classes,1)
if strcmp(groups_classes(i,2),'russo')
    groups_classes{i,4}=1;
elseif strcmp(groups_classes(i,2),'trincone')
    groups_classes{i,4}=2;
elseif strcmp(groups_classes(i,2),'fatale')
    groups_classes{i,4}=3;
elseif strcmp(groups_classes(i,2),'marconi')
    groups_classes{i,4}=4;
end
end

groups_p = DATA_pachinko.group;


school_pachinko = ismember(cell2mat(groups_classes(:,1)),groups_p);
temp = [cell2mat(groups_classes(:,1)),cell2mat(groups_classes(:,4))];
temp = temp(school_pachinko,:);

for i=1:size(groups_p,1)
    for j=1:size(groups_p,1)
        if groups_p(i,1)==temp(j,1)
            tt(i)=temp(j,2);
            break  
        end
    end
end
school_pachinko = tt';

school_class_pachinko = [reshape(repmat([1,2,3,4],3,1),[],1),repmat([3,4,5],1,4)'];

fail_corr = (corr1_2w + corr2_2w + corr3_2w)>1 | (corr1_2w + corr2_2w + corr3_2w)==0;

%% joint distribution independent/correlated choices only Marconi and Russo

M = school_pachinko==4;
R = school_pachinko==1;
E = school_pachinko>1 & school_pachinko<4;


for i=3:5
    sum(newdata & M & class==i & fail_corr==0);
    sum(newdata & R & class==i & fail_corr==0);
    sum(newdata & E & class==i & fail_corr==0);
end

tt = {'Grade 3° - School H - (n = 48)','Grade 4° - School H - (n = 50)','Grade 5° - School H - (n = 48)'};
tl = {'Grade 3° - School L - (n = 36)','Grade 4° - School L - (n = 46)','Grade 5° - School L - (n = 44)'};
tm = {'Grade 3° - Schools M - (n = 16)','Grade 4° - Schools M - (n = 35)','Grade 5° - Schools M - (n = 40)'};


for i=1:3
subplot(2,3,i)
i=i+2;
joint=zeros(3);
joint(1,1)= sum(corr1_2w(newdata & M & class==i & fail_corr==0)==1 & ind1_2w(newdata & M & class==i & fail_corr==0)==1)/sum(newdata & M & class==i & fail_corr==0);
joint(1,2)= sum(corr1_2w(newdata & M & class==i & fail_corr==0)==1 & ind2_2w(newdata & M & class==i & fail_corr==0)==1)/sum(newdata & M & class==i & fail_corr==0);
joint(1,3)= sum(corr1_2w(newdata & M & class==i & fail_corr==0)==1 & ind3_2w(newdata & M & class==i & fail_corr==0)==1)/sum(newdata & M & class==i & fail_corr==0);
joint(2,1)= sum(corr2_2w(newdata & M & class==i & fail_corr==0)==1 & ind1_2w(newdata & M & class==i & fail_corr==0)==1)/sum(newdata & M & class==i & fail_corr==0);
joint(2,2)= sum(corr2_2w(newdata & M & class==i & fail_corr==0)==1 & ind2_2w(newdata & M & class==i & fail_corr==0)==1)/sum(newdata & M & class==i & fail_corr==0);
joint(2,3)= sum(corr2_2w(newdata & M & class==i & fail_corr==0)==1 & ind3_2w(newdata & M & class==i & fail_corr==0)==1)/sum(newdata & M & class==i & fail_corr==0);
joint(3,1)= sum(corr3_2w(newdata & M & class==i & fail_corr==0)==1 & ind1_2w(newdata & M & class==i & fail_corr==0)==1)/sum(newdata & M & class==i & fail_corr==0);
joint(3,2)= sum(corr3_2w(newdata & M & class==i & fail_corr==0)==1 & ind2_2w(newdata & M & class==i & fail_corr==0)==1)/sum(newdata & M & class==i & fail_corr==0);
joint(3,3)= sum(corr3_2w(newdata & M & class==i & fail_corr==0)==1 & ind3_2w(newdata & M & class==i & fail_corr==0)==1)/sum(newdata & M & class==i & fail_corr==0);

cat = categorical({'5','6','7'});
heatmap(cat,cat,joint,'ColorLimits',[0,0.5],'FontName','Times New Roman')
xlabel('Independent')
ylabel('Correlated')
title(tt{i-2})
set(gca,'Fontname',"Times")
end
for i=1:3
subplot(2,3,i+3)
i=i+2;

R = school_pachinko==1;

joint=zeros(3);
joint(1,1)= sum(corr1_2w(newdata & R & class==i & fail_corr==0)==1 & ind1_2w(newdata & R & class==i & fail_corr==0)==1)/sum(newdata & R & class==i & fail_corr==0);
joint(1,2)= sum(corr1_2w(newdata & R & class==i & fail_corr==0)==1 & ind2_2w(newdata & R & class==i & fail_corr==0)==1)/sum(newdata & R & class==i & fail_corr==0);
joint(1,3)= sum(corr1_2w(newdata & R & class==i & fail_corr==0)==1 & ind3_2w(newdata & R & class==i & fail_corr==0)==1)/sum(newdata & R & class==i & fail_corr==0);
joint(2,1)= sum(corr2_2w(newdata & R & class==i & fail_corr==0)==1 & ind1_2w(newdata & R & class==i & fail_corr==0)==1)/sum(newdata & R & class==i & fail_corr==0);
joint(2,2)= sum(corr2_2w(newdata & R & class==i & fail_corr==0)==1 & ind2_2w(newdata & R & class==i & fail_corr==0)==1)/sum(newdata & R & class==i & fail_corr==0);
joint(2,3)= sum(corr2_2w(newdata & R & class==i & fail_corr==0)==1 & ind3_2w(newdata & R & class==i & fail_corr==0)==1)/sum(newdata & R & class==i & fail_corr==0);
joint(3,1)= sum(corr3_2w(newdata & R & class==i & fail_corr==0)==1 & ind1_2w(newdata & R & class==i & fail_corr==0)==1)/sum(newdata & R & class==i & fail_corr==0);
joint(3,2)= sum(corr3_2w(newdata & R & class==i & fail_corr==0)==1 & ind2_2w(newdata & R & class==i & fail_corr==0)==1)/sum(newdata & R & class==i & fail_corr==0);
joint(3,3)= sum(corr3_2w(newdata & R & class==i & fail_corr==0)==1 & ind3_2w(newdata & R & class==i & fail_corr==0)==1)/sum(newdata & R & class==i & fail_corr==0);

cat = categorical({'5','6','7'});
heatmap(cat,cat,joint,'ColorLimits',[0,0.5],'FontName','Times New Roman')
xlabel('Independent')
ylabel('Correlated')
title(tl{i-2})
set(gca,'Fontname',"Times")
end

