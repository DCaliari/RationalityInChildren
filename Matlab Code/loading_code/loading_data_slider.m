%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LOADING THE DATA - STATED PREFERENCES FOR THE PENCILS/PENS CHOICE TASK %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[vote1_1D_gruppo1_russo_1805, ~, ~] = xlsread('1D_gruppo1_russo.xlsx','Slider1'); %#ok<*XLSRD> 
vote1_1D_gruppo1_russo_1805 = vote1_1D_gruppo1_russo_1805(:,[2, 11, 14:21]);
vote1_1D_gruppo1_russo_1805 = vote1_1D_gruppo1_russo_1805(~isnan(vote1_1D_gruppo1_russo_1805(:,3)),:);
[vote2_1D_gruppo1_russo_1805, ~, ~] = xlsread('1D_gruppo1_russo.xlsx','Slider2');
vote2_1D_gruppo1_russo_1805 = vote2_1D_gruppo1_russo_1805(:,[2, 11, 14:21]);
vote2_1D_gruppo1_russo_1805 = vote2_1D_gruppo1_russo_1805(~isnan(vote2_1D_gruppo1_russo_1805(:,3)),:);

[vote1_1D_gruppo2_russo_1805, ~, ~] = xlsread('1D_gruppo2_russo.xlsx','Slider1');
vote1_1D_gruppo2_russo_1805 = vote1_1D_gruppo2_russo_1805(:,[2, 11, 14:21]);
vote1_1D_gruppo2_russo_1805 = vote1_1D_gruppo2_russo_1805(~isnan(vote1_1D_gruppo2_russo_1805(:,3)),:);
vote1_1D_gruppo2_russo_1805(1,:) = [];
[vote2_1D_gruppo2_russo_1805, ~, ~] = xlsread('1D_gruppo2_russo.xlsx','Slider2');
vote2_1D_gruppo2_russo_1805 = vote2_1D_gruppo2_russo_1805(:,[2, 11, 14:21]);
vote2_1D_gruppo2_russo_1805 = vote2_1D_gruppo2_russo_1805(~isnan(vote2_1D_gruppo2_russo_1805(:,3)),:);
vote2_1D_gruppo2_russo_1805(1,:) = [];

[vote1_1E_russo_1805, ~, ~] = xlsread('1E_gruppo1_russo.xlsx','Slider1');
vote1_1E_russo_1805 = vote1_1E_russo_1805(:,[2, 11, 14:21]);
vote1_1E_russo_1805 = vote1_1E_russo_1805(~isnan(vote1_1E_russo_1805(:,3)),:);
vote1_1E_russo_1805(3,:)=[];
[vote2_1E_russo_1805, ~, ~] = xlsread('1E_gruppo1_russo.xlsx','Slider2');
vote2_1E_russo_1805 = vote2_1E_russo_1805(:,[2, 11, 14:21]);
vote2_1E_russo_1805 = vote2_1E_russo_1805(~isnan(vote2_1E_russo_1805(:,3)),:);
vote2_1E_russo_1805(3,:)=[];

[vote1_1A_gruppo1_russo_1905, ~, ~] = xlsread('1A_gruppo1_russo.xlsx','Slider1');
vote1_1A_gruppo1_russo_1905 = vote1_1A_gruppo1_russo_1905(:,[2, 11, 14:21]);
vote1_1A_gruppo1_russo_1905 = vote1_1A_gruppo1_russo_1905(~isnan(vote1_1A_gruppo1_russo_1905(:,3)),:);
[vote2_1A_gruppo1_russo_1905, ~, ~] = xlsread('1A_gruppo1_russo.xlsx','Slider2');
vote2_1A_gruppo1_russo_1905 = vote2_1A_gruppo1_russo_1905(:,[2, 11, 14:21]);
vote2_1A_gruppo1_russo_1905 = vote2_1A_gruppo1_russo_1905(~isnan(vote2_1A_gruppo1_russo_1905(:,3)),:);

[vote1_1A_gruppo2_russo_1905, ~, ~] = xlsread('1A_gruppo2_russo.xlsx','Slider1');
vote1_1A_gruppo2_russo_1905 = vote1_1A_gruppo2_russo_1905(:,[2, 11, 14:21]);
vote1_1A_gruppo2_russo_1905 = vote1_1A_gruppo2_russo_1905(~isnan(vote1_1A_gruppo2_russo_1905(:,3)),:);
[vote2_1A_gruppo2_russo_1905, ~, ~] = xlsread('1A_gruppo2_russo.xlsx','Slider2');
vote2_1A_gruppo2_russo_1905 = vote2_1A_gruppo2_russo_1905(:,[2, 11, 14:21]);
vote2_1A_gruppo2_russo_1905 = vote2_1A_gruppo2_russo_1905(~isnan(vote2_1A_gruppo2_russo_1905(:,3)),:);

[vote1_3C_russo_1905, ~, ~] = xlsread('3C_gruppo1_russo.xlsx','Slider1');
vote1_3C_russo_1905 = vote1_3C_russo_1905(:,[2, 11, 14:21]);
vote1_3C_russo_1905 = vote1_3C_russo_1905(~isnan(vote1_3C_russo_1905(:,3)),:);
[vote2_3C_russo_1905, ~, ~] = xlsread('3C_gruppo1_russo.xlsx','Slider2');
vote2_3C_russo_1905 = vote2_3C_russo_1905(:,[2, 11, 14:21]);
vote2_3C_russo_1905 = vote2_3C_russo_1905(~isnan(vote2_3C_russo_1905(:,3)),:);

[vote1_Assenti_1E_1D_russo_1905, ~, ~] = xlsread('Assenti_1E_1D_russo.xlsx','Slider1');
vote1_Assenti_1E_1D_russo_1905 = vote1_Assenti_1E_1D_russo_1905(:,[2, 11, 14:21]);
vote1_Assenti_1E_1D_russo_1905 = vote1_Assenti_1E_1D_russo_1905(~isnan(vote1_Assenti_1E_1D_russo_1905(:,3)),:);
[vote2_Assenti_1E_1D_russo_1905, ~, ~] = xlsread('Assenti_1E_1D_russo.xlsx','Slider2');
vote2_Assenti_1E_1D_russo_1905 = vote2_Assenti_1E_1D_russo_1905(:,[2, 11, 14:21]);
vote2_Assenti_1E_1D_russo_1905 = vote2_Assenti_1E_1D_russo_1905(~isnan(vote2_Assenti_1E_1D_russo_1905(:,3)),:);

[vote1_2A_trincone_1810, ~, ~] = xlsread('2A_trincone.xlsx','Slider1');
vote1_2A_trincone_1810 = vote1_2A_trincone_1810(:,[2, 11, 14:21]);
vote1_2A_trincone_1810 = vote1_2A_trincone_1810(~isnan(vote1_2A_trincone_1810(:,3)),:);
[vote2_2A_trincone_1810, ~, ~] = xlsread('2A_trincone.xlsx','Slider2');
vote2_2A_trincone_1810 = vote2_2A_trincone_1810(:,[2, 11, 14:21]);
vote2_2A_trincone_1810 = vote2_2A_trincone_1810(~isnan(vote2_2A_trincone_1810(:,3)),:);

[vote1_4A_trincone_1810, ~, ~] = xlsread('4A_trincone.xlsx','Slider1');
vote1_4A_trincone_1810 = vote1_4A_trincone_1810(:,[2, 11, 14:21]);
vote1_4A_trincone_1810 = vote1_4A_trincone_1810(~isnan(vote1_4A_trincone_1810(:,3)),:);
[vote2_4A_trincone_1810, ~, ~] = xlsread('4A_trincone.xlsx','Slider2');
vote2_4A_trincone_1810 = vote2_4A_trincone_1810(:,[2, 11, 14:21]);
vote2_4A_trincone_1810 = vote2_4A_trincone_1810(~isnan(vote2_4A_trincone_1810(:,3)),:);

[vote1_4B_trincone_1810, ~, ~] = xlsread('4B_trincone.xlsx','Slider1');
vote1_4B_trincone_1810 = vote1_4B_trincone_1810(:,[2, 11, 14:21]);
vote1_4B_trincone_1810 = vote1_4B_trincone_1810(~isnan(vote1_4B_trincone_1810(:,3)),:);
[vote2_4B_trincone_1810, ~, ~] = xlsread('4B_trincone.xlsx','Slider2');
vote2_4B_trincone_1810 = vote2_4B_trincone_1810(:,[2, 11, 14:21]);
vote2_4B_trincone_1810 = vote2_4B_trincone_1810(~isnan(vote2_4B_trincone_1810(:,3)),:);

