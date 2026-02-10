%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% CREATE A DATASET WITH VIOLATIONS OF WARP %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This is useful for quickly accessing the proportion of rational and
% irrational children.

%% loading data

create_choice_dataset

%% Loop in the two treatments

for s=1:2
    if s==1 
        DATASET_MAIN = DATASET1;
    else
        DATASET_MAIN = DATASET2;
        DATASET_MAIN(DATASET_MAIN==5)=1;
    DATASET_MAIN(DATASET_MAIN==6)=2;
    DATASET_MAIN(DATASET_MAIN==7)=3;
    DATASET_MAIN(DATASET_MAIN==8)=4;
    end

DATASET_MAIN_I = cell(n,1);
for i=1:n
    DATASET_MAIN_I{i,1} = DATASET_MAIN(1+11*(i-1):11*i,2:6); 
end

%% COUNTING REVEALED PREFERENCES

CRP = crp(DATASET_MAIN_I,n); % use the function "crp" to create the revealed preference matrices

if s==1
    CRP1 = CRP;
    DATASET_MAIN_I1 = DATASET_MAIN_I;
else
    CRP2 = CRP;
    DATASET_MAIN_I2 = DATASET_MAIN_I;
end
end

DATASET_MAIN_I = [DATASET_MAIN_I1,DATASET_MAIN_I2];

%% WARP VIOLATIONS

WARP1 = zeros(n,1);
WARP2 = zeros(n,1);
for i=1:n
    WARP1(i,1)=sum(sum(CRP1{i,1}.*(CRP1{i,1})'))/2;
    WARP2(i,1)=sum(sum(CRP2{i,1}.*(CRP2{i,1})'))/2;
end


group = [];
id_sp = [];
for i=1:size(NUMBERS,1)
    group = [group; ones(Nsub_group(i,1),1)*i];
    id_sp = [id_sp;unique(NUMBERS{i,1}(:,2))];
end

dataset_WARP = [WARP1, WARP2, id_sp ,group]; 

% save stored_variables/dataset_WARP dataset_WARP CRP1 CRP2 DATASET_MAIN_I