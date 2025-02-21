%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% CREATE VARIABLES USED IN THE MAIN SCRIPTS %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
clc

%% START BY LOADING THE DATA

loading_data

clearvars -except LOGIC UTENTI Logic_test utenti Pachinko_t1 Pachinko_t2 Pachinko_2ndwave


%% COGNITIVE ABILITIES

groups=[];
for i=1:size(LOGIC,1)
    temp = ones(size(LOGIC{i},1),1).*i;
    groups = [groups;temp]; %#ok<*AGROW> 
end

N_subject=[];
for i=1:size(LOGIC,1)
    N_subject = [N_subject; size(unique(LOGIC{i}(:,1)),1)];
end

Logic_test = [groups,Logic_test];

Correct_answers = [1;1;1;3;3;4;0;5]; % may 2022

Logic_test = Logic_test((~isnan(Logic_test(:,4))),:);

n = size(Logic_test,1)/8;

answers = reshape(Logic_test(:,4),[],n);

result=[];
for i=1:size(answers,2)
    temp = answers(:,i)==Correct_answers;
    result = [result,temp];
end

kids_raven = sum(result);
raven_difficulty = sum(result,2);

save stored_variables\kids_raven kids_raven result raven_difficulty


%% GENDER

groups=[];
for i=1:size(UTENTI,1)
    temp = ones(size(UTENTI{i},1),1).*i;
    groups = [groups;temp]; %#ok<*AGROW> 
end

t = ones(size(utenti,1),1);
for i=1:size(utenti,1)
    if isempty(utenti{i,1})==0
        t(i,1)=0;
    end
end

t = find(t==1);
utenti = utenti(t,:);
for i=1:size(utenti,1)
   gender(i,1) = strcmp(utenti{i,8},"F");
end

groups=[];
for i=1:size(UTENTI,1)
    temp = ones((size(UTENTI{i},1)-1),1).*i;
    groups = [groups;temp]; %#ok<*AGROW> 
end

%%% to check groups in Pachinko:

groups_classes = [num2cell(groups),utenti(:,4), utenti(:,5)];

%% CLASS and SCHOOL

for i=1:size(utenti,1)
   class(i,1) = regexp(utenti{i,5},'\d*','match');
   class{i,1} = str2double(class{i,1});
end
class = cell2mat(class);


for i=1:size(utenti,1)
   if strcmp(utenti{i,4},'russo')
    school(i,1) = 1;
   elseif strcmp(utenti{i,4},'trincone')
       school(i,1)=2;
   elseif strcmp(utenti{i,4},'fatale')
       school(i,1)=3;
   elseif strcmp(utenti{i,4},'marconi')
       school(i,1)=4;
   end
end

save stored_variables\gender_class_school gender class school

%% PACHINKO

groups_treatment1 = [9, 11, 14, 17, 19, 24, 32, 33, 34, 38, 39, 44, 56, 57, 58, 59, 62, 63, 65, 10];


T = Logic_test(:,1:2);
T = unique(T,'rows'); % unique id-groups pairs
T = [T,kids_raven',gender];

rav_t1=[];
for i=1:length(groups_treatment1)
    rav_t1 = [rav_t1;T(find(T(:,1)==groups_treatment1(i)),:)];
end

Pachinko_t1 = [rav_t1, Pachinko_t1];

groups_treatment2 = [13, 15, 16, 18, 35, 40, 41, 42, 43, 45, 46, 54, 55, 60, 61, 64];

rav_t2=[];
for i=1:length(groups_treatment2)
    rav_t2 = [rav_t2;T(find(T(:,1)==groups_treatment2(i)),:)]; %#ok<*FNDSB> 
end

Pachinko_t2 = [rav_t2, Pachinko_t2];


% consider only the subjects that pass the control question & did not
% choose 0-8 in the sheep game

Pachinko_t1_star = Pachinko_t1(find(Pachinko_t1(:,9)==1 & Pachinko_t1(:,13)<8),:);
Pachinko_t2_star = Pachinko_t2(find(Pachinko_t2(:,9)==1 & Pachinko_t2(:,13)<8),:);

% merge the treatments and create a table with all the data for analysis in
% STATA

Pachinko_t2(:,end+1:end+3) = nan(size(Pachinko_t2,1),3);
Pachinko = [Pachinko_t1, ones(size(Pachinko_t1,1),1);
            Pachinko_t2, zeros(size(Pachinko_t2,1),1)];

%% PACHINKO 2ND WAVE

groups_pachinko2ndwave = [9,10,11,13,14,15,16,17,18,19,24,32,33,34,35,38,39,40,41,42,43,44,45,46,54,55,56,57,58,59,60,61,62,63,64,65];

temp_pachinko_2ndwave=[];
for i=1:length(groups_pachinko2ndwave)
    temp_pachinko_2ndwave = [temp_pachinko_2ndwave;T(find(T(:,1)==groups_pachinko2ndwave(i)),:)];
end


temp_groupsPachinko = unique(Pachinko(:,1),'stable');


temp_pachinko=[];
for i=1:length(temp_groupsPachinko)
    if ismember(temp_groupsPachinko(i),groups_pachinko2ndwave)
        temp_pachinko = [temp_pachinko;Pachinko_2ndwave(find(temp_pachinko_2ndwave(:,1)==temp_groupsPachinko(i)),3:13)];
    else
        temp_pachinko = [temp_pachinko;NaN(sum(Pachinko(:,1)==temp_groupsPachinko(i)),11)];
    end
end

Pachinko = [Pachinko,temp_pachinko];

save stored_variables\dataset_Pachinko Pachinko groups_treatment1 groups_treatment2 groups_pachinko2ndwave

