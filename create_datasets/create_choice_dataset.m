%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% CREATE THE DATASET FOR THE PENCILS/PENS CHOICE TASK %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 

clc

%% loading data

loading_data_choices

clearvars -except NUMBERS numbers

%% laoding global variables

globals

%% Create Menus and Choices

% number of subjects in each group

Nsub_group  = [];
for i=1:size(NUMBERS,1)
    Nsub_group = [Nsub_group; size(unique(NUMBERS{i,1}(:,2)),1)];
end

menus = numbers(:,15:18);
menus(isnan(menus))=[];
menus = reshape(menus,[],4);

choices = numbers(:,19);
choices(isnan(choices))=[];

N_CHOICES = 23;
n = length(choices)/N_CHOICES;

id_specific = numbers(~isnan(numbers(:,19)),2);
id_specific(isnan(id_specific))=[];

id_group = [];
for i=1:size(NUMBERS,1)
    id_group = [id_group; ones(Nsub_group(i,1)*N_CHOICES,1).*i];
end

id = repmat(1:1:n,N_CHOICES,1);
id = reshape(id,[],1);

DATASET = [id, menus, choices, id_specific, id_group]; % this is the dataset of choices/menus

%% select only MAIN alternatives with two groups

% DATASET1 for pencils and DATASET2 for pens

DATASET1 = [];
DATASET2 = [];
for i=1:size(DATASET,1)
    if DATASET(i,2)<5
        DATASET1 = [DATASET1;DATASET(i,:)]; %#ok<AGROW> 
    elseif DATASET(i,2)>4 && DATASET(i,2)<9
        DATASET2 = [DATASET2;DATASET(i,:)]; %#ok<AGROW> 
    end
end


group = DATASET1(:,8);
id = DATASET1(:,7);
menu1_1 = DATASET1(:,2);
menu1_2 = DATASET1(:,3);
menu1_3 = DATASET1(:,4);
menu1_4 = DATASET1(:,5);
scelte1 = DATASET1(:,6);
menu2_1 = DATASET2(:,2);
menu2_2 = DATASET2(:,3);
menu2_3 = DATASET2(:,4);
menu2_4 = DATASET2(:,5);
scelte2 = DATASET2(:,6);


%%
table_choices = table(group,id,menu1_1,menu1_2,menu1_3,menu1_4,scelte1,menu2_1,menu2_2,menu2_3,menu2_4,scelte2,'VariableNames',...
    {'Group', 'Id', 'Menu1_1','Menu1_2','Menu1_3','Menu1_4','Scelte1','Menu2_1','Menu2_2','Menu2_3','Menu2_4','Scelte2'});

% writetable(table_choices, 'stored_datasets/choices.csv')

%%

load ordered_dataset.mat

menu_names = arrayfun(@num2str,STRUCTURE,'un',0);
menu_names = convertCharsToStrings(menu_names);
menu_names = join(menu_names);


dataset1 = NEW{1,1};
choices1 = [];
for i=1:size(dataset1,1)
choices1 = [choices1, dataset1{i,1}(:,5)];
end
choices1 = choices1';

structure2 = STRUCTURE;
structure2(structure2==1)=5;
structure2(structure2==2)=6;
structure2(structure2==3)=7;
structure2(structure2==4)=8;

menu_names2 = arrayfun(@num2str,structure2,'un',0);
menu_names2 = convertCharsToStrings(menu_names2);
menu_names2 = join(menu_names2);

dataset2 = NEW{2,1};
choices2 = [];
for i=1:size(dataset1,1)
choices2 = [choices2, dataset2{i,1}(:,5)];
end

choices2(choices2==1)=5;
choices2(choices2==2)=6;
choices2(choices2==3)=7;
choices2(choices2==4)=8;

choices2 = choices2';

CHOICES = [choices1,choices2];
MENU_NAMES = [menu_names',menu_names2'];

table_choices_paola = array2table(CHOICES,'VariableNames',MENU_NAMES);