[vote1_5A_trincone_1810, ~, ~] = xlsread('5A_trincone.xlsx','Slider1');
vote1_5A_trincone_1810 = vote1_5A_trincone_1810(:,[2, 11, 14:21]);
vote1_5A_trincone_1810 = vote1_5A_trincone_1810(~isnan(vote1_5A_trincone_1810(:,3)),:);
[vote2_5A_trincone_1810, ~, ~] = xlsread('5A_trincone.xlsx','Slider2');
vote2_5A_trincone_1810 = vote2_5A_trincone_1810(:,[2, 11, 14:21]);
vote2_5A_trincone_1810 = vote2_5A_trincone_1810(~isnan(vote2_5A_trincone_1810(:,3)),:);

[vote1_1A_trincone_1910, ~, ~] = xlsread('1A_trincone.xlsx','Slider1');
vote1_1A_trincone_1910 = vote1_1A_trincone_1910(:,[2, 11, 14:21]);
vote1_1A_trincone_1910 = vote1_1A_trincone_1910(~isnan(vote1_1A_trincone_1910(:,3)),:);
[vote2_1A_trincone_1910, ~, ~] = xlsread('1A_trincone.xlsx','Slider2');
vote2_1A_trincone_1910 = vote2_1A_trincone_1910(:,[2, 11, 14:21]);
vote2_1A_trincone_1910 = vote2_1A_trincone_1910(~isnan(vote2_1A_trincone_1910(:,3)),:);

[vote1_3A_fatale_gruppo1_1910, ~, ~] = xlsread('3A_fatale_gruppo1.xlsx','Slider1');
vote1_3A_fatale_gruppo1_1910 = vote1_3A_fatale_gruppo1_1910(:,[2, 11, 14:21]);
vote1_3A_fatale_gruppo1_1910 = vote1_3A_fatale_gruppo1_1910(~isnan(vote1_3A_fatale_gruppo1_1910(:,3)),:);
[vote2_3A_fatale_gruppo1_1910, ~, ~] = xlsread('3A_fatale_gruppo1.xlsx','Slider2');
vote2_3A_fatale_gruppo1_1910 = vote2_3A_fatale_gruppo1_1910(:,[2, 11, 14:21]);
vote2_3A_fatale_gruppo1_1910 = vote2_3A_fatale_gruppo1_1910(~isnan(vote2_3A_fatale_gruppo1_1910(:,3)),:);

[vote1_3A_fatale_gruppo2_1910, ~, ~] = xlsread('3A_fatale_gruppo2.xlsx','Slider1');
vote1_3A_fatale_gruppo2_1910 = vote1_3A_fatale_gruppo2_1910(:,[2, 11, 14:21]);
vote1_3A_fatale_gruppo2_1910 = vote1_3A_fatale_gruppo2_1910(~isnan(vote1_3A_fatale_gruppo2_1910(:,3)),:);
[vote2_3A_fatale_gruppo2_1910, ~, ~] = xlsread('3A_fatale_gruppo2.xlsx','Slider2');
vote2_3A_fatale_gruppo2_1910 = vote2_3A_fatale_gruppo2_1910(:,[2, 11, 14:21]);
vote2_3A_fatale_gruppo2_1910 = vote2_3A_fatale_gruppo2_1910(~isnan(vote2_3A_fatale_gruppo2_1910(:,3)),:);

[vote1_4A_fatale_1910, ~, ~] = xlsread('4A_fatale.xlsx','Slider1');
vote1_4A_fatale_1910 = vote1_4A_fatale_1910(:,[2, 11, 14:21]);
vote1_4A_fatale_1910 = vote1_4A_fatale_1910(~isnan(vote1_4A_fatale_1910(:,3)),:);
[vote2_4A_fatale_1910, ~, ~] = xlsread('4A_fatale.xlsx','Slider2');
vote2_4A_fatale_1910 = vote2_4A_fatale_1910(:,[2, 11, 14:21]);
vote2_4A_fatale_1910 = vote2_4A_fatale_1910(~isnan(vote2_4A_fatale_1910(:,3)),:);

[vote1_5A_fatale_gruppo1_1910, ~, ~] = xlsread('5A_fatale_gruppo1.xlsx','Slider1');
vote1_5A_fatale_gruppo1_1910 = vote1_5A_fatale_gruppo1_1910(:,[2, 11, 14:21]);
vote1_5A_fatale_gruppo1_1910 = vote1_5A_fatale_gruppo1_1910(~isnan(vote1_5A_fatale_gruppo1_1910(:,3)),:);
[vote2_5A_fatale_gruppo1_1910, ~, ~] = xlsread('5A_fatale_gruppo1.xlsx','Slider2');
vote2_5A_fatale_gruppo1_1910 = vote2_5A_fatale_gruppo1_1910(:,[2, 11, 14:21]);
vote2_5A_fatale_gruppo1_1910 = vote2_5A_fatale_gruppo1_1910(~isnan(vote2_5A_fatale_gruppo1_1910(:,3)),:);

[vote1_5A_fatale_gruppo2_1910, ~, ~] = xlsread('5A_fatale_gruppo2.xlsx','Slider1');
vote1_5A_fatale_gruppo2_1910 = vote1_5A_fatale_gruppo2_1910(:,[2, 11, 14:21]);
vote1_5A_fatale_gruppo2_1910 = vote1_5A_fatale_gruppo2_1910(~isnan(vote1_5A_fatale_gruppo2_1910(:,3)),:);
[vote2_5A_fatale_gruppo2_1910, ~, ~] = xlsread('5A_fatale_gruppo2.xlsx','Slider2');
vote2_5A_fatale_gruppo2_1910 = vote2_5A_fatale_gruppo2_1910(:,[2, 11, 14:21]);
vote2_5A_fatale_gruppo2_1910 = vote2_5A_fatale_gruppo2_1910(~isnan(vote2_5A_fatale_gruppo2_1910(:,3)),:);

[vote1_5B_fatale_1910, ~, ~] = xlsread('5B_fatale.xlsx','Slider1');
vote1_5B_fatale_1910 = vote1_5B_fatale_1910(:,[2, 11, 14:21]);
vote1_5B_fatale_1910 = vote1_5B_fatale_1910(~isnan(vote1_5B_fatale_1910(:,3)),:);
[vote2_5B_fatale_1910, ~, ~] = xlsread('5B_fatale.xlsx','Slider2');
vote2_5B_fatale_1910 = vote2_5B_fatale_1910(:,[2, 11, 14:21]);
vote2_5B_fatale_1910 = vote2_5B_fatale_1910(~isnan(vote2_5B_fatale_1910(:,3)),:);

[vote1_1A_fatale_2010, ~, ~] = xlsread('1A_fatale.xlsx','Slider1');
vote1_1A_fatale_2010 = vote1_1A_fatale_2010(:,[2, 11, 14:21]);
vote1_1A_fatale_2010 = vote1_1A_fatale_2010(~isnan(vote1_1A_fatale_2010(:,3)),:);
[vote2_1A_fatale_2010, ~, ~] = xlsread('1A_fatale.xlsx','Slider2');
vote2_1A_fatale_2010 = vote2_1A_fatale_2010(:,[2, 11, 14:21]);
vote2_1A_fatale_2010 = vote2_1A_fatale_2010(~isnan(vote2_1A_fatale_2010(:,3)),:);

[vote1_1B_fatale_2010, ~, ~] = xlsread('1B_fatale.xlsx','Slider1');
vote1_1B_fatale_2010 = vote1_1B_fatale_2010(:,[2, 11, 14:21]);
vote1_1B_fatale_2010 = vote1_1B_fatale_2010(~isnan(vote1_1B_fatale_2010(:,3)),:);
[vote2_1B_fatale_2010, ~, ~] = xlsread('1B_fatale.xlsx','Slider2');
vote2_1B_fatale_2010 = vote2_1B_fatale_2010(:,[2, 11, 14:21]);
vote2_1B_fatale_2010 = vote2_1B_fatale_2010(~isnan(vote2_1B_fatale_2010(:,3)),:);

[vote1_2A_fatale_2010, ~, ~] = xlsread('2A_fatale.xlsx','Slider1');
vote1_2A_fatale_2010 = vote1_2A_fatale_2010(:,[2, 11, 14:21]);
vote1_2A_fatale_2010 = vote1_2A_fatale_2010(~isnan(vote1_2A_fatale_2010(:,3)),:);
vote1_2A_fatale_2010(vote1_2A_fatale_2010(:,1)==2,:)=[];
[vote2_2A_fatale_2010, ~, ~] = xlsread('2A_fatale.xlsx','Slider2');
vote2_2A_fatale_2010 = vote2_2A_fatale_2010(:,[2, 11, 14:21]);
vote2_2A_fatale_2010 = vote2_2A_fatale_2010(~isnan(vote2_2A_fatale_2010(:,3)),:);
vote2_2A_fatale_2010(vote2_2A_fatale_2010(:,1)==2,:)=[];

[vote1_2B_fatale_2010, ~, ~] = xlsread('2B_fatale.xlsx','Slider1');
vote1_2B_fatale_2010 = vote1_2B_fatale_2010(:,[2, 11, 14:21]);
vote1_2B_fatale_2010 = vote1_2B_fatale_2010(~isnan(vote1_2B_fatale_2010(:,3)),:);
[vote2_2B_fatale_2010, ~, ~] = xlsread('2B_fatale.xlsx','Slider2');
vote2_2B_fatale_2010 = vote2_2B_fatale_2010(:,[2, 11, 14:21]);
vote2_2B_fatale_2010 = vote2_2B_fatale_2010(~isnan(vote2_2B_fatale_2010(:,3)),:);

[vote1_4B_fatale_2010, ~, ~] = xlsread('4B_fatale.xlsx','Slider1');
vote1_4B_fatale_2010 = vote1_4B_fatale_2010(:,[2, 11, 14:21]);
vote1_4B_fatale_2010 = vote1_4B_fatale_2010(~isnan(vote1_4B_fatale_2010(:,3)),:);
[vote2_4B_fatale_2010, ~, ~] = xlsread('4B_fatale.xlsx','Slider2');
vote2_4B_fatale_2010 = vote2_4B_fatale_2010(:,[2, 11, 14:21]);
vote2_4B_fatale_2010 = vote2_4B_fatale_2010(~isnan(vote2_4B_fatale_2010(:,3)),:);

[vote1_1A_marconi_gruppo1_2110, ~, ~] = xlsread('1A_marconi_gruppo1.xlsx','Slider1');
vote1_1A_marconi_gruppo1_2110 = vote1_1A_marconi_gruppo1_2110(:,[2, 11, 14:21]);
vote1_1A_marconi_gruppo1_2110 = vote1_1A_marconi_gruppo1_2110(~isnan(vote1_1A_marconi_gruppo1_2110(:,3)),:);
[vote2_1A_marconi_gruppo1_2110, ~, ~] = xlsread('1A_marconi_gruppo1.xlsx','Slider2');
vote2_1A_marconi_gruppo1_2110 = vote2_1A_marconi_gruppo1_2110(:,[2, 11, 14:21]);
vote2_1A_marconi_gruppo1_2110 = vote2_1A_marconi_gruppo1_2110(~isnan(vote2_1A_marconi_gruppo1_2110(:,3)),:);

[vote1_1A_marconi_gruppo2_2110, ~, ~] = xlsread('1A_marconi_gruppo2.xlsx','Slider1');
vote1_1A_marconi_gruppo2_2110 = vote1_1A_marconi_gruppo2_2110(:,[2, 11, 14:21]);
vote1_1A_marconi_gruppo2_2110 = vote1_1A_marconi_gruppo2_2110(~isnan(vote1_1A_marconi_gruppo2_2110(:,3)),:);
[vote2_1A_marconi_gruppo2_2110, ~, ~] = xlsread('1A_marconi_gruppo2.xlsx','Slider2');
vote2_1A_marconi_gruppo2_2110 = vote2_1A_marconi_gruppo2_2110(:,[2, 11, 14:21]);
vote2_1A_marconi_gruppo2_2110 = vote2_1A_marconi_gruppo2_2110(~isnan(vote2_1A_marconi_gruppo2_2110(:,3)),:);

[vote1_1B_marconi_gruppo1_2110, ~, ~] = xlsread('1B_marconi_gruppo1.xlsx','Slider1');
vote1_1B_marconi_gruppo1_2110 = vote1_1B_marconi_gruppo1_2110(:,[2, 11, 14:21]);
vote1_1B_marconi_gruppo1_2110 = vote1_1B_marconi_gruppo1_2110(~isnan(vote1_1B_marconi_gruppo1_2110(:,3)),:);
[vote2_1B_marconi_gruppo1_2110, ~, ~] = xlsread('1B_marconi_gruppo1.xlsx','Slider2');
vote2_1B_marconi_gruppo1_2110 = vote2_1B_marconi_gruppo1_2110(:,[2, 11, 14:21]);
vote2_1B_marconi_gruppo1_2110 = vote2_1B_marconi_gruppo1_2110(~isnan(vote2_1B_marconi_gruppo1_2110(:,3)),:);

[vote1_1B_marconi_gruppo2_2110, ~, ~] = xlsread('1B_marconi_gruppo2.xlsx','Slider1');
vote1_1B_marconi_gruppo2_2110 = vote1_1B_marconi_gruppo2_2110(:,[2, 11, 14:21]);
vote1_1B_marconi_gruppo2_2110 = vote1_1B_marconi_gruppo2_2110(~isnan(vote1_1B_marconi_gruppo2_2110(:,3)),:);
[vote2_1B_marconi_gruppo2_2110, ~, ~] = xlsread('1B_marconi_gruppo2.xlsx','Slider2');
vote2_1B_marconi_gruppo2_2110 = vote2_1B_marconi_gruppo2_2110(:,[2, 11, 14:21]);
vote2_1B_marconi_gruppo2_2110 = vote2_1B_marconi_gruppo2_2110(~isnan(vote2_1B_marconi_gruppo2_2110(:,3)),:);

[vote1_2B_marconi_2110, ~, ~] = xlsread('2B_marconi.xlsx','Slider1');
vote1_2B_marconi_2110 = vote1_2B_marconi_2110(:,[2, 11, 14:21]);
vote1_2B_marconi_2110 = vote1_2B_marconi_2110(~isnan(vote1_2B_marconi_2110(:,3)),:);
[vote2_2B_marconi_2110, ~, ~] = xlsread('2B_marconi.xlsx','Slider2');
vote2_2B_marconi_2110 = vote2_2B_marconi_2110(:,[2, 11, 14:21]);
vote2_2B_marconi_2110 = vote2_2B_marconi_2110(~isnan(vote2_2B_marconi_2110(:,3)),:);

[vote1_4A_marconi_2110, ~, ~] = xlsread('4A_marconi.xlsx','Slider1');
vote1_4A_marconi_2110 = vote1_4A_marconi_2110(:,[2, 11, 14:21]);
vote1_4A_marconi_2110 = vote1_4A_marconi_2110(~isnan(vote1_4A_marconi_2110(:,3)),:);
[vote2_4A_marconi_2110, ~, ~] = xlsread('4A_marconi.xlsx','Slider2');
vote2_4A_marconi_2110 = vote2_4A_marconi_2110(:,[2, 11, 14:21]);
vote2_4A_marconi_2110 = vote2_4A_marconi_2110(~isnan(vote2_4A_marconi_2110(:,3)),:);

[vote1_2C_marconi_gruppo1_2410, ~, ~] = xlsread('2C_marconi_gruppo1.xlsx','Slider1');
vote1_2C_marconi_gruppo1_2410 = vote1_2C_marconi_gruppo1_2410(:,[2, 11, 14:21]);
vote1_2C_marconi_gruppo1_2410 = vote1_2C_marconi_gruppo1_2410(~isnan(vote1_2C_marconi_gruppo1_2410(:,3)),:);
[vote2_2C_marconi_gruppo1_2410, ~, ~] = xlsread('2C_marconi_gruppo1.xlsx','Slider2');
vote2_2C_marconi_gruppo1_2410 = vote2_2C_marconi_gruppo1_2410(:,[2, 11, 14:21]);
vote2_2C_marconi_gruppo1_2410 = vote2_2C_marconi_gruppo1_2410(~isnan(vote2_2C_marconi_gruppo1_2410(:,3)),:);

