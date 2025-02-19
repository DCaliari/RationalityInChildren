%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% CREATE A UNIFIED DATASET WITH THE PENCILS/PENS AND THE COIN-DROP TASK FOR THE ANALYSIS IN STATA %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc

loading_data_slider

clearvars -except SLIDER Slider_pencils Slider_pens Slider

load dataset_WARP
load kids_raven
load gender_class_school
load dataset_Pachinko
load demos
load WARP

DATASET = [dataset_WARP(:,4), dataset_WARP(:,3), dataset_WARP(:,1:2), gender, school, class, kids_raven', result', cen1, cen2];

create_pachinko_dataset

pachinko_tr = [groups_treatment1, groups_treatment2];

pachinko_data = [group,id,c1,c2,c3,threes_twos,threes_ones,twos_ones,ra,esito,treatment,ok_control, ind1_2w, ind2_2w, ind3_2w, corr1_2w, ...
    corr2_2w, corr3_2w, ra_2w, ok_control_2w];

temp_data = [];

for i=1:size(DATASET,1)
    if ismember(DATASET(i,1),pachinko_data(:,1))==0
       temp_data(i,:) = [DATASET(i,:),NaN(1,18)];
    else
        for j=1:size(pachinko_data,1)
            if isequal(pachinko_data(j,1:2),DATASET(i,1:2))
            temp_data(i,:) = [DATASET(i,:), pachinko_data(j,3:end)];
            end
        end
    end
end

min_slider_pencils = min(Slider_pencils(:,7:10),[],2);
max_slider_pencils = max(Slider_pencils(:,7:10),[],2);
cv_slider_pencils = std(Slider_pencils(:,7:10),[],2)./mean(Slider_pencils(:,7:10),2);
range_slider_pencils = range(Slider_pencils(:,7:10),2);

min_slider_pens = min(Slider_pens(:,7:10),[],2);
max_slider_pens = max(Slider_pens(:,7:10),[],2);
cv_slider_pens = std(Slider_pens(:,7:10),[],2)./mean(Slider_pens(:,7:10),2);
range_slider_pens = range(Slider_pens(:,7:10),2);

sliders =[Slider_pencils, Slider_pens(:,3:end), min_slider_pencils, max_slider_pencils, cv_slider_pencils, range_slider_pencils, min_slider_pens, max_slider_pens, cv_slider_pens, range_slider_pens];

temp_data = [temp_data, sliders];

DATA = array2table(temp_data,'VariableNames',{'group','id_spec','WARP1','WARP2','gender','school','class','raven',...
    'raven1','raven2','raven3','raven4','raven5','raven6','raven7','raven8','cen1_1','cen1_2','cen1_3','cen1_4',...
    'cen2_1','cen2_2','cen2_3','cen2_4','c1','c2','c3','threes_twos','threes_ones','twos_ones','ra','esito','treatment','ok_control', ...
    'ind1_2w', 'ind2_2w', 'ind3_2w', 'corr1_2w', 'corr2_2w', 'corr3_2w', 'ra_2w', 'ok_control_2w',...
    'group*', 'id*','Yellow Pencil','Red Pencil', 'Orange Pencil', 'Blue Pencil', 'Vote Yellow Pencil','Vote Red Pencil', 'Vote Orange Pencil', 'Vote Blue Pencil', ...
            'Yellow Pen','Red Pen', 'Blue Pen', 'Green Pen', 'Vote Yellow Pen','Vote Red Pen', 'Vote Blue Pen', 'Vote Green Pen', 'min_slider_pencils', 'max_slider_pencils', 'cv_slider_pencils', 'range_slider_pencils',...
                'min_slider_pens', 'max_slider_pens', 'cv_slider_pens', 'range_slider_pens'});


CHOICES = readtable('stored_datasets\choices_paola.csv');

DEMOS = table(age_child, age_mother, age_father, school_mother, school_father, 'VariableNames',...
    {'age_child', 'age_mother','age_father','school_mother', 'school_father'});

DATA = [DATA, DEMOS, CHOICES];


writetable(DATA,'stored_datasets/unified_data.csv')
