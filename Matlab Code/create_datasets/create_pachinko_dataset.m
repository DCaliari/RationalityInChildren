%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% CREATE THE DATASET FOR THE COIN-DROP TASK %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

group = Pachinko(:,1);
id = Pachinko(:,2);
raven = Pachinko(:,3);
c1 = Pachinko(:,7);
c2 = Pachinko(:,8);
c3 = Pachinko(:,9);
threes_twos = Pachinko(:,10).*Pachinko(:,11).*Pachinko(:,18)+Pachinko(:,10).*(~Pachinko(:,18));
threes_ones = Pachinko(:,10).*Pachinko(:,12).*Pachinko(:,18)+Pachinko(:,11).*(~Pachinko(:,18));
twos_ones = Pachinko(:,11).*Pachinko(:,12).*Pachinko(:,18)+Pachinko(:,12).*(~Pachinko(:,18));
ra = Pachinko(:,13);
esito = Pachinko(:,14);
treatment = Pachinko(:,18);
ok_control = Pachinko(:,9).*(Pachinko(:,13)<8 & Pachinko(:,13)>0);
class = Pachinko(:,6);
gender = Pachinko(:,4);

ind1_2w = Pachinko(:,19); %2w means second wave
ind2_2w = Pachinko(:,20);
ind3_2w = Pachinko(:,21);

corr1_2w = Pachinko(:,27); %2w means second wave
corr2_2w = Pachinko(:,28);
corr3_2w = Pachinko(:,29);

ra_2w = Pachinko(:,25);

ok_control_2w = (Pachinko(:,25)<8 & Pachinko(:,25)>0).*(sum(Pachinko(:,22:24),2)==2);

DATA_pachinko = table(group, id, raven, gender, c1, c2, c3, threes_twos, threes_ones, twos_ones, ra, treatment, ok_control, class, ind1_2w, ...
    ind2_2w, ind3_2w, corr1_2w, corr2_2w, corr3_2w, ra_2w, ok_control_2w);