[vote1_2C_marconi_gruppo2_2410, ~, ~] = xlsread('2C_marconi_gruppo2.xlsx','Slider1');
vote1_2C_marconi_gruppo2_2410 = vote1_2C_marconi_gruppo2_2410(:,[2, 11, 14:21]);
vote1_2C_marconi_gruppo2_2410 = vote1_2C_marconi_gruppo2_2410(~isnan(vote1_2C_marconi_gruppo2_2410(:,3)),:);
[vote2_2C_marconi_gruppo2_2410, ~, ~] = xlsread('2C_marconi_gruppo2.xlsx','Slider2');
vote2_2C_marconi_gruppo2_2410 = vote2_2C_marconi_gruppo2_2410(:,[2, 11, 14:21]);
vote2_2C_marconi_gruppo2_2410 = vote2_2C_marconi_gruppo2_2410(~isnan(vote2_2C_marconi_gruppo2_2410(:,3)),:);

[vote1_3A_marconi_gruppo1_2410, ~, ~] = xlsread('3A_marconi_gruppo1.xlsx','Slider1');
vote1_3A_marconi_gruppo1_2410 = vote1_3A_marconi_gruppo1_2410(:,[2, 11, 14:21]);
vote1_3A_marconi_gruppo1_2410 = vote1_3A_marconi_gruppo1_2410(~isnan(vote1_3A_marconi_gruppo1_2410(:,3)),:);
[vote2_3A_marconi_gruppo1_2410, ~, ~] = xlsread('3A_marconi_gruppo1.xlsx','Slider2');
vote2_3A_marconi_gruppo1_2410 = vote2_3A_marconi_gruppo1_2410(:,[2, 11, 14:21]);
vote2_3A_marconi_gruppo1_2410 = vote2_3A_marconi_gruppo1_2410(~isnan(vote2_3A_marconi_gruppo1_2410(:,3)),:);

[vote1_3A_marconi_gruppo2_2410, ~, ~] = xlsread('3A_marconi_gruppo2.xlsx','Slider1');
vote1_3A_marconi_gruppo2_2410 = vote1_3A_marconi_gruppo2_2410(:,[2, 11, 14:21]);
vote1_3A_marconi_gruppo2_2410 = vote1_3A_marconi_gruppo2_2410(~isnan(vote1_3A_marconi_gruppo2_2410(:,3)),:);
[vote2_3A_marconi_gruppo2_2410, ~, ~] = xlsread('3A_marconi_gruppo2.xlsx','Slider2');
vote2_3A_marconi_gruppo2_2410 = vote2_3A_marconi_gruppo2_2410(:,[2, 11, 14:21]);
vote2_3A_marconi_gruppo2_2410 = vote2_3A_marconi_gruppo2_2410(~isnan(vote2_3A_marconi_gruppo2_2410(:,3)),:);

[vote1_3B_marconi_2410, ~, ~] = xlsread('3B_marconi.xlsx','Slider1');
vote1_3B_marconi_2410 = vote1_3B_marconi_2410(:,[2, 11, 14:21]);
vote1_3B_marconi_2410 = vote1_3B_marconi_2410(~isnan(vote1_3B_marconi_2410(:,3)),:);
[vote2_3B_marconi_2410, ~, ~] = xlsread('3B_marconi.xlsx','Slider2');
vote2_3B_marconi_2410 = vote2_3B_marconi_2410(:,[2, 11, 14:21]);
vote2_3B_marconi_2410 = vote2_3B_marconi_2410(~isnan(vote2_3B_marconi_2410(:,3)),:);

[vote1_3C_marconi_2410, ~, ~] = xlsread('3C_marconi.xlsx','Slider1');
vote1_3C_marconi_2410 = vote1_3C_marconi_2410(:,[2, 11, 14:21]);
vote1_3C_marconi_2410 = vote1_3C_marconi_2410(~isnan(vote1_3C_marconi_2410(:,3)),:);
[vote2_3C_marconi_2410, ~, ~] = xlsread('3C_marconi.xlsx','Slider2');
vote2_3C_marconi_2410 = vote2_3C_marconi_2410(:,[2, 11, 14:21]);
vote2_3C_marconi_2410 = vote2_3C_marconi_2410(~isnan(vote2_3C_marconi_2410(:,3)),:);

[vote1_2B_marconi_gruppo1_2510, ~, ~] = xlsread('2B_marconi_gruppo1.xlsx','Slider1');
vote1_2B_marconi_gruppo1_2510 = vote1_2B_marconi_gruppo1_2510(:,[2, 11, 14:21]);
vote1_2B_marconi_gruppo1_2510 = vote1_2B_marconi_gruppo1_2510(~isnan(vote1_2B_marconi_gruppo1_2510(:,3)),:);
[vote2_2B_marconi_gruppo1_2510, ~, ~] = xlsread('2B_marconi_gruppo1.xlsx','Slider2');
vote2_2B_marconi_gruppo1_2510 = vote2_2B_marconi_gruppo1_2510(:,[2, 11, 14:21]);
vote2_2B_marconi_gruppo1_2510 = vote2_2B_marconi_gruppo1_2510(~isnan(vote2_2B_marconi_gruppo1_2510(:,3)),:);

[vote1_2B_marconi_gruppo2_2510, ~, ~] = xlsread('2B_marconi_gruppo2.xlsx','Slider1');
vote1_2B_marconi_gruppo2_2510 = vote1_2B_marconi_gruppo2_2510(:,[2, 11, 14:21]);
vote1_2B_marconi_gruppo2_2510 = vote1_2B_marconi_gruppo2_2510(~isnan(vote1_2B_marconi_gruppo2_2510(:,3)),:);
[vote2_2B_marconi_gruppo2_2510, ~, ~] = xlsread('2B_marconi_gruppo2.xlsx','Slider2');
vote2_2B_marconi_gruppo2_2510 = vote2_2B_marconi_gruppo2_2510(:,[2, 11, 14:21]);
vote2_2B_marconi_gruppo2_2510 = vote2_2B_marconi_gruppo2_2510(~isnan(vote2_2B_marconi_gruppo2_2510(:,3)),:);

[vote1_4B_marconi_gruppo1_2510, ~, ~] = xlsread('4B_marconi_gruppo1.xlsx','Slider1');
vote1_4B_marconi_gruppo1_2510 = vote1_4B_marconi_gruppo1_2510(:,[2, 11, 14:21]);
vote1_4B_marconi_gruppo1_2510 = vote1_4B_marconi_gruppo1_2510(~isnan(vote1_4B_marconi_gruppo1_2510(:,3)),:);
vote1_4B_marconi_gruppo1_2510(vote1_4B_marconi_gruppo1_2510(:,1)==15,:)=[];
[vote2_4B_marconi_gruppo1_2510, ~, ~] = xlsread('4B_marconi_gruppo1.xlsx','Slider2');
vote2_4B_marconi_gruppo1_2510 = vote2_4B_marconi_gruppo1_2510(:,[2, 11, 14:21]);
vote2_4B_marconi_gruppo1_2510 = vote2_4B_marconi_gruppo1_2510(~isnan(vote2_4B_marconi_gruppo1_2510(:,3)),:);
vote2_4B_marconi_gruppo1_2510(vote2_4B_marconi_gruppo1_2510(:,1)==15,:)=[];

[vote1_4B_marconi_gruppo2_2510, ~, ~] = xlsread('4B_marconi_gruppo2.xlsx','Slider1');
vote1_4B_marconi_gruppo2_2510 = vote1_4B_marconi_gruppo2_2510(:,[2, 11, 14:21]);
vote1_4B_marconi_gruppo2_2510 = vote1_4B_marconi_gruppo2_2510(~isnan(vote1_4B_marconi_gruppo2_2510(:,3)),:);
[vote2_4B_marconi_gruppo2_2510, ~, ~] = xlsread('4B_marconi_gruppo2.xlsx','Slider2');
vote2_4B_marconi_gruppo2_2510 = vote2_4B_marconi_gruppo2_2510(:,[2, 11, 14:21]);
vote2_4B_marconi_gruppo2_2510 = vote2_4B_marconi_gruppo2_2510(~isnan(vote2_4B_marconi_gruppo2_2510(:,3)),:);

