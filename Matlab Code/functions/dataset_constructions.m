%% create the dataset for GAMMA MODEL ESTIMATION

% THE NEEDED VARIABLE IS "DATASET"

function [C,C1,DATASET234_A,DATASET234_B,choice_234_A,choice_234_B] = dataset_constructions(DATASET,n)

d = find(sum((DATASET>0),2)==6);
DATASET_FOUR = DATASET(d,:);

id_four = reshape(repmat(1:1:n,12,1),[],1);
id_rep = reshape(repmat(1:1:3,4,n),[],1);

m = DATASET_FOUR(:,2:5);
menus_four = reshape(m',[],1);

choice = zeros(size(DATASET_FOUR,1),4);
for i=1:size(DATASET_FOUR,1)
    for j=1:4
    if m(i,j)==DATASET_FOUR(i,6)
        choice(i,j) = 1;
    end
    end
end
choice = reshape(choice',[],1);

DATA = [id_four,id_rep,menus_four,choice];

% order the data
DATA4 = [];
for i=1:n
temp = sortrows(DATA(1+12*(i-1):12*i,:),3);
DATA4 = [DATA4;temp];
end

%% create the dataset for the 2-3-4 experiment

MENUS = DATASET(:,2:5);
e = find(sum(MENUS,2)<11);
f = find(sum(MENUS,2)>10 & sum(MENUS,2)<40);
DATASET_234_A = DATASET(e,:); % this is the pencil dataset
DATASET_234_B = DATASET(f,:); % this is the pen dataset
MENUS_234_A = MENUS(e,:); % pencil's menus
MENUS_234_B = MENUS(f,:); % pen's menus
MENUS_234_A = sort(MENUS_234_A,2);
MENUS_234_B = sort(MENUS_234_B,2);

structure = [
    0,0,1,2;
    0,0,1,3;
    0,0,1,4;
    0,0,2,3;
    0,0,2,4;
    0,0,3,4;
    0,1,2,3;
    0,1,2,4;
    0,1,3,4;
    0,2,3,4;
    1,2,3,4];
structure1 = [
    0,0,5,6;
    0,0,5,7;
    0,0,5,8;
    0,0,6,7;
    0,0,6,8;
    0,0,7,8;
    0,5,6,7;
    0,5,6,8;
    0,5,7,8;
    0,6,7,8;
    5,6,7,8];


temp=[];
temp1=[];
for i=1:size(MENUS_234_A,1)
    for j=1:size(structure,1)
    temp(j,1) = (isequal(MENUS_234_A(i,:),structure(j,:)));
    temp1(j,1) = (isequal(MENUS_234_B(i,:),structure1(j,:)));
    end
    t(i,1) = find(temp==1);
    t1(i,1) = find(temp1==1);
end

STRUCTURE = repmat(structure,n,1);
STRUCTURE1 = repmat(structure1,n,1);
temp_choice_234_A = DATASET_234_A(:,6);
temp_choice_234_B = DATASET_234_B(:,6);

t = reshape(t,11,n);
t1 = reshape(t1,11,n);
temp_choice_234_A = reshape(temp_choice_234_A,11,n);
temp_choice_234_B = reshape(temp_choice_234_B,11,n);


temp=[];
temp1=[];
for i=1:n
    for j=1:11
        temp = find(t(:,i)==j);
        temp1 = find(t1(:,i)==j);
        choice_234_A(j,i) = temp_choice_234_A(temp,i);
        choice_234_B(j,i) = temp_choice_234_B(temp1,i);
    end
end

choice_234_A = reshape(choice_234_A,[],1);
choice_234_B = reshape(choice_234_B,[],1);

DATA234_A = [STRUCTURE,choice_234_A];
DATA234_B = [STRUCTURE1,choice_234_B];

temp=[];
temp1=[];
tc=[];
tc1=[];
for i=1:size(DATA234_A,1)
    temp = DATA234_A(i,1:4)==DATA234_A(i,5);
    temp1 = DATA234_B(i,1:4)==DATA234_B(i,5);
    tc = [tc;temp];
    tc1 = [tc1;temp1];
end

temp = STRUCTURE;
temp1 = STRUCTURE1;
temp(temp==0)=99;
temp(temp~=99)=0;
temp1(temp1==0)=99;
temp1(temp1~=99)=0;

tc = tc+temp;
tc1 = tc1+temp1;
tc = reshape(tc',[],1);
tc(tc==99)=[];
tc1 = reshape(tc1',[],1);
tc1(tc1==99)=[];
STRUCTURE = reshape(STRUCTURE',[],1);
STRUCTURE(STRUCTURE==0)=[];
STRUCTURE1 = reshape(STRUCTURE1',[],1);
STRUCTURE1(STRUCTURE1==0)=[];

id_rep234 = [1,1,2,2,3,3,4,4,5,5,6,6,7,7,7,8,8,8,9,9,9,10,10,10,11,11,11,11];
id_rep234 = repmat(id_rep234',n,1);

id_234 = reshape(repmat(1:1:n,28,1),[],1);

DATASET234_A = [id_234, id_rep234, STRUCTURE, tc];
DATASET234_B = [id_234, id_rep234, STRUCTURE1, tc1];

C = reshape(DATASET234_A(:,4),28,[])';
C1 = reshape(DATASET234_B(:,4),28,[])';

end