[vote1_4C_marconi_gruppo1_2510, ~, ~] = xlsread('4C_marconi_gruppo1.xlsx','Slider1');
vote1_4C_marconi_gruppo1_2510 = vote1_4C_marconi_gruppo1_2510(:,[2, 11, 14:21]);
vote1_4C_marconi_gruppo1_2510 = vote1_4C_marconi_gruppo1_2510(~isnan(vote1_4C_marconi_gruppo1_2510(:,3)),:);
[vote2_4C_marconi_gruppo1_2510, ~, ~] = xlsread('4C_marconi_gruppo1.xlsx','Slider2');
vote2_4C_marconi_gruppo1_2510 = vote2_4C_marconi_gruppo1_2510(:,[2, 11, 14:21]);
vote2_4C_marconi_gruppo1_2510 = vote2_4C_marconi_gruppo1_2510(~isnan(vote2_4C_marconi_gruppo1_2510(:,3)),:);

[vote1_4C_marconi_gruppo2_2510, ~, ~] = xlsread('4C_marconi_gruppo2.xlsx','Slider1');
vote1_4C_marconi_gruppo2_2510 = vote1_4C_marconi_gruppo2_2510(:,[2, 11, 14:21]);
vote1_4C_marconi_gruppo2_2510 = vote1_4C_marconi_gruppo2_2510(~isnan(vote1_4C_marconi_gruppo2_2510(:,3)),:);
[vote2_4C_marconi_gruppo2_2510, ~, ~] = xlsread('4C_marconi_gruppo2.xlsx','Slider2');
vote2_4C_marconi_gruppo2_2510 = vote2_4C_marconi_gruppo2_2510(:,[2, 11, 14:21]);
vote2_4C_marconi_gruppo2_2510 = vote2_4C_marconi_gruppo2_2510(~isnan(vote2_4C_marconi_gruppo2_2510(:,3)),:);

[vote1_5A_marconi_gruppo1_2510, ~, ~] = xlsread('5A_marconi_gruppo1.xlsx','Slider1');
vote1_5A_marconi_gruppo1_2510 = vote1_5A_marconi_gruppo1_2510(:,[2, 11, 14:21]);
vote1_5A_marconi_gruppo1_2510 = vote1_5A_marconi_gruppo1_2510(~isnan(vote1_5A_marconi_gruppo1_2510(:,3)),:);
[vote2_5A_marconi_gruppo1_2510, ~, ~] = xlsread('5A_marconi_gruppo1.xlsx','Slider2');
vote2_5A_marconi_gruppo1_2510 = vote2_5A_marconi_gruppo1_2510(:,[2, 11, 14:21]);
vote2_5A_marconi_gruppo1_2510 = vote2_5A_marconi_gruppo1_2510(~isnan(vote2_5A_marconi_gruppo1_2510(:,3)),:);

[vote1_5A_marconi_gruppo2_2510, ~, ~] = xlsread('5A_marconi_gruppo2.xlsx','Slider1');
vote1_5A_marconi_gruppo2_2510 = vote1_5A_marconi_gruppo2_2510(:,[2, 11, 14:21]);
vote1_5A_marconi_gruppo2_2510 = vote1_5A_marconi_gruppo2_2510(~isnan(vote1_5A_marconi_gruppo2_2510(:,3)),:);
[vote2_5A_marconi_gruppo2_2510, ~, ~] = xlsread('5A_marconi_gruppo2.xlsx','Slider2');
vote2_5A_marconi_gruppo2_2510 = vote2_5A_marconi_gruppo2_2510(:,[2, 11, 14:21]);
vote2_5A_marconi_gruppo2_2510 = vote2_5A_marconi_gruppo2_2510(~isnan(vote2_5A_marconi_gruppo2_2510(:,3)),:);

[vote1_5B_marconi_2610, ~, ~] = xlsread('5B_marconi.xlsx','Slider1');
vote1_5B_marconi_2610 = vote1_5B_marconi_2610(:,[2, 11, 14:21]);
vote1_5B_marconi_2610 = vote1_5B_marconi_2610(~isnan(vote1_5B_marconi_2610(:,3)),:);
[vote2_5B_marconi_2610, ~, ~] = xlsread('5B_marconi.xlsx','Slider2');
vote2_5B_marconi_2610 = vote2_5B_marconi_2610(:,[2, 11, 14:21]);
vote2_5B_marconi_2610 = vote2_5B_marconi_2610(~isnan(vote2_5B_marconi_2610(:,3)),:);

[vote1_5C_marconi_gruppo1_2610, ~, ~] = xlsread('5C_marconi_gruppo1.xlsx','Slider1');
vote1_5C_marconi_gruppo1_2610 = vote1_5C_marconi_gruppo1_2610(:,[2, 11, 14:21]);
vote1_5C_marconi_gruppo1_2610 = vote1_5C_marconi_gruppo1_2610(~isnan(vote1_5C_marconi_gruppo1_2610(:,3)),:);
[vote2_5C_marconi_gruppo1_2610, ~, ~] = xlsread('5C_marconi_gruppo1.xlsx','Slider2');
vote2_5C_marconi_gruppo1_2610 = vote2_5C_marconi_gruppo1_2610(:,[2, 11, 14:21]);
vote2_5C_marconi_gruppo1_2610 = vote2_5C_marconi_gruppo1_2610(~isnan(vote2_5C_marconi_gruppo1_2610(:,3)),:);

[vote1_5C_marconi_gruppo2_2610, ~, ~] = xlsread('5C_marconi_gruppo2.xlsx','Slider1');
vote1_5C_marconi_gruppo2_2610 = vote1_5C_marconi_gruppo2_2610(:,[2, 11, 14:21]);
vote1_5C_marconi_gruppo2_2610 = vote1_5C_marconi_gruppo2_2610(~isnan(vote1_5C_marconi_gruppo2_2610(:,3)),:);
[vote2_5C_marconi_gruppo2_2610, ~, ~] = xlsread('5C_marconi_gruppo2.xlsx','Slider2');
vote2_5C_marconi_gruppo2_2610 = vote2_5C_marconi_gruppo2_2610(:,[2, 11, 14:21]);
vote2_5C_marconi_gruppo2_2610 = vote2_5C_marconi_gruppo2_2610(~isnan(vote2_5C_marconi_gruppo2_2610(:,3)),:);

[vote1_1B_russo_1411, ~, ~] = xlsread('1B_russo.xlsx','Slider1');
vote1_1B_russo_1411 = vote1_1B_russo_1411(:,[2, 11, 14:21]);
vote1_1B_russo_1411 = vote1_1B_russo_1411(~isnan(vote1_1B_russo_1411(:,3)),:);
[vote2_1B_russo_1411, ~, ~] = xlsread('1B_russo.xlsx','Slider2');
vote2_1B_russo_1411 = vote2_1B_russo_1411(:,[2, 11, 14:21]);
vote2_1B_russo_1411 = vote2_1B_russo_1411(~isnan(vote2_1B_russo_1411(:,3)),:);

[vote1_1C_russo_gruppo1_1411, ~, ~] = xlsread('1C_russo_gruppo1.xlsx','Slider1');
vote1_1C_russo_gruppo1_1411 = vote1_1C_russo_gruppo1_1411(:,[2, 11, 14:21]);
vote1_1C_russo_gruppo1_1411 = vote1_1C_russo_gruppo1_1411(~isnan(vote1_1C_russo_gruppo1_1411(:,3)),:);
[vote2_1C_russo_gruppo1_1411, ~, ~] = xlsread('1C_russo_gruppo1.xlsx','Slider2');
vote2_1C_russo_gruppo1_1411 = vote2_1C_russo_gruppo1_1411(:,[2, 11, 14:21]);
vote2_1C_russo_gruppo1_1411 = vote2_1C_russo_gruppo1_1411(~isnan(vote2_1C_russo_gruppo1_1411(:,3)),:);

[vote1_1C_russo_gruppo2_1411, ~, ~] = xlsread('1C_russo_gruppo2.xlsx','Slider1');
vote1_1C_russo_gruppo2_1411 = vote1_1C_russo_gruppo2_1411(:,[2, 11, 14:21]);
vote1_1C_russo_gruppo2_1411 = vote1_1C_russo_gruppo2_1411(~isnan(vote1_1C_russo_gruppo2_1411(:,3)),:);
[vote2_1C_russo_gruppo2_1411, ~, ~] = xlsread('1C_russo_gruppo2.xlsx','Slider2');
vote2_1C_russo_gruppo2_1411 = vote2_1C_russo_gruppo2_1411(:,[2, 11, 14:21]);
vote2_1C_russo_gruppo2_1411 = vote2_1C_russo_gruppo2_1411(~isnan(vote2_1C_russo_gruppo2_1411(:,3)),:);

[vote1_1E_russo_1411, ~, ~] = xlsread('1E_russo.xlsx','Slider1');
vote1_1E_russo_1411 = vote1_1E_russo_1411(:,[2, 11, 14:21]);
vote1_1E_russo_1411 = vote1_1E_russo_1411(~isnan(vote1_1E_russo_1411(:,3)),:);
[vote2_1E_russo_1411, ~, ~] = xlsread('1E_russo.xlsx','Slider2');
vote2_1E_russo_1411 = vote2_1E_russo_1411(:,[2, 11, 14:21]);
vote2_1E_russo_1411 = vote2_1E_russo_1411(~isnan(vote2_1E_russo_1411(:,3)),:);

[vote1_1F_russo_1511, ~, ~] = xlsread('1F_russo.xlsx','Slider1');
vote1_1F_russo_1511 = vote1_1F_russo_1511(:,[2, 11, 14:21]);
vote1_1F_russo_1511 = vote1_1F_russo_1511(~isnan(vote1_1F_russo_1511(:,3)),:);
[vote2_1F_russo_1511, ~, ~] = xlsread('1F_russo.xlsx','Slider2');
vote2_1F_russo_1511 = vote2_1F_russo_1511(:,[2, 11, 14:21]);
vote2_1F_russo_1511 = vote2_1F_russo_1511(~isnan(vote2_1F_russo_1511(:,3)),:);

[vote1_2A_russo_1511, ~, ~] = xlsread('2A_russo.xlsx','Slider1');
vote1_2A_russo_1511 = vote1_2A_russo_1511(:,[2, 11, 14:21]);
vote1_2A_russo_1511 = vote1_2A_russo_1511(~isnan(vote1_2A_russo_1511(:,3)),:);
[vote2_2A_russo_1511, ~, ~] = xlsread('2A_russo.xlsx','Slider2');
vote2_2A_russo_1511 = vote2_2A_russo_1511(:,[2, 11, 14:21]);
vote2_2A_russo_1511 = vote2_2A_russo_1511(~isnan(vote2_2A_russo_1511(:,3)),:);

[vote1_2B_russo_1511, ~, ~] = xlsread('2B_russo.xlsx','Slider1');
vote1_2B_russo_1511 = vote1_2B_russo_1511(:,[2, 11, 14:21]);
vote1_2B_russo_1511 = vote1_2B_russo_1511(~isnan(vote1_2B_russo_1511(:,3)),:);
[vote2_2B_russo_1511, ~, ~] = xlsread('2B_russo.xlsx','Slider2');
vote2_2B_russo_1511 = vote2_2B_russo_1511(:,[2, 11, 14:21]);
vote2_2B_russo_1511 = vote2_2B_russo_1511(~isnan(vote2_2B_russo_1511(:,3)),:);

[vote1_3C_russo_1611, ~, ~] = xlsread('3C_russo.xlsx','Slider1');
vote1_3C_russo_1611 = vote1_3C_russo_1611(:,[2, 11, 14:21]);
vote1_3C_russo_1611 = vote1_3C_russo_1611(~isnan(vote1_3C_russo_1611(:,3)),:);
[vote2_3C_russo_1611, ~, ~] = xlsread('3C_russo.xlsx','Slider2');
vote2_3C_russo_1611 = vote2_3C_russo_1611(:,[2, 11, 14:21]);
vote2_3C_russo_1611 = vote2_3C_russo_1611(~isnan(vote2_3C_russo_1611(:,3)),:);

[vote1_4C_russo_1611, ~, ~] = xlsread('4C_russo.xlsx','Slider1');
vote1_4C_russo_1611 = vote1_4C_russo_1611(:,[2, 11, 14:21]);
vote1_4C_russo_1611 = vote1_4C_russo_1611(~isnan(vote1_4C_russo_1611(:,3)),:);
[vote2_4C_russo_1611, ~, ~] = xlsread('4C_russo.xlsx','Slider2');
vote2_4C_russo_1611 = vote2_4C_russo_1611(:,[2, 11, 14:21]);
vote2_4C_russo_1611 = vote2_4C_russo_1611(~isnan(vote2_4C_russo_1611(:,3)),:);

[vote1_4E_russo_1611, ~, ~] = xlsread('4E_russo.xlsx','Slider1');
vote1_4E_russo_1611 = vote1_4E_russo_1611(:,[2, 11, 14:21]);
vote1_4E_russo_1611 = vote1_4E_russo_1611(~isnan(vote1_4E_russo_1611(:,3)),:);
[vote2_4E_russo_1611, ~, ~] = xlsread('4E_russo.xlsx','Slider2');
vote2_4E_russo_1611 = vote2_4E_russo_1611(:,[2, 11, 14:21]);
vote2_4E_russo_1611 = vote2_4E_russo_1611(~isnan(vote2_4E_russo_1611(:,3)),:);

[vote1_4F_russo_1611, ~, ~] = xlsread('4F_russo.xlsx','Slider1');
vote1_4F_russo_1611 = vote1_4F_russo_1611(:,[2, 11, 14:21]);
vote1_4F_russo_1611 = vote1_4F_russo_1611(~isnan(vote1_4F_russo_1611(:,3)),:);
[vote2_4F_russo_1611, ~, ~] = xlsread('4F_russo.xlsx','Slider2');
vote2_4F_russo_1611 = vote2_4F_russo_1611(:,[2, 11, 14:21]);
vote2_4F_russo_1611 = vote2_4F_russo_1611(~isnan(vote2_4F_russo_1611(:,3)),:);

[vote1_4A_russo_1711, ~, ~] = xlsread('4A_russo.xlsx','Slider1');
vote1_4A_russo_1711 = vote1_4A_russo_1711(:,[2, 11, 14:21]);
vote1_4A_russo_1711 = vote1_4A_russo_1711(~isnan(vote1_4A_russo_1711(:,3)),:);
vote1_4A_russo_1711(1,:) = []; % the student did not solve the pachinko
[vote2_4A_russo_1711, ~, ~] = xlsread('4A_russo.xlsx','Slider2');
vote2_4A_russo_1711 = vote2_4A_russo_1711(:,[2, 11, 14:21]);
vote2_4A_russo_1711 = vote2_4A_russo_1711(~isnan(vote2_4A_russo_1711(:,3)),:);
vote2_4A_russo_1711(1,:) = []; % the student did not solve the pachinko

[vote1_5A_russo_1711, ~, ~] = xlsread('5A_russo.xlsx','Slider1');
vote1_5A_russo_1711 = vote1_5A_russo_1711(:,[2, 11, 14:21]);
vote1_5A_russo_1711 = vote1_5A_russo_1711(~isnan(vote1_5A_russo_1711(:,3)),:);
[vote2_5A_russo_1711, ~, ~] = xlsread('5A_russo.xlsx','Slider2');
vote2_5A_russo_1711 = vote2_5A_russo_1711(:,[2, 11, 14:21]);
vote2_5A_russo_1711 = vote2_5A_russo_1711(~isnan(vote2_5A_russo_1711(:,3)),:);

[vote1_5B_russo_1711, ~, ~] = xlsread('5B_russo.xlsx','Slider1');
vote1_5B_russo_1711 = vote1_5B_russo_1711(:,[2, 11, 14:21]);
vote1_5B_russo_1711 = vote1_5B_russo_1711(~isnan(vote1_5B_russo_1711(:,3)),:);
[vote2_5B_russo_1711, ~, ~] = xlsread('5B_russo.xlsx','Slider2');
vote2_5B_russo_1711 = vote2_5B_russo_1711(:,[2, 11, 14:21]);
vote2_5B_russo_1711 = vote2_5B_russo_1711(~isnan(vote2_5B_russo_1711(:,3)),:);

[vote1_5F_russo_1711, ~, ~] = xlsread('5F_russo.xlsx','Slider1');
vote1_5F_russo_1711 = vote1_5F_russo_1711(:,[2, 11, 14:21]);
vote1_5F_russo_1711 = vote1_5F_russo_1711(~isnan(vote1_5F_russo_1711(:,3)),:);
[vote2_5F_russo_1711, ~, ~] = xlsread('5F_russo.xlsx','Slider2');
vote2_5F_russo_1711 = vote2_5F_russo_1711(:,[2, 11, 14:21]);
vote2_5F_russo_1711 = vote2_5F_russo_1711(~isnan(vote2_5F_russo_1711(:,3)),:);

[vote1_3D1_russo_1811, ~, ~] = xlsread('3D_gruppo1_russo.xlsx','Slider1');
vote1_3D1_russo_1811 = vote1_3D1_russo_1811(:,[2, 11, 14:21]);
vote1_3D1_russo_1811 = vote1_3D1_russo_1811(~isnan(vote1_3D1_russo_1811(:,3)),:);
vote1_3D1_russo_1811(7,:) = []; % problematic observation missing choices
[vote2_3D1_russo_1811, ~, ~] = xlsread('3D_gruppo1_russo.xlsx','Slider2');
vote2_3D1_russo_1811 = vote2_3D1_russo_1811(:,[2, 11, 14:21]);
vote2_3D1_russo_1811 = vote2_3D1_russo_1811(~isnan(vote2_3D1_russo_1811(:,3)),:);
vote2_3D1_russo_1811(7,:) = [];

[vote1_3D2_russo_1811, ~, ~] = xlsread('3D_gruppo2_russo.xlsx','Slider1');
vote1_3D2_russo_1811 = vote1_3D2_russo_1811(:,[2, 11, 14:21]);
vote1_3D2_russo_1811 = vote1_3D2_russo_1811(~isnan(vote1_3D2_russo_1811(:,3)),:);
vote1_3D2_russo_1811(3,:) = []; % the student is repeated as number 15
[vote2_3D2_russo_1811, ~, ~] = xlsread('3D_gruppo2_russo.xlsx','Slider2');
vote2_3D2_russo_1811 = vote2_3D2_russo_1811(:,[2, 11, 14:21]);
vote2_3D2_russo_1811 = vote2_3D2_russo_1811(~isnan(vote2_3D2_russo_1811(:,3)),:);
vote2_3D2_russo_1811(3,:) = []; % the student is repeated as number 15

[vote1_3F_russo_1811, ~, ~] = xlsread('3F_russo.xlsx','Slider1');
vote1_3F_russo_1811 = vote1_3F_russo_1811(:,[2, 11, 14:21]);
vote1_3F_russo_1811 = vote1_3F_russo_1811(~isnan(vote1_3F_russo_1811(:,3)),:);
[vote2_3F_russo_1811, ~, ~] = xlsread('3F_russo.xlsx','Slider2');
vote2_3F_russo_1811 = vote2_3F_russo_1811(:,[2, 11, 14:21]);
vote2_3F_russo_1811 = vote2_3F_russo_1811(~isnan(vote2_3F_russo_1811(:,3)),:);

[vote1_5E_russo_1811, ~, ~] = xlsread('5E_russo.xlsx','Slider1');
vote1_5E_russo_1811 = vote1_5E_russo_1811(:,[2, 11, 14:21]);
vote1_5E_russo_1811 = vote1_5E_russo_1811(~isnan(vote1_5E_russo_1811(:,3)),:);
[vote2_5E_russo_1811, ~, ~] = xlsread('5E_russo.xlsx','Slider2');
vote2_5E_russo_1811 = vote2_5E_russo_1811(:,[2, 11, 14:21]);
vote2_5E_russo_1811 = vote2_5E_russo_1811(~isnan(vote2_5E_russo_1811(:,3)),:);


%% MERGE THE TWO SLIDERS


Slider = [vote1_1D_gruppo1_russo_1805; vote2_1D_gruppo1_russo_1805; vote1_1D_gruppo2_russo_1805;vote2_1D_gruppo2_russo_1805; vote1_1E_russo_1805;vote2_1E_russo_1805;
vote1_3C_russo_1905;vote2_3C_russo_1905;vote1_Assenti_1E_1D_russo_1905;vote2_Assenti_1E_1D_russo_1905;vote1_1A_gruppo1_russo_1905; vote2_1A_gruppo1_russo_1905;vote1_1A_gruppo2_russo_1905; vote2_1A_gruppo2_russo_1905;
vote1_2A_trincone_1810; vote2_2A_trincone_1810;vote1_4A_trincone_1810; vote2_4A_trincone_1810;vote1_4B_trincone_1810; vote2_4B_trincone_1810;vote1_5A_trincone_1810; vote2_5A_trincone_1810; 
vote1_1A_trincone_1910; vote2_1A_trincone_1910; vote1_3A_fatale_gruppo1_1910; vote2_3A_fatale_gruppo1_1910;vote1_3A_fatale_gruppo2_1910; vote2_3A_fatale_gruppo2_1910; vote1_4A_fatale_1910; vote2_4A_fatale_1910; 
vote1_5A_fatale_gruppo1_1910; vote2_5A_fatale_gruppo1_1910; vote1_5A_fatale_gruppo2_1910; vote2_5A_fatale_gruppo2_1910; vote1_5B_fatale_1910; vote2_5B_fatale_1910; 
vote1_4B_fatale_2010; vote2_4B_fatale_2010;vote1_1A_fatale_2010; vote2_1A_fatale_2010; vote1_1B_fatale_2010;vote2_1B_fatale_2010; vote1_2A_fatale_2010; vote2_2A_fatale_2010; vote1_2B_fatale_2010;vote2_2B_fatale_2010; 
vote1_4A_marconi_2110; vote2_4A_marconi_2110; vote1_1A_marconi_gruppo1_2110;vote2_1A_marconi_gruppo1_2110;vote1_1A_marconi_gruppo2_2110;vote2_1A_marconi_gruppo2_2110;vote1_1B_marconi_gruppo1_2110; vote2_1B_marconi_gruppo1_2110;vote1_1B_marconi_gruppo2_2110; vote2_1B_marconi_gruppo2_2110; 
vote1_2B_marconi_2110; vote2_2B_marconi_2110;
vote1_2C_marconi_gruppo1_2410; vote2_2C_marconi_gruppo1_2410;vote1_2C_marconi_gruppo2_2410; vote2_2C_marconi_gruppo2_2410; vote1_3A_marconi_gruppo1_2410;vote2_3A_marconi_gruppo1_2410; vote1_3A_marconi_gruppo2_2410; 
vote2_3A_marconi_gruppo2_2410;vote1_3B_marconi_2410; vote2_3B_marconi_2410; vote1_3C_marconi_2410; vote2_3C_marconi_2410; 
vote1_2B_marconi_gruppo1_2510;vote2_2B_marconi_gruppo1_2510; vote1_2B_marconi_gruppo2_2510;vote2_2B_marconi_gruppo2_2510; vote1_4B_marconi_gruppo1_2510; vote2_4B_marconi_gruppo1_2510; vote1_4B_marconi_gruppo2_2510; 
vote2_4B_marconi_gruppo2_2510; vote1_4C_marconi_gruppo1_2510; vote2_4C_marconi_gruppo1_2510; vote1_4C_marconi_gruppo2_2510; vote2_4C_marconi_gruppo2_2510; vote1_5A_marconi_gruppo1_2510; vote2_5A_marconi_gruppo1_2510; 
vote1_5A_marconi_gruppo2_2510;vote2_5A_marconi_gruppo2_2510; 
vote1_5B_marconi_2610; vote2_5B_marconi_2610; vote1_5C_marconi_gruppo1_2610; vote2_5C_marconi_gruppo1_2610; vote1_5C_marconi_gruppo2_2610; vote2_5C_marconi_gruppo2_2610;
vote1_1B_russo_1411; vote2_1B_russo_1411; vote1_1C_russo_gruppo1_1411; vote2_1C_russo_gruppo1_1411; vote1_1C_russo_gruppo2_1411; vote2_1C_russo_gruppo2_1411; vote1_1E_russo_1411; vote2_1E_russo_1411;
vote1_1F_russo_1511; vote2_1F_russo_1511; vote1_2A_russo_1511; vote2_2A_russo_1511; vote1_2B_russo_1511; vote2_2B_russo_1511;
vote1_3C_russo_1611; vote2_3C_russo_1611; vote1_4C_russo_1611; vote2_4C_russo_1611; vote1_4E_russo_1611; vote2_4E_russo_1611; vote1_4F_russo_1611; vote2_4F_russo_1611;
vote1_4A_russo_1711; vote2_4A_russo_1711; vote1_5A_russo_1711; vote2_5A_russo_1711; vote1_5B_russo_1711; vote2_5B_russo_1711; vote1_5F_russo_1711; vote2_5F_russo_1711;
vote1_3D1_russo_1811; vote2_3D1_russo_1811; vote1_3D2_russo_1811; vote2_3D2_russo_1811; vote1_3F_russo_1811; vote2_3F_russo_1811; vote1_5E_russo_1811; vote2_5E_russo_1811];

SLIDER = {vote1_1D_gruppo1_russo_1805; vote2_1D_gruppo1_russo_1805; vote1_1D_gruppo2_russo_1805;vote2_1D_gruppo2_russo_1805; vote1_1E_russo_1805;vote2_1E_russo_1805;
vote1_3C_russo_1905;vote2_3C_russo_1905;vote1_Assenti_1E_1D_russo_1905;vote2_Assenti_1E_1D_russo_1905;vote1_1A_gruppo1_russo_1905; vote2_1A_gruppo1_russo_1905;vote1_1A_gruppo2_russo_1905; vote2_1A_gruppo2_russo_1905;
vote1_2A_trincone_1810; vote2_2A_trincone_1810;vote1_4A_trincone_1810; vote2_4A_trincone_1810;vote1_4B_trincone_1810; vote2_4B_trincone_1810;vote1_5A_trincone_1810; vote2_5A_trincone_1810; 
vote1_1A_trincone_1910; vote2_1A_trincone_1910; vote1_3A_fatale_gruppo1_1910; vote2_3A_fatale_gruppo1_1910;vote1_3A_fatale_gruppo2_1910; vote2_3A_fatale_gruppo2_1910; vote1_4A_fatale_1910; vote2_4A_fatale_1910; 
vote1_5A_fatale_gruppo1_1910; vote2_5A_fatale_gruppo1_1910; vote1_5A_fatale_gruppo2_1910; vote2_5A_fatale_gruppo2_1910; vote1_5B_fatale_1910; vote2_5B_fatale_1910; 
vote1_4B_fatale_2010; vote2_4B_fatale_2010;vote1_1A_fatale_2010; vote2_1A_fatale_2010; vote1_1B_fatale_2010;vote2_1B_fatale_2010; vote1_2A_fatale_2010; vote2_2A_fatale_2010; vote1_2B_fatale_2010;vote2_2B_fatale_2010;
vote1_4A_marconi_2110; vote2_4A_marconi_2110; vote1_1A_marconi_gruppo1_2110;vote2_1A_marconi_gruppo1_2110;vote1_1A_marconi_gruppo2_2110;vote2_1A_marconi_gruppo2_2110;vote1_1B_marconi_gruppo1_2110; vote2_1B_marconi_gruppo1_2110;vote1_1B_marconi_gruppo2_2110; vote2_1B_marconi_gruppo2_2110; 
vote1_2B_marconi_2110; vote2_2B_marconi_2110;
vote1_2C_marconi_gruppo1_2410; vote2_2C_marconi_gruppo1_2410;vote1_2C_marconi_gruppo2_2410; vote2_2C_marconi_gruppo2_2410; vote1_3A_marconi_gruppo1_2410;vote2_3A_marconi_gruppo1_2410; vote1_3A_marconi_gruppo2_2410; 
vote2_3A_marconi_gruppo2_2410;vote1_3B_marconi_2410; vote2_3B_marconi_2410; vote1_3C_marconi_2410; vote2_3C_marconi_2410; 
vote1_2B_marconi_gruppo1_2510;vote2_2B_marconi_gruppo1_2510; vote1_2B_marconi_gruppo2_2510;vote2_2B_marconi_gruppo2_2510; vote1_4B_marconi_gruppo1_2510; vote2_4B_marconi_gruppo1_2510; vote1_4B_marconi_gruppo2_2510; 
vote2_4B_marconi_gruppo2_2510; vote1_4C_marconi_gruppo1_2510; vote2_4C_marconi_gruppo1_2510; vote1_4C_marconi_gruppo2_2510; vote2_4C_marconi_gruppo2_2510; vote1_5A_marconi_gruppo1_2510; vote2_5A_marconi_gruppo1_2510; 
vote1_5A_marconi_gruppo2_2510;vote2_5A_marconi_gruppo2_2510; 
vote1_5B_marconi_2610; vote2_5B_marconi_2610; vote1_5C_marconi_gruppo1_2610; vote2_5C_marconi_gruppo1_2610; vote1_5C_marconi_gruppo2_2610; vote2_5C_marconi_gruppo2_2610;
vote1_1B_russo_1411; vote2_1B_russo_1411; vote1_1C_russo_gruppo1_1411; vote2_1C_russo_gruppo1_1411; vote1_1C_russo_gruppo2_1411; vote2_1C_russo_gruppo2_1411; vote1_1E_russo_1411; vote2_1E_russo_1411;
vote1_1F_russo_1511; vote2_1F_russo_1511; vote1_2A_russo_1511; vote2_2A_russo_1511; vote1_2B_russo_1511; vote2_2B_russo_1511;
vote1_3C_russo_1611; vote2_3C_russo_1611; vote1_4C_russo_1611; vote2_4C_russo_1611; vote1_4E_russo_1611; vote2_4E_russo_1611; vote1_4F_russo_1611; vote2_4F_russo_1611;
vote1_4A_russo_1711; vote2_4A_russo_1711; vote1_5A_russo_1711; vote2_5A_russo_1711; vote1_5B_russo_1711; vote2_5B_russo_1711; vote1_5F_russo_1711; vote2_5F_russo_1711;
vote1_3D1_russo_1811; vote2_3D1_russo_1811; vote1_3D2_russo_1811; vote2_3D2_russo_1811; vote1_3F_russo_1811; vote2_3F_russo_1811; vote1_5E_russo_1811; vote2_5E_russo_1811};


%% ADD GROUP ID

group = [];
for i=1:size(SLIDER,1)
    group = [group;(round(i/2))*ones(size(SLIDER{i},1),1)];
end

Slider = [group,Slider];


%% DIVIDE PENCILS AND PENS

Slider_pencils = Slider(Slider(:,4)<5,:);
Slider_pens = Slider(Slider(:,4)>4,:);

% reorder the id

temp_slider_pencils = [];
for i=1:max(Slider_pencils(:,1))
    temp = Slider_pencils(Slider_pencils(:,1)==i,:);
    temp = sortrows(temp,2);
    temp_slider_pencils = [temp_slider_pencils;temp];
end

temp_slider_pens = [];
for i=1:max(Slider_pens(:,1))
    temp = Slider_pens(Slider_pens(:,1)==i,:);
    temp = sortrows(temp,2);
    temp_slider_pens = [temp_slider_pens;temp];
end

Slider_pencils = temp_slider_pencils;
Slider_pens = temp_slider_pens;

%% DIVIDE VOTES FROM DESCRIPTIONS and REORDER EVERYTHING

Slider_pencils = [Slider_pencils(:,1:2), Slider_pencils(:,[4 6 8 10]), Slider_pencils(:, [5 7 9 11])];
Slider_pens = [Slider_pens(:,1:2), Slider_pens(:,[4 6 8 10]), Slider_pens(:, [5 7 9 11])];

temp_alt = Slider_pencils(:,3:6);
temp_vote = Slider_pencils(:,7:10);

temp_slider_pencils=[];
for i=1:size(Slider_pencils,1)
    temp=[];
    for j=1:4
    [~,t] = find(temp_alt(i,:)==j);
    s = temp_vote(i,t);
    temp = [temp,j,s];
    end
    temp_slider_pencils(i,:) = [Slider_pencils(i,1:2),temp];
end
Slider_pencils = [temp_slider_pencils(:,1:2), temp_slider_pencils(:,[3 5 7 9]), temp_slider_pencils(:, [4 6 8 10])];

temp_alt = Slider_pens(:,3:6);
temp_vote = Slider_pens(:,7:10);

temp_slider_pens=[];
for i=1:size(Slider_pens,1)
    temp=[];
    for j=5:8
    [~,t] = find(temp_alt(i,:)==j);
    s = temp_vote(i,t);
    temp = [temp,j,s];
    end
    temp_slider_pens(i,:) = [Slider_pens(i,1:2),temp];
end
Slider_pens = [temp_slider_pens(:,1:2), temp_slider_pens(:,[3 5 7 9]), temp_slider_pens(:, [4 6 8 10])];

save stored_variables\sliders Slider_pens Slider_pencils Slider
