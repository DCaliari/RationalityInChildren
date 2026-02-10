%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% LOADING THE DATA FROM RAVEN TEST, GENDER, AND COIN-DROP GAME %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% RAVEN TEST

% 180522 - 190522

Logic_test_IDA_180522 = xlsread('1D_gruppo1_russo.xlsx','Logic test','B1:G131');
Logic_test_IDB_180522 = xlsread('1D_gruppo2_russo.xlsx','Logic test','B1:G130');
a=Logic_test_IDB_180522(:,1)==1; % eliminate ID number 1 - the student was flagged
Logic_test_IDB_180522(a,:)=[];
Logic_test_IE_180522 = xlsread('1E_gruppo1_russo.xlsx','Logic test','B1:G168');
a=Logic_test_IE_180522(:,1)==3; % eliminate ID number 3 - the student was flagged
Logic_test_IE_180522(a,:)=[];

Logic_test_3C_190522 = xlsread('3C_gruppo1_russo.xlsx','Logic test','B1:G213'); %#ok<*XLSRD> 
Logic_test_IEID_190522 = xlsread('Assenti_1E_1D_russo.xlsx','Logic test','B1:G97');
Logic_test_IA1_190522 = xlsread('1A_gruppo1_russo.xlsx','Logic test','B1:G115');
Logic_test_IA2_190522 = xlsread('1A_gruppo2_russo.xlsx','Logic test','B1:G115');

% 181022 - 261022

Logic_test_2A_trincone_181022 = xlsread('2A_trincone.xlsx','Logic test','B1:G225');
Logic_test_4A_trincone_181022 = xlsread('4A_trincone.xlsx','Logic test','B1:G177');
Logic_test_4B_trincone_181022 = xlsread('4B_trincone.xlsx','Logic test','B1:G177');
Logic_test_5A_trincone_181022 = xlsread('5A_trincone.xlsx','Logic test','B1:G241');

Logic_test_1A_trincone_191022 = xlsread('1A_trincone.xlsx','Logic test','B1:G209');
Logic_test_3A1_fatale_191022 = xlsread('3A_fatale_gruppo1.xlsx','Logic test','B1:G177');
Logic_test_3A2_fatale_191022 = xlsread('3A_fatale_gruppo2.xlsx','Logic test','B1:G97');
Logic_test_4A_fatale_191022 = xlsread('4A_fatale.xlsx','Logic test','B1:G177');
Logic_test_5A1_fatale_191022 = xlsread('5A_fatale_gruppo1.xlsx','Logic test','B1:G177');
Logic_test_5A2_fatale_191022 = xlsread('5A_fatale_gruppo2.xlsx','Logic test','B1:G161');
Logic_test_5B_fatale_191022 = xlsread('5B_fatale.xlsx','Logic test','B1:G193');

Logic_test_4B_fatale_201022 = xlsread('4B_fatale.xlsx','Logic test','B1:G177');
Logic_test_1A_fatale_201022 = xlsread('1A_fatale.xlsx','Logic test','B1:G129');
Logic_test_1B_fatale_201022 = xlsread('1B_fatale.xlsx','Logic test','B1:G193');
Logic_test_2A_fatale_201022 = xlsread('2A_fatale.xlsx','Logic test','B1:G161');
Logic_test_2B_fatale_201022 = xlsread('2B_fatale.xlsx','Logic test','B1:G177');

Logic_test_4A_marconi_211022 = xlsread('4A_marconi.xlsx','Logic test','B1:G257');
Logic_test_1A1_marconi_211022 = xlsread('1A_marconi_gruppo1.xlsx','Logic test','B1:G161');
Logic_test_1A2_marconi_211022 = xlsread('1A_marconi_gruppo2.xlsx','Logic test','B1:G145');
Logic_test_1B1_marconi_211022 = xlsread('1B_marconi_gruppo1.xlsx','Logic test','B1:G129');
Logic_test_1B2_marconi_211022 = xlsread('1B_marconi_gruppo2.xlsx','Logic test','B1:G145');
Logic_test_2B_marconi_211022 = xlsread('2B_marconi.xlsx','Logic test','B1:G241');

Logic_test_2C1_marconi_241022 = xlsread('2C_marconi_gruppo1.xlsx','Logic test','B1:G113');
Logic_test_2C2_marconi_241022 = xlsread('2C_marconi_gruppo2.xlsx','Logic test','B1:G129');
Logic_test_3A1_marconi_241022 = xlsread('3A_marconi_gruppo1.xlsx','Logic test','B1:G177');
Logic_test_3A2_marconi_241022 = xlsread('3A_marconi_gruppo2.xlsx','Logic test','B1:G161');
Logic_test_3B_marconi_241022 = xlsread('3B_marconi.xlsx','Logic test','B1:G209');
Logic_test_3C_marconi_241022 = xlsread('3C_marconi.xlsx','Logic test','B1:G273');

Logic_test_2B1_marconi_251022 = xlsread('2B_marconi_gruppo1.xlsx','Logic test','B1:G145');
Logic_test_2B2_marconi_251022 = xlsread('2B_marconi_gruppo2.xlsx','Logic test','B1:G161');
Logic_test_4B1_marconi_251022 = xlsread('4B_marconi_gruppo1.xlsx','Logic test','B1:G161');
a=Logic_test_4B1_marconi_251022(:,1)==15; % choices from the coin-drop game were coded wrongly
Logic_test_4B1_marconi_251022(a,:)=[];
Logic_test_4B2_marconi_251022 = xlsread('4B_marconi_gruppo2.xlsx','Logic test','B1:G145');
Logic_test_4C1_marconi_251022 = xlsread('4C_marconi_gruppo1.xlsx','Logic test','B1:G177');
Logic_test_4C2_marconi_251022 = xlsread('4C_marconi_gruppo2.xlsx','Logic test','B1:G193');
Logic_test_5A1_marconi_251022 = xlsread('5A_marconi_gruppo1.xlsx','Logic test','B1:G193');
Logic_test_5A2_marconi_251022 = xlsread('5A_marconi_gruppo2.xlsx','Logic test','B1:G81');

Logic_test_5B_marconi_261022 = xlsread('5B_marconi.xlsx','Logic test','B1:G257');
Logic_test_5C1_marconi_261022 = xlsread('5C_marconi_gruppo1.xlsx','Logic test','B1:G161');
Logic_test_5C2_marconi_261022 = xlsread('5C_marconi_gruppo2.xlsx','Logic test','B1:G129');

Logic_test_1B_russo_141122 = xlsread('1B_russo.xlsx','Logic test','B1:G289');
Logic_test_1C1_russo_141122 = xlsread('1C_russo_gruppo1.xlsx','Logic test','B1:G145');
Logic_test_1C2_russo_141122 = xlsread('1C_russo_gruppo2.xlsx','Logic test','B1:G161');
Logic_test_1E_russo_141122 = xlsread('1E_russo.xlsx','Logic test','B1:G273');

Logic_test_1F_russo_151122 = xlsread('1F_russo.xlsx','Logic test','B1:G289');
Logic_test_2A_russo_151122 = xlsread('2A_russo.xlsx','Logic test','B1:G241');
Logic_test_2B_russo_151122 = xlsread('2B_russo.xlsx','Logic test','B1:G225');

Logic_test_3C_russo_161122 = xlsread('3C_russo.xlsx','Logic test','B1:G209');
Logic_test_4C_russo_161122 = xlsread('4C_russo.xlsx','Logic test','B1:G193');
Logic_test_4E_russo_161122 = xlsread('4E_russo.xlsx','Logic test','B1:G257');
Logic_test_4F_russo_161122 = xlsread('4F_russo.xlsx','Logic test','B1:G225');

Logic_test_4A_russo_171122 = xlsread('4A_russo.xlsx','Logic test','B1:G225');
a=Logic_test_4A_russo_171122(:,1)==6; % the subject did not solve the coin-drop game
Logic_test_4A_russo_171122(a,:)=[];
Logic_test_5A_russo_171122 = xlsread('5A_russo.xlsx','Logic test','B1:G193');
Logic_test_5B_russo_171122 = xlsread('5B_russo.xlsx','Logic test','B1:G257');
Logic_test_5F_russo_171122 = xlsread('5F_russo.xlsx','Logic test','B1:G257');

Logic_test_3D1_russo_181122 = xlsread('3D_gruppo1_russo.xlsx','Logic test','B1:G145');
a=Logic_test_3D1_russo_181122(:,1)==9; % eliminate ID number 9 - the student was flagged
Logic_test_3D1_russo_181122(a,:)=[];
Logic_test_3D2_russo_181122 = xlsread('3D_gruppo2_russo.xlsx','Logic test','B1:G161');
a=Logic_test_3D2_russo_181122(:,1)==6; % eliminate ID number 6 - the student was flagged
Logic_test_3D2_russo_181122(a,:)=[];
Logic_test_3F_russo_181122 = xlsread('3F_russo.xlsx','Logic test','B1:G177');
Logic_test_5E_russo_181122 = xlsread('5E_russo.xlsx','Logic test','B1:G225');



Logic_test = [Logic_test_IDA_180522;Logic_test_IDB_180522;Logic_test_IE_180522;Logic_test_3C_190522;Logic_test_IEID_190522;Logic_test_IA1_190522;Logic_test_IA2_190522;Logic_test_2A_trincone_181022;Logic_test_4A_trincone_181022;Logic_test_4B_trincone_181022;...
    Logic_test_5A_trincone_181022;Logic_test_1A_trincone_191022;Logic_test_3A1_fatale_191022;Logic_test_3A2_fatale_191022;Logic_test_4A_fatale_191022;Logic_test_5A1_fatale_191022;Logic_test_5A2_fatale_191022;Logic_test_5B_fatale_191022;...
    Logic_test_4B_fatale_201022;Logic_test_1A_fatale_201022;Logic_test_1B_fatale_201022;Logic_test_2A_fatale_201022;Logic_test_2B_fatale_201022;Logic_test_4A_marconi_211022;...
    Logic_test_1A1_marconi_211022; Logic_test_1A2_marconi_211022; Logic_test_1B1_marconi_211022; Logic_test_1B2_marconi_211022; Logic_test_2B_marconi_211022;...
    Logic_test_2C1_marconi_241022; Logic_test_2C2_marconi_241022; Logic_test_3A1_marconi_241022; Logic_test_3A2_marconi_241022; Logic_test_3B_marconi_241022; Logic_test_3C_marconi_241022;
    Logic_test_2B1_marconi_251022;Logic_test_2B2_marconi_251022;Logic_test_4B1_marconi_251022;Logic_test_4B2_marconi_251022;Logic_test_4C1_marconi_251022;Logic_test_4C2_marconi_251022;
    Logic_test_5A1_marconi_251022;Logic_test_5A2_marconi_251022;Logic_test_5B_marconi_261022;Logic_test_5C1_marconi_261022;Logic_test_5C2_marconi_261022;
    Logic_test_1B_russo_141122; Logic_test_1C1_russo_141122; Logic_test_1C2_russo_141122; Logic_test_1E_russo_141122;
    Logic_test_1F_russo_151122; Logic_test_2A_russo_151122; Logic_test_2B_russo_151122;
    Logic_test_3C_russo_161122; Logic_test_4C_russo_161122; Logic_test_4E_russo_161122; Logic_test_4F_russo_161122;
    Logic_test_4A_russo_171122; Logic_test_5A_russo_171122; Logic_test_5B_russo_171122; Logic_test_5F_russo_171122;
    Logic_test_3D1_russo_181122; Logic_test_3D2_russo_181122; Logic_test_3F_russo_181122; Logic_test_5E_russo_181122];

LOGIC = {Logic_test_IDA_180522;Logic_test_IDB_180522;Logic_test_IE_180522;Logic_test_3C_190522;Logic_test_IEID_190522;Logic_test_IA1_190522;Logic_test_IA2_190522;Logic_test_2A_trincone_181022;Logic_test_4A_trincone_181022;Logic_test_4B_trincone_181022;...
    Logic_test_5A_trincone_181022;Logic_test_1A_trincone_191022;Logic_test_3A1_fatale_191022;Logic_test_3A2_fatale_191022;Logic_test_4A_fatale_191022;Logic_test_5A1_fatale_191022;Logic_test_5A2_fatale_191022;Logic_test_5B_fatale_191022;...
    Logic_test_4B_fatale_201022;Logic_test_1A_fatale_201022;Logic_test_1B_fatale_201022;Logic_test_2A_fatale_201022;Logic_test_2B_fatale_201022;Logic_test_4A_marconi_211022;...
    Logic_test_1A1_marconi_211022; Logic_test_1A2_marconi_211022; Logic_test_1B1_marconi_211022; Logic_test_1B2_marconi_211022; Logic_test_2B_marconi_211022;...
    Logic_test_2C1_marconi_241022; Logic_test_2C2_marconi_241022; Logic_test_3A1_marconi_241022; Logic_test_3A2_marconi_241022; Logic_test_3B_marconi_241022; Logic_test_3C_marconi_241022;
    Logic_test_2B1_marconi_251022;Logic_test_2B2_marconi_251022;Logic_test_4B1_marconi_251022;Logic_test_4B2_marconi_251022;Logic_test_4C1_marconi_251022;Logic_test_4C2_marconi_251022;
    Logic_test_5A1_marconi_251022;Logic_test_5A2_marconi_251022;Logic_test_5B_marconi_261022;Logic_test_5C1_marconi_261022;Logic_test_5C2_marconi_261022;
    Logic_test_1B_russo_141122; Logic_test_1C1_russo_141122; Logic_test_1C2_russo_141122; Logic_test_1E_russo_141122;
    Logic_test_1F_russo_151122; Logic_test_2A_russo_151122; Logic_test_2B_russo_151122;
    Logic_test_3C_russo_161122; Logic_test_4C_russo_161122; Logic_test_4E_russo_161122; Logic_test_4F_russo_161122;
    Logic_test_4A_russo_171122; Logic_test_5A_russo_171122; Logic_test_5B_russo_171122; Logic_test_5F_russo_171122;
    Logic_test_3D1_russo_181122; Logic_test_3D2_russo_181122; Logic_test_3F_russo_181122; Logic_test_5E_russo_181122};

%% GENDER

[numbers_IDA_180522, utenti_IDA_180522, ~] = xlsread('1D_gruppo1_russo.xlsx','Utenti bambini');
utenti_IDA_180522 = utenti_IDA_180522(:,1:9);
[numbers_IDB_180522, utenti_IDB_180522, ~] = xlsread('1D_gruppo2_russo.xlsx','Utenti bambini');
[numbers_IE_180522, utenti_IE_180522, ~] = xlsread('1E_gruppo1_russo.xlsx','Utenti bambini');
utenti_IE_180522(4,:)=[]; % the student was problematic
utenti_IE_180522 = utenti_IE_180522(:,1:9);
[numbers_3C_190522, utenti_3C_190522, ~] = xlsread('3C_gruppo1_russo.xlsx','Utenti bambini');
[numbers_IEID_190522, utenti_IEID_190522, ~] = xlsread('Assenti_1E_1D_russo.xlsx','Utenti bambini');
[numbers_IA1_190522, utenti_IA1_190522, ~] = xlsread('1A_gruppo1_russo.xlsx','Utenti bambini');
[numbers_IA2_190522, utenti_IA2_190522, ~] = xlsread('1A_gruppo2_russo.xlsx','Utenti bambini');


[numbers_2A_trincone_181022, utenti_2A_trincone_181022, ~] = xlsread('2A_trincone.xlsx','Utenti bambini');
[numbers_4A_trincone_181022, utenti_4A_trincone_181022, ~] = xlsread('4A_trincone.xlsx','Utenti bambini');
[numbers_4B_trincone_181022, utenti_4B_trincone_181022, ~] = xlsread('4B_trincone.xlsx','Utenti bambini');
[numbers_5A_trincone_181022, utenti_5A_trincone_181022, ~] = xlsread('5A_trincone.xlsx','Utenti bambini');

[numbers_1A_trincone_191022, utenti_1A_trincone_191022, ~] = xlsread('1A_trincone.xlsx','Utenti bambini');
[numbers_3A1_fatale_191022, utenti_3A1_fatale_191022, ~] = xlsread('3A_fatale_gruppo1.xlsx','Utenti bambini');
[numbers_3A2_fatale_191022, utenti_3A2_fatale_191022, ~] = xlsread('3A_fatale_gruppo2.xlsx','Utenti bambini');
[numbers_4A_fatale_191022, utenti_4A_fatale_191022, ~] = xlsread('4A_fatale.xlsx','Utenti bambini');
[numbers_5A1_fatale_191022, utenti_5A1_fatale_191022, ~] = xlsread('5A_fatale_gruppo1.xlsx','Utenti bambini');
[numbers_5A2_fatale_191022, utenti_5A2_fatale_191022, ~] = xlsread('5A_fatale_gruppo2.xlsx','Utenti bambini');
[numbers_5B_fatale_191022, utenti_5B_fatale_191022, ~] = xlsread('5B_fatale.xlsx','Utenti bambini');

[numbers_1A_fatale_201022, utenti_1A_fatale_201022, ~] = xlsread('1A_fatale.xlsx','Utenti bambini');
[numbers_1B_fatale_201022, utenti_1B_fatale_201022, ~] = xlsread('1B_fatale.xlsx','Utenti bambini');
[numbers_2A_fatale_201022, utenti_2A_fatale_201022, ~] = xlsread('2A_fatale.xlsx','Utenti bambini');
[numbers_2B_fatale_201022, utenti_2B_fatale_201022, ~] = xlsread('2B_fatale.xlsx','Utenti bambini');
[numbers_4B_fatale_201022, utenti_4B_fatale_201022, ~] = xlsread('4B_fatale.xlsx','Utenti bambini');

[numbers_1A1_marconi_211022, utenti_1A1_marconi_211022, ~] = xlsread('1A_marconi_gruppo1.xlsx','Utenti bambini');
[numbers_1A2_marconi_211022, utenti_1A2_marconi_211022, ~] = xlsread('1A_marconi_gruppo2.xlsx','Utenti bambini');
[numbers_1B1_marconi_211022, utenti_1B1_marconi_211022, ~] = xlsread('1B_marconi_gruppo1.xlsx','Utenti bambini');
[numbers_1B2_marconi_211022, utenti_1B2_marconi_211022, ~] = xlsread('1B_marconi_gruppo2.xlsx','Utenti bambini');
[numbers_2B_marconi_211022, utenti_2B_marconi_211022, ~] = xlsread('2B_marconi.xlsx','Utenti bambini');
[numbers_4A_marconi_211022, utenti_4A_marconi_211022, ~] = xlsread('4A_marconi.xlsx','Utenti bambini');

[numbers_2C1_marconi_241022, utenti_2C1_marconi_241022, ~] = xlsread('2C_marconi_gruppo1.xlsx','Utenti bambini');
[numbers_2C2_marconi_241022, utenti_2C2_marconi_241022, ~] = xlsread('2C_marconi_gruppo2.xlsx','Utenti bambini');
[numbers_3A1_marconi_241022, utenti_3A1_marconi_241022, ~] = xlsread('3A_marconi_gruppo1.xlsx','Utenti bambini');
[numbers_3A2_marconi_241022, utenti_3A2_marconi_241022, ~] = xlsread('3A_marconi_gruppo2.xlsx','Utenti bambini');
[numbers_3B_marconi_241022, utenti_3B_marconi_241022, ~] = xlsread('3B_marconi.xlsx','Utenti bambini');
[numbers_3C_marconi_241022, utenti_3C_marconi_241022, ~] = xlsread('3C_marconi.xlsx','Utenti bambini');

[numbers_2B1_marconi_251022, utenti_2B1_marconi_251022, ~] = xlsread('2B_marconi_gruppo1.xlsx','Utenti bambini');
[numbers_2B2_marconi_251022, utenti_2B2_marconi_251022, ~] = xlsread('2B_marconi_gruppo2.xlsx','Utenti bambini');
[numbers_4B1_marconi_251022, utenti_4B1_marconi_251022, ~] = xlsread('4B_marconi_gruppo1.xlsx','Utenti bambini');
utenti_4B1_marconi_251022(8,:)=[]; % the student answered wrongly to Pachinko
[numbers_4B2_marconi_251022, utenti_4B2_marconi_251022, ~] = xlsread('4B_marconi_gruppo2.xlsx','Utenti bambini');
[numbers_4C1_marconi_251022, utenti_4C1_marconi_251022, ~] = xlsread('4C_marconi_gruppo1.xlsx','Utenti bambini');
[numbers_4C2_marconi_251022, utenti_4C2_marconi_251022, ~] = xlsread('4C_marconi_gruppo2.xlsx','Utenti bambini');
[numbers_5A1_marconi_251022, utenti_5A1_marconi_251022, ~] = xlsread('5A_marconi_gruppo1.xlsx','Utenti bambini');
[numbers_5A2_marconi_251022, utenti_5A2_marconi_251022, ~] = xlsread('5A_marconi_gruppo2.xlsx','Utenti bambini');

[numbers_5B_marconi_261022, utenti_5B_marconi_261022, ~] = xlsread('5B_marconi.xlsx','Utenti bambini');
[numbers_5C1_marconi_261022, utenti_5C1_marconi_261022, ~] = xlsread('5C_marconi_gruppo1.xlsx','Utenti bambini');
[numbers_5C2_marconi_261022, utenti_5C2_marconi_261022, ~] = xlsread('5C_marconi_gruppo2.xlsx','Utenti bambini');

[numbers_1B_russo_141122, utenti_1B_russo_141122, ~] = xlsread('1B_russo.xlsx','Utenti bambini');
[numbers_1C1_russo_141122, utenti_1C1_russo_141122, ~] = xlsread('1C_russo_gruppo1.xlsx','Utenti bambini');
[numbers_1C2_russo_141122, utenti_1C2_russo_141122, ~] = xlsread('1C_russo_gruppo2.xlsx','Utenti bambini');
[numbers_1E_russo_141122, utenti_1E_russo_141122, ~] = xlsread('1E_russo.xlsx','Utenti bambini');

[numbers_1F_russo_151122, utenti_1F_russo_151122, ~] = xlsread('1F_russo.xlsx','Utenti bambini');
[numbers_2A_russo_151122, utenti_2A_russo_151122, ~] = xlsread('2A_russo.xlsx','Utenti bambini');
[numbers_2B_russo_151122, utenti_2B_russo_151122, ~] = xlsread('2B_russo.xlsx','Utenti bambini');

[numbers_3C_russo_161122, utenti_3C_russo_161122, ~] = xlsread('3C_russo.xlsx','Utenti bambini');
[numbers_4C_russo_161122, utenti_4C_russo_161122, ~] = xlsread('4C_russo.xlsx','Utenti bambini');
[numbers_4E_russo_161122, utenti_4E_russo_161122, ~] = xlsread('4E_russo.xlsx','Utenti bambini');
[numbers_4F_russo_161122, utenti_4F_russo_161122, ~] = xlsread('4F_russo.xlsx','Utenti bambini');

[numbers_4A_russo_171122, utenti_4A_russo_171122, ~] = xlsread('4A_russo.xlsx','Utenti bambini');
utenti_4A_russo_171122(2,:)=[]; % the student did not solve the Pachinko
[numbers_5A_russo_171122, utenti_5A_russo_171122, ~] = xlsread('5A_russo.xlsx','Utenti bambini');
[numbers_5B_russo_171122, utenti_5B_russo_171122, ~] = xlsread('5B_russo.xlsx','Utenti bambini');
[numbers_5F_russo_171122, utenti_5F_russo_171122, ~] = xlsread('5F_russo.xlsx','Utenti bambini');

[numbers_3D_gruppo1_russo_181122, utenti_3D_gruppo1_russo_181122, ~] = xlsread('3D_gruppo1_russo.xlsx','Utenti bambini');
utenti_3D_gruppo1_russo_181122(8,:)=[]; % the student 108 has missing choice 
[numbers_3D_gruppo2_russo_181122, utenti_3D_gruppo2_russo_181122, ~] = xlsread('3D_gruppo2_russo.xlsx','Utenti bambini');
utenti_3D_gruppo2_russo_181122(4,:)=[]; % the student 6 is repeated as student 15
[numbers_3F_russo_181122, utenti_3F_russo_181122, ~] = xlsread('3F_russo.xlsx','Utenti bambini');
[numbers_5E_russo_181122, utenti_5E_russo_181122, ~] = xlsread('5E_russo.xlsx','Utenti bambini');


utenti = [utenti_IDA_180522;utenti_IDB_180522;utenti_IE_180522;utenti_3C_190522;utenti_IEID_190522;utenti_IA1_190522;utenti_IA2_190522;utenti_2A_trincone_181022;utenti_4A_trincone_181022;utenti_4B_trincone_181022;...
    utenti_5A_trincone_181022;utenti_1A_trincone_191022;utenti_3A1_fatale_191022;utenti_3A2_fatale_191022;utenti_4A_fatale_191022;utenti_5A1_fatale_191022;utenti_5A2_fatale_191022;utenti_5B_fatale_191022;...
    utenti_4B_fatale_201022;utenti_1A_fatale_201022;utenti_1B_fatale_201022;utenti_2A_fatale_201022;utenti_2B_fatale_201022;utenti_4A_marconi_211022;...
    utenti_1A1_marconi_211022; utenti_1A2_marconi_211022; utenti_1B1_marconi_211022; utenti_1B2_marconi_211022; utenti_2B_marconi_211022;...
    utenti_2C1_marconi_241022; utenti_2C2_marconi_241022; utenti_3A1_marconi_241022; utenti_3A2_marconi_241022; utenti_3B_marconi_241022; utenti_3C_marconi_241022;...
    utenti_2B1_marconi_251022;utenti_2B2_marconi_251022;utenti_4B1_marconi_251022;utenti_4B2_marconi_251022;utenti_4C1_marconi_251022;utenti_4C2_marconi_251022;...
    utenti_5A1_marconi_251022;utenti_5A2_marconi_251022;utenti_5B_marconi_261022;utenti_5C1_marconi_261022;utenti_5C2_marconi_261022;...
    utenti_1B_russo_141122; utenti_1C1_russo_141122; utenti_1C2_russo_141122; utenti_1E_russo_141122;
    utenti_1F_russo_151122; utenti_2A_russo_151122; utenti_2B_russo_151122;
    utenti_3C_russo_161122; utenti_4C_russo_161122; utenti_4E_russo_161122; utenti_4F_russo_161122;
    utenti_4A_russo_171122; utenti_5A_russo_171122; utenti_5B_russo_171122; utenti_5F_russo_171122;
    utenti_3D_gruppo1_russo_181122; utenti_3D_gruppo2_russo_181122; utenti_3F_russo_181122; utenti_5E_russo_181122];

UTENTI = {utenti_IDA_180522;utenti_IDB_180522;utenti_IE_180522;utenti_3C_190522;utenti_IEID_190522;utenti_IA1_190522;utenti_IA2_190522;utenti_2A_trincone_181022;utenti_4A_trincone_181022;utenti_4B_trincone_181022;...
    utenti_5A_trincone_181022;utenti_1A_trincone_191022;utenti_3A1_fatale_191022;utenti_3A2_fatale_191022;utenti_4A_fatale_191022;utenti_5A1_fatale_191022;utenti_5A2_fatale_191022;utenti_5B_fatale_191022;...
    utenti_4B_fatale_201022;utenti_1A_fatale_201022;utenti_1B_fatale_201022;utenti_2A_fatale_201022;utenti_2B_fatale_201022;utenti_4A_marconi_211022;...
    utenti_1A1_marconi_211022; utenti_1A2_marconi_211022; utenti_1B1_marconi_211022; utenti_1B2_marconi_211022; utenti_2B_marconi_211022;...
    utenti_2C1_marconi_241022; utenti_2C2_marconi_241022; utenti_3A1_marconi_241022; utenti_3A2_marconi_241022; utenti_3B_marconi_241022; utenti_3C_marconi_241022;...
    utenti_2B1_marconi_251022;utenti_2B2_marconi_251022;utenti_4B1_marconi_251022;utenti_4B2_marconi_251022;utenti_4C1_marconi_251022;utenti_4C2_marconi_251022;...
    utenti_5A1_marconi_251022;utenti_5A2_marconi_251022;utenti_5B_marconi_261022;utenti_5C1_marconi_261022;utenti_5C2_marconi_261022;...
    utenti_1B_russo_141122; utenti_1C1_russo_141122; utenti_1C2_russo_141122; utenti_1E_russo_141122;
    utenti_1F_russo_151122; utenti_2A_russo_151122; utenti_2B_russo_151122;
    utenti_3C_russo_161122; utenti_4C_russo_161122; utenti_4E_russo_161122; utenti_4F_russo_161122;
    utenti_4A_russo_171122; utenti_5A_russo_171122; utenti_5B_russo_171122; utenti_5F_russo_171122;
    utenti_3D_gruppo1_russo_181122; utenti_3D_gruppo2_russo_181122; utenti_3F_russo_181122; utenti_5E_russo_181122};

%% PACHINKO FIRST WAVE

% treatment 1
% columns 3-5 is the control question: column 5 should be equal to one
% columns 6-8 is the main question: col6 = 333; col7 = 2222; col8 = 1111111
% column 9 is the sheep game

Pachinko_4A_trincone_181022 = xlsread('4A_trincone.xlsx','Pachinko','A1:J12');
Pachinko_5A_trincone_181022 = xlsread('5A_trincone.xlsx','Pachinko','A1:J16');
Pachinko_3A2_fatale_191022 = xlsread('3A_fatale_gruppo2.xlsx','Pachinko','A1:J7');
Pachinko_5A2_fatale_191022 = xlsread('5A_fatale_gruppo2.xlsx','Pachinko','A1:J11');
Pachinko_4B_fatale_201022 = xlsread('4B_fatale.xlsx','Pachinko','A1:J12');
Pachinko_4A_marconi_211022 = xlsread('4A_marconi.xlsx','Pachinko','A1:J17');
Pachinko_3A1_marconi_241022 = xlsread('3A_marconi_gruppo1.xlsx','Pachinko','A1:J12');
Pachinko_3A2_marconi_241022 = xlsread('3A_marconi_gruppo2.xlsx','Pachinko','A1:J11');
Pachinko_3B_marconi_241022 = xlsread('3B_marconi.xlsx','Pachinko','A1:J14');
Pachinko_4B1_marconi_251022 = xlsread('4B_marconi_gruppo1.xlsx','Pachinko','A1:J11');
a=Pachinko_4B1_marconi_251022(:,1)==15; % wrong Pachinko answer
Pachinko_4B1_marconi_251022(a,:)=[];
Pachinko_4B2_marconi_251022 = xlsread('4B_marconi_gruppo2.xlsx','Pachinko','A1:J10');
Pachinko_5B_marconi_261022 = xlsread('5B_marconi.xlsx','Pachinko','A1:J17');
Pachinko_4E_russo_161122 = xlsread('4E_russo.xlsx','Pachinko','A1:J17');
Pachinko_4F_russo_161122 = xlsread('4F_russo.xlsx','Pachinko','A1:J15');
Pachinko_4A_russo_171122 = xlsread('4A_russo.xlsx','Pachinko','A1:J14');
Pachinko_5A_russo_171122 = xlsread('5A_russo.xlsx','Pachinko','A1:J13');
Pachinko_3D1_russo_181122 = xlsread('3D_gruppo1_russo.xlsx','Pachinko','A1:J10');
Pachinko_3D1_russo_181122(7,:)=[];
Pachinko_3D2_russo_181122 = xlsread('3D_gruppo2_russo.xlsx','Pachinko','A1:J10');
Pachinko_5E_russo_181122 = xlsread('5E_russo.xlsx','Pachinko','A1:J15');
Pachinko_4B_trincone_181022 = xlsread('4B_trincone.xlsx','Pachinko','A1:J12');

Pachinko_5A2_fatale_191022(:,2) = 5.*ones(size(Pachinko_5A2_fatale_191022,1),1);
Pachinko_3A2_fatale_191022(:,2) = 3.*ones(size(Pachinko_3A2_fatale_191022,1),1);
Pachinko_4A_trincone_181022(:,2) = 4.*ones(size(Pachinko_4A_trincone_181022,1),1);
Pachinko_5A_trincone_181022(:,2) =  5.*ones(size(Pachinko_5A_trincone_181022,1),1);
Pachinko_4B_fatale_201022(:,2) =  4.*ones(size(Pachinko_4B_fatale_201022,1),1);
Pachinko_4A_marconi_211022(:,2) = 4.*ones(size(Pachinko_4A_marconi_211022,1),1);
Pachinko_3A1_marconi_241022(:,2) = 3.*ones(size(Pachinko_3A1_marconi_241022,1),1);
Pachinko_3A2_marconi_241022(:,2) = 3.*ones(size(Pachinko_3A2_marconi_241022,1),1);
Pachinko_3B_marconi_241022(:,2) = 3.*ones(size(Pachinko_3B_marconi_241022,1),1);
Pachinko_4B1_marconi_251022(:,2) = 4.*ones(size(Pachinko_4B1_marconi_251022,1),1);
Pachinko_4B2_marconi_251022(:,2) = 4.*ones(size(Pachinko_4B2_marconi_251022,1),1);
Pachinko_5B_marconi_261022(:,2) = 5.*ones(size(Pachinko_5B_marconi_261022,1),1);
Pachinko_4E_russo_161122(:,2) = 4.*ones(size(Pachinko_4E_russo_161122,1),1);
Pachinko_4F_russo_161122(:,2) = 4.*ones(size(Pachinko_4F_russo_161122,1),1);
Pachinko_4A_russo_171122(:,2) = 4.*ones(size(Pachinko_4A_russo_171122,1),1);
Pachinko_5A_russo_171122(:,2) = 5.*ones(size(Pachinko_5A_russo_171122,1),1);
Pachinko_3D1_russo_181122(:,2) = 3.*ones(size(Pachinko_3D1_russo_181122,1),1);
Pachinko_3D2_russo_181122(:,2) = 3.*ones(size(Pachinko_3D2_russo_181122,1),1);
Pachinko_5E_russo_181122(:,2) = 5.*ones(size(Pachinko_5E_russo_181122,1),1);
Pachinko_4B_trincone_181022(:,2) = 4.*ones(size(Pachinko_4B_trincone_181022,1),1);


Pachinko_5A2_fatale_191022(:,11) = Pachinko_5A2_fatale_191022(:,6).*Pachinko_5A2_fatale_191022(:,7); % col10 = 333+2222
Pachinko_3A2_fatale_191022(:,11) = Pachinko_3A2_fatale_191022(:,6).*Pachinko_3A2_fatale_191022(:,7);
Pachinko_4A_trincone_181022(:,11) = Pachinko_4A_trincone_181022(:,6).*Pachinko_4A_trincone_181022(:,7);
Pachinko_5A_trincone_181022(:,11) =  Pachinko_5A_trincone_181022(:,6).*Pachinko_5A_trincone_181022(:,7);
Pachinko_4B_fatale_201022(:,11) =  Pachinko_4B_fatale_201022(:,6).*Pachinko_4B_fatale_201022(:,7);
Pachinko_4A_marconi_211022(:,11) =  Pachinko_4A_marconi_211022(:,6).*Pachinko_4A_marconi_211022(:,7);
Pachinko_3A1_marconi_241022(:,11) =  Pachinko_3A1_marconi_241022(:,6).*Pachinko_3A1_marconi_241022(:,7);
Pachinko_3A2_marconi_241022(:,11) =  Pachinko_3A2_marconi_241022(:,6).*Pachinko_3A2_marconi_241022(:,7);
Pachinko_3B_marconi_241022(:,11) =  Pachinko_3B_marconi_241022(:,6).*Pachinko_3B_marconi_241022(:,7);
Pachinko_4B1_marconi_251022(:,11) =  Pachinko_4B1_marconi_251022(:,6).*Pachinko_4B1_marconi_251022(:,7);
Pachinko_4B2_marconi_251022(:,11) =  Pachinko_4B2_marconi_251022(:,6).*Pachinko_4B2_marconi_251022(:,7);
Pachinko_5B_marconi_261022(:,11) =  Pachinko_5B_marconi_261022(:,6).*Pachinko_5B_marconi_261022(:,7);
Pachinko_4E_russo_161122(:,11) =  Pachinko_4E_russo_161122(:,6).*Pachinko_4E_russo_161122(:,7);
Pachinko_4F_russo_161122(:,11) =  Pachinko_4F_russo_161122(:,6).*Pachinko_4F_russo_161122(:,7);
Pachinko_4A_russo_171122(:,11) =  Pachinko_4A_russo_171122(:,6).*Pachinko_4A_russo_171122(:,7);
Pachinko_5A_russo_171122(:,11) =  Pachinko_5A_russo_171122(:,6).*Pachinko_5A_russo_171122(:,7);
Pachinko_3D1_russo_181122(:,11) =  Pachinko_3D1_russo_181122(:,6).*Pachinko_3D1_russo_181122(:,7);
Pachinko_3D2_russo_181122(:,11) =  Pachinko_3D2_russo_181122(:,6).*Pachinko_3D2_russo_181122(:,7);
Pachinko_5E_russo_181122(:,11) =  Pachinko_5E_russo_181122(:,6).*Pachinko_5E_russo_181122(:,7);
Pachinko_4B_trincone_181022(:,11) =  Pachinko_4B_trincone_181022(:,6).*Pachinko_4B_trincone_181022(:,7);

Pachinko_5A2_fatale_191022(:,12) = Pachinko_5A2_fatale_191022(:,6).*Pachinko_5A2_fatale_191022(:,8); % col11 = 333+1111111
Pachinko_3A2_fatale_191022(:,12) = Pachinko_3A2_fatale_191022(:,6).*Pachinko_3A2_fatale_191022(:,8);
Pachinko_4A_trincone_181022(:,12) = Pachinko_4A_trincone_181022(:,6).*Pachinko_4A_trincone_181022(:,8);
Pachinko_5A_trincone_181022(:,12) =  Pachinko_5A_trincone_181022(:,6).*Pachinko_5A_trincone_181022(:,8);
Pachinko_4B_fatale_201022(:,12) =  Pachinko_4B_fatale_201022(:,6).*Pachinko_4B_fatale_201022(:,8);
Pachinko_4A_marconi_211022(:,12) =  Pachinko_4A_marconi_211022(:,6).*Pachinko_4A_marconi_211022(:,8);
Pachinko_3A1_marconi_241022(:,12) =  Pachinko_3A1_marconi_241022(:,6).*Pachinko_3A1_marconi_241022(:,8);
Pachinko_3A2_marconi_241022(:,12) =  Pachinko_3A2_marconi_241022(:,6).*Pachinko_3A2_marconi_241022(:,8);
Pachinko_3B_marconi_241022(:,12) =  Pachinko_3B_marconi_241022(:,6).*Pachinko_3B_marconi_241022(:,8);
Pachinko_4B1_marconi_251022(:,12) =  Pachinko_4B1_marconi_251022(:,6).*Pachinko_4B1_marconi_251022(:,8);
Pachinko_4B2_marconi_251022(:,12) =  Pachinko_4B2_marconi_251022(:,6).*Pachinko_4B2_marconi_251022(:,8);
Pachinko_5B_marconi_261022(:,12) =  Pachinko_5B_marconi_261022(:,6).*Pachinko_5B_marconi_261022(:,8);
Pachinko_4E_russo_161122(:,12) =  Pachinko_4E_russo_161122(:,6).*Pachinko_4E_russo_161122(:,8);
Pachinko_4F_russo_161122(:,12) =  Pachinko_4F_russo_161122(:,6).*Pachinko_4F_russo_161122(:,8);
Pachinko_4A_russo_171122(:,12) =  Pachinko_4A_russo_171122(:,6).*Pachinko_4A_russo_171122(:,8);
Pachinko_5A_russo_171122(:,12) =  Pachinko_5A_russo_171122(:,6).*Pachinko_5A_russo_171122(:,8);
Pachinko_3D1_russo_181122(:,12) =  Pachinko_3D1_russo_181122(:,6).*Pachinko_3D1_russo_181122(:,8);
Pachinko_3D2_russo_181122(:,12) =  Pachinko_3D2_russo_181122(:,6).*Pachinko_3D2_russo_181122(:,8);
Pachinko_5E_russo_181122(:,12) =  Pachinko_5E_russo_181122(:,6).*Pachinko_5E_russo_181122(:,8);
Pachinko_4B_trincone_181022(:,12) =  Pachinko_4B_trincone_181022(:,6).*Pachinko_4B_trincone_181022(:,8);

Pachinko_5A2_fatale_191022(:,13) = Pachinko_5A2_fatale_191022(:,7).*Pachinko_5A2_fatale_191022(:,8); % col12 = 2222+1111111
Pachinko_3A2_fatale_191022(:,13) = Pachinko_3A2_fatale_191022(:,7).*Pachinko_3A2_fatale_191022(:,8);
Pachinko_4A_trincone_181022(:,13) = Pachinko_4A_trincone_181022(:,7).*Pachinko_4A_trincone_181022(:,8);
Pachinko_5A_trincone_181022(:,13) =  Pachinko_5A_trincone_181022(:,7).*Pachinko_5A_trincone_181022(:,8);
Pachinko_4B_fatale_201022(:,13) =  Pachinko_4B_fatale_201022(:,7).*Pachinko_4B_fatale_201022(:,8);
Pachinko_4A_marconi_211022(:,13) =  Pachinko_4A_marconi_211022(:,7).*Pachinko_4A_marconi_211022(:,8);
Pachinko_3A1_marconi_241022(:,13) =  Pachinko_3A1_marconi_241022(:,7).*Pachinko_3A1_marconi_241022(:,8);
Pachinko_3A2_marconi_241022(:,13) =  Pachinko_3A2_marconi_241022(:,7).*Pachinko_3A2_marconi_241022(:,8);
Pachinko_3B_marconi_241022(:,13) =  Pachinko_3B_marconi_241022(:,7).*Pachinko_3B_marconi_241022(:,8);
Pachinko_4B1_marconi_251022(:,13) =  Pachinko_4B1_marconi_251022(:,7).*Pachinko_4B1_marconi_251022(:,8);
Pachinko_4B2_marconi_251022(:,13) =  Pachinko_4B2_marconi_251022(:,7).*Pachinko_4B2_marconi_251022(:,8);
Pachinko_5B_marconi_261022(:,13) =  Pachinko_5B_marconi_261022(:,7).*Pachinko_5B_marconi_261022(:,8);
Pachinko_4E_russo_161122(:,13) =  Pachinko_4E_russo_161122(:,7).*Pachinko_4E_russo_161122(:,8);
Pachinko_4F_russo_161122(:,13) =  Pachinko_4F_russo_161122(:,7).*Pachinko_4F_russo_161122(:,8);
Pachinko_4A_russo_171122(:,13) =  Pachinko_4A_russo_171122(:,7).*Pachinko_4A_russo_171122(:,8);
Pachinko_5A_russo_171122(:,13) =  Pachinko_5A_russo_171122(:,7).*Pachinko_5A_russo_171122(:,8);
Pachinko_3D1_russo_181122(:,13) =  Pachinko_3D1_russo_181122(:,7).*Pachinko_3D1_russo_181122(:,8);
Pachinko_3D2_russo_181122(:,13) =  Pachinko_3D2_russo_181122(:,7).*Pachinko_3D2_russo_181122(:,8);
Pachinko_5E_russo_181122(:,13) =  Pachinko_5E_russo_181122(:,7).*Pachinko_5E_russo_181122(:,8);
Pachinko_4B_trincone_181022(:,13) =  Pachinko_4B_trincone_181022(:,7).*Pachinko_4B_trincone_181022(:,8);
% add the raven tests results

Pachinko_t1 = [Pachinko_4A_trincone_181022;Pachinko_5A_trincone_181022;Pachinko_3A2_fatale_191022;Pachinko_5A2_fatale_191022;Pachinko_4B_fatale_201022;Pachinko_4A_marconi_211022;...
    Pachinko_3A1_marconi_241022;Pachinko_3A2_marconi_241022;Pachinko_3B_marconi_241022; Pachinko_4B1_marconi_251022; Pachinko_4B2_marconi_251022;Pachinko_5B_marconi_261022;...
    Pachinko_4E_russo_161122; Pachinko_4F_russo_161122; Pachinko_4A_russo_171122; Pachinko_5A_russo_171122; Pachinko_3D1_russo_181122;Pachinko_3D2_russo_181122; Pachinko_5E_russo_181122;Pachinko_4B_trincone_181022];

% treatment 2   
% columns 3-5 is the control question: column 5 should be equal to one
% columns 6-8 is the main question: col6 = 3332; col7 = 3331111; col8 = 2222111
% column 9 is the sheep game

Pachinko_3A1_fatale_191022 = xlsread('3A_fatale_gruppo1.xlsx','Pachinko','A1:J12');
Pachinko_4A_fatale_191022 = xlsread('4A_fatale.xlsx','Pachinko','A1:J12');
Pachinko_5A1_fatale_191022 = xlsread('5A_fatale_gruppo1.xlsx','Pachinko','A1:J12');
Pachinko_5B_fatale_191022 = xlsread('5B_fatale.xlsx','Pachinko','A1:J13');
Pachinko_3C_marconi_241022 = xlsread('3C_marconi.xlsx','Pachinko','A1:J18');
Pachinko_4C1_marconi_251022 = xlsread('4C_marconi_gruppo1.xlsx','Pachinko','A1:J12');
Pachinko_4C2_marconi_251022 = xlsread('4C_marconi_gruppo2.xlsx','Pachinko','A1:J13');
Pachinko_5A1_marconi_251022 = xlsread('5A_marconi_gruppo1.xlsx','Pachinko','A1:J13');
Pachinko_5A2_marconi_251022 = xlsread('5A_marconi_gruppo2.xlsx','Pachinko','A1:J6');
Pachinko_5C1_marconi_261022 = xlsread('5C_marconi_gruppo1.xlsx','Pachinko','A1:J11');
Pachinko_5C2_marconi_261022 = xlsread('5C_marconi_gruppo2.xlsx','Pachinko','A1:J9');
Pachinko_3C_russo_161122 = xlsread('3C_russo.xlsx','Pachinko','A1:J14');
Pachinko_4C_russo_161122 = xlsread('4C_russo.xlsx','Pachinko','A1:J13');
Pachinko_5B_russo_171122 = xlsread('5B_russo.xlsx','Pachinko','A1:J17');
Pachinko_5F_russo_171122 = xlsread('5F_russo.xlsx','Pachinko','A1:J17');
% Pachinko_3E_russo_181122 = xlsread('3E_russo.xlsx','Pachinko','A1:J10');
Pachinko_3F_russo_181122 = xlsread('3F_russo.xlsx','Pachinko','A1:J12');

Pachinko_3A1_fatale_191022(:,2) = 3.*ones(size(Pachinko_3A1_fatale_191022,1),1);
Pachinko_4A_fatale_191022(:,2) = 4.*ones(size(Pachinko_4A_fatale_191022,1),1);
Pachinko_5A1_fatale_191022(:,2) = 5.*ones(size(Pachinko_5A1_fatale_191022,1),1);
Pachinko_5B_fatale_191022(:,2) = 5.*ones(size(Pachinko_5B_fatale_191022,1),1);
Pachinko_3C_marconi_241022(:,2) = 3.*ones(size(Pachinko_3C_marconi_241022,1),1);
Pachinko_4C1_marconi_251022(:,2) = 4.*ones(size(Pachinko_4C1_marconi_251022,1),1);
Pachinko_4C2_marconi_251022(:,2) = 4.*ones(size(Pachinko_4C2_marconi_251022,1),1);
Pachinko_5A1_marconi_251022(:,2) = 5.*ones(size(Pachinko_5A1_marconi_251022,1),1);
Pachinko_5A2_marconi_251022(:,2) = 5.*ones(size(Pachinko_5A2_marconi_251022,1),1);
Pachinko_5C1_marconi_261022(:,2) = 5.*ones(size(Pachinko_5C1_marconi_261022,1),1);
Pachinko_5C2_marconi_261022(:,2) = 5.*ones(size(Pachinko_5C2_marconi_261022,1),1);
Pachinko_3C_russo_161122(:,2) = 3.*ones(size(Pachinko_3C_russo_161122,1),1);
Pachinko_4C_russo_161122(:,2) = 4.*ones(size(Pachinko_4C_russo_161122,1),1);
Pachinko_5B_russo_171122(:,2) = 5.*ones(size(Pachinko_5B_russo_171122,1),1);
Pachinko_5F_russo_171122(:,2) = 5.*ones(size(Pachinko_5F_russo_171122,1),1);
Pachinko_3F_russo_181122(:,2) = 3.*ones(size(Pachinko_3F_russo_181122,1),1);


Pachinko_t2 = [Pachinko_3A1_fatale_191022;Pachinko_4A_fatale_191022;Pachinko_5A1_fatale_191022;Pachinko_5B_fatale_191022;Pachinko_3C_marconi_241022;Pachinko_4C1_marconi_251022;
    Pachinko_4C2_marconi_251022;Pachinko_5A1_marconi_251022;Pachinko_5A2_marconi_251022;Pachinko_5C1_marconi_261022;Pachinko_5C2_marconi_261022; Pachinko_3C_russo_161122; Pachinko_4C_russo_161122;
    Pachinko_5B_russo_171122; Pachinko_5F_russo_171122; Pachinko_3F_russo_181122];


%% PACHINKO SECOND WAVE

Pachinko2_4B_fatale_0323 = xlsread('4B_fatale.xlsx','Pachinko2','A1:I12');
Pachinko2_4A_marconi_0323 = xlsread('4A_marconi.xlsx','Pachinko2','A1:I17');
Pachinko2_4B_trincone_0323 = xlsread('4B_trincone.xlsx','Pachinko2','A1:I12');
Pachinko2_4A_trincone_0323 = xlsread('4A_trincone.xlsx','Pachinko2','A1:I12');
Pachinko2_5A_trincone_0323 = xlsread('5A_trincone.xlsx','Pachinko2','A1:I16');
Pachinko2_4B1_marconi_0323 = xlsread('4B_marconi_gruppo1.xlsx','Pachinko2','A1:I11');
a=Pachinko2_4B1_marconi_0323(:,1)==15; % wrong Pachinko answer
Pachinko2_4B1_marconi_0323(a,:)=[];
Pachinko2_4B2_marconi_0323 = xlsread('4B_marconi_gruppo2.xlsx','Pachinko2','A1:I10');
Pachinko2_3A1_fatale_0323 = xlsread('3A_fatale_gruppo1.xlsx','Pachinko2','A1:I12');
Pachinko2_3A2_fatale_0323 = xlsread('3A_fatale_gruppo2.xlsx','Pachinko2','A1:I7');
Pachinko2_4A_fatale_0323 = xlsread('4A_fatale.xlsx','Pachinko2','A1:I12');
Pachinko2_5A1_fatale_0323 = xlsread('5A_fatale_gruppo1.xlsx','Pachinko2','A1:I12');
Pachinko2_3C_marconi_0323 = xlsread('3C_marconi.xlsx','Pachinko2','A1:I18');
Pachinko2_5A2_fatale_0323 = xlsread('5A_fatale_gruppo2.xlsx','Pachinko2','A1:I11');
Pachinko2_3A1_marconi_0323 = xlsread('3A_marconi_gruppo1.xlsx','Pachinko2','A1:I12');
Pachinko2_3A2_marconi_0323 = xlsread('3A_marconi_gruppo2.xlsx','Pachinko2','A1:I11');
Pachinko2_3B_marconi_0323 = xlsread('3B_marconi.xlsx','Pachinko2','A1:I14');
Pachinko2_5B_fatale_0323 = xlsread('5B_fatale.xlsx','Pachinko2','A1:I13');
Pachinko2_4C1_marconi_0323 = xlsread('4C_marconi_gruppo1.xlsx','Pachinko2','A1:I12');
Pachinko2_4C2_marconi_0323 = xlsread('4C_marconi_gruppo2.xlsx','Pachinko2','A1:I13');
Pachinko2_5A1_marconi_0323 = xlsread('5A_marconi_gruppo1.xlsx','Pachinko2','A1:I13');
Pachinko2_5A2_marconi_0323 = xlsread('5A_marconi_gruppo2.xlsx','Pachinko2','A1:I6');
Pachinko2_5C1_marconi_0323 = xlsread('5C_marconi_gruppo1.xlsx','Pachinko2','A1:I11');
Pachinko2_5C2_marconi_0323 = xlsread('5C_marconi_gruppo2.xlsx','Pachinko2','A1:I9');
Pachinko2_5B_marconi_0323 = xlsread('5B_marconi.xlsx','Pachinko2','A1:I17');

Pachinko2_4E_russo_0323 = xlsread('4E_russo.xlsx','Pachinko2','A1:I17');
Pachinko2_4F_russo_0323 = xlsread('4F_russo.xlsx','Pachinko2','A1:I15');
Pachinko2_4A_russo_0323 = xlsread('4A_russo.xlsx','Pachinko2','A1:I14');
Pachinko2_5A_russo_0323 = xlsread('5A_russo.xlsx','Pachinko2','A1:I13');
Pachinko2_3D1_russo_0323 = xlsread('3D_gruppo1_russo.xlsx','Pachinko2','A1:I10');
Pachinko2_3D1_russo_0323(7,:)=[];
Pachinko2_3D2_russo_0323 = xlsread('3D_gruppo2_russo.xlsx','Pachinko2','A1:I10');
Pachinko2_5E_russo_0323 = xlsread('5E_russo.xlsx','Pachinko2','A1:I15');
Pachinko2_3C_russo_0323 = xlsread('3C_russo.xlsx','Pachinko2','A1:I14');
Pachinko2_4C_russo_0323 = xlsread('4C_russo.xlsx','Pachinko2','A1:I13');
Pachinko2_5B_russo_0323 = xlsread('5B_russo.xlsx','Pachinko2','A1:I17');
Pachinko2_5F_russo_0323 = xlsread('5F_russo.xlsx','Pachinko2','A1:I17');
Pachinko2_3F_russo_0323 = xlsread('3F_russo.xlsx','Pachinko2','A1:I12');

%%

Pachinko2_4B_fatale_0323(:,2) = 4.*ones(size(Pachinko2_4B_fatale_0323,1),1);
Pachinko2_4A_marconi_0323(:,2) = 4.*ones(size(Pachinko2_4A_marconi_0323,1),1);
Pachinko2_4B_trincone_0323(:,2) = 4.*ones(size(Pachinko2_4B_trincone_0323,1),1);
Pachinko2_4A_trincone_0323(:,2) = 4.*ones(size(Pachinko2_4A_trincone_0323,1),1);
Pachinko2_5A_trincone_0323(:,2) = 5.*ones(size(Pachinko2_5A_trincone_0323,1),1);
Pachinko2_4B1_marconi_0323(:,2) = 4.*ones(size(Pachinko2_4B1_marconi_0323,1),1);
Pachinko2_4B2_marconi_0323(:,2) = 4.*ones(size(Pachinko2_4B2_marconi_0323,1),1);
Pachinko2_3A1_fatale_0323(:,2) = 3.*ones(size(Pachinko2_3A1_fatale_0323,1),1);
Pachinko2_3A2_fatale_0323(:,2) = 3.*ones(size(Pachinko2_3A2_fatale_0323,1),1);
Pachinko2_4A_fatale_0323(:,2) = 4.*ones(size(Pachinko2_4A_fatale_0323,1),1);
Pachinko2_5A1_fatale_0323(:,2) = 5.*ones(size(Pachinko2_5A1_fatale_0323,1),1);
Pachinko2_3C_marconi_0323(:,2) = 3.*ones(size(Pachinko2_3C_marconi_0323,1),1);
Pachinko2_5A2_fatale_0323(:,2) = 5.*ones(size(Pachinko2_5A2_fatale_0323,1),1);
Pachinko2_3A1_marconi_0323(:,2) = 3.*ones(size(Pachinko2_3A1_marconi_0323,1),1);
Pachinko2_3A2_marconi_0323(:,2) = 3.*ones(size(Pachinko2_3A2_marconi_0323,1),1);
Pachinko2_3B_marconi_0323(:,2) = 3.*ones(size(Pachinko2_3B_marconi_0323,1),1);
Pachinko2_5B_fatale_0323(:,2) = 5.*ones(size(Pachinko2_5B_fatale_0323,1),1);
Pachinko2_4C1_marconi_0323(:,2) = 4.*ones(size(Pachinko2_4C1_marconi_0323,1),1);
Pachinko2_4C2_marconi_0323(:,2) = 4.*ones(size(Pachinko2_4C2_marconi_0323,1),1);
Pachinko2_5A1_marconi_0323(:,2) = 5.*ones(size(Pachinko2_5A1_marconi_0323,1),1);
Pachinko2_5A2_marconi_0323(:,2) = 5.*ones(size(Pachinko2_5A2_marconi_0323,1),1);
Pachinko2_5C1_marconi_0323(:,2) = 5.*ones(size(Pachinko2_5C1_marconi_0323,1),1);
Pachinko2_5C2_marconi_0323(:,2) = 5.*ones(size(Pachinko2_5C2_marconi_0323,1),1);
Pachinko2_5B_marconi_0323(:,2) = 5.*ones(size(Pachinko2_5B_marconi_0323,1),1);

Pachinko2_4E_russo_0323(:,2) = 4.*ones(size(Pachinko2_4E_russo_0323,1),1);
Pachinko2_4F_russo_0323(:,2) = 4.*ones(size(Pachinko2_4F_russo_0323,1),1);
Pachinko2_4A_russo_0323(:,2) = 4.*ones(size(Pachinko2_4A_russo_0323,1),1);
Pachinko2_5A_russo_0323(:,2) = 5.*ones(size(Pachinko2_5A_russo_0323,1),1);
Pachinko2_3D1_russo_0323(:,2) = 3.*ones(size(Pachinko2_3D1_russo_0323,1),1);
Pachinko2_3D2_russo_0323(:,2) = 3.*ones(size(Pachinko2_3D2_russo_0323,1),1);
Pachinko2_5E_russo_0323(:,2) = 5.*ones(size(Pachinko2_5E_russo_0323,1),1);
Pachinko2_3C_russo_0323(:,2) = 3.*ones(size(Pachinko2_3C_russo_0323,1),1);
Pachinko2_4C_russo_0323(:,2) = 4.*ones(size(Pachinko2_4C_russo_0323,1),1);
Pachinko2_5B_russo_0323(:,2) = 5.*ones(size(Pachinko2_5B_russo_0323,1),1);
Pachinko2_5F_russo_0323(:,2) = 5.*ones(size(Pachinko2_5F_russo_0323,1),1);
Pachinko2_3F_russo_0323(:,2) = 3.*ones(size(Pachinko2_3F_russo_0323,1),1);


Pachinko2_4B_fatale_0323(:,11) = Pachinko2_4B_fatale_0323(:,6).*Pachinko2_4B_fatale_0323(:,7); 
Pachinko2_4A_marconi_0323(:,11) = Pachinko2_4A_marconi_0323(:,6).*Pachinko2_4A_marconi_0323(:,7); 
Pachinko2_4B_trincone_0323(:,11) = Pachinko2_4B_trincone_0323(:,6).*Pachinko2_4B_trincone_0323(:,7); 
Pachinko2_4A_trincone_0323(:,11) = Pachinko2_4A_trincone_0323(:,6).*Pachinko2_4A_trincone_0323(:,7); 
Pachinko2_5A_trincone_0323(:,11) = Pachinko2_5A_trincone_0323(:,6).*Pachinko2_5A_trincone_0323(:,7); 
Pachinko2_4B1_marconi_0323(:,11) = Pachinko2_4B1_marconi_0323(:,6).*Pachinko2_4B1_marconi_0323(:,7); 
Pachinko2_4B2_marconi_0323(:,11) = Pachinko2_4B2_marconi_0323(:,6).*Pachinko2_4B2_marconi_0323(:,7); 
Pachinko2_3A1_fatale_0323(:,11) = Pachinko2_3A1_fatale_0323(:,6).*Pachinko2_3A1_fatale_0323(:,7); 
Pachinko2_3A2_fatale_0323(:,11) = Pachinko2_3A2_fatale_0323(:,6).*Pachinko2_3A2_fatale_0323(:,7); 
Pachinko2_4A_fatale_0323(:,11) = Pachinko2_4A_fatale_0323(:,6).*Pachinko2_4A_fatale_0323(:,7); 
Pachinko2_5A1_fatale_0323(:,11) = Pachinko2_5A1_fatale_0323(:,6).*Pachinko2_5A1_fatale_0323(:,7); 
Pachinko2_3C_marconi_0323(:,11) = Pachinko2_3C_marconi_0323(:,6).*Pachinko2_3C_marconi_0323(:,7); 
Pachinko2_5A2_fatale_0323(:,11) = Pachinko2_5A2_fatale_0323(:,6).*Pachinko2_5A2_fatale_0323(:,7); 
Pachinko2_3A1_marconi_0323(:,11) = Pachinko2_3A1_marconi_0323(:,6).*Pachinko2_3A1_marconi_0323(:,7); 
Pachinko2_3A2_marconi_0323(:,11) = Pachinko2_3A2_marconi_0323(:,6).*Pachinko2_3A2_marconi_0323(:,7); 
Pachinko2_3B_marconi_0323(:,11) = Pachinko2_3B_marconi_0323(:,6).*Pachinko2_3B_marconi_0323(:,7); 
Pachinko2_5B_fatale_0323(:,11) = Pachinko2_5B_fatale_0323(:,6).*Pachinko2_5B_fatale_0323(:,7); 
Pachinko2_4C1_marconi_0323(:,11) = Pachinko2_4C1_marconi_0323(:,6).*Pachinko2_4C1_marconi_0323(:,7); 
Pachinko2_4C2_marconi_0323(:,11) = Pachinko2_4C2_marconi_0323(:,6).*Pachinko2_4C2_marconi_0323(:,7); 
Pachinko2_5A1_marconi_0323(:,11) = Pachinko2_5A1_marconi_0323(:,6).*Pachinko2_5A1_marconi_0323(:,7); 
Pachinko2_5A2_marconi_0323(:,11) = Pachinko2_5A2_marconi_0323(:,6).*Pachinko2_5A2_marconi_0323(:,7); 
Pachinko2_5C1_marconi_0323(:,11) = Pachinko2_5C1_marconi_0323(:,6).*Pachinko2_5C1_marconi_0323(:,7); 
Pachinko2_5C2_marconi_0323(:,11) = Pachinko2_5C2_marconi_0323(:,6).*Pachinko2_5C2_marconi_0323(:,7); 
Pachinko2_5B_marconi_0323(:,11) = Pachinko2_5B_marconi_0323(:,6).*Pachinko2_5B_marconi_0323(:,7); 

Pachinko2_4E_russo_0323(:,11) = Pachinko2_4E_russo_0323(:,6).*Pachinko2_4E_russo_0323(:,7); 
Pachinko2_4F_russo_0323(:,11) = Pachinko2_4F_russo_0323(:,6).*Pachinko2_4F_russo_0323(:,7); 
Pachinko2_4A_russo_0323(:,11) = Pachinko2_4A_russo_0323(:,6).*Pachinko2_4A_russo_0323(:,7); 
Pachinko2_5A_russo_0323(:,11) = Pachinko2_5A_russo_0323(:,6).*Pachinko2_5A_russo_0323(:,7); 
Pachinko2_3D1_russo_0323(:,11) = Pachinko2_3D1_russo_0323(:,6).*Pachinko2_3D1_russo_0323(:,7); 
Pachinko2_3D2_russo_0323(:,11) = Pachinko2_3D2_russo_0323(:,6).*Pachinko2_3D2_russo_0323(:,7); 
Pachinko2_5E_russo_0323(:,11) = Pachinko2_5E_russo_0323(:,6).*Pachinko2_5E_russo_0323(:,7); 
Pachinko2_3C_russo_0323(:,11) = Pachinko2_3C_russo_0323(:,6).*Pachinko2_3C_russo_0323(:,7); 
Pachinko2_4C_russo_0323(:,11) = Pachinko2_4C_russo_0323(:,6).*Pachinko2_4C_russo_0323(:,7); 
Pachinko2_5B_russo_0323(:,11) = Pachinko2_5B_russo_0323(:,6).*Pachinko2_5B_russo_0323(:,7); 
Pachinko2_5F_russo_0323(:,11) = Pachinko2_5F_russo_0323(:,6).*Pachinko2_5F_russo_0323(:,7); 
Pachinko2_3F_russo_0323(:,11) = Pachinko2_3F_russo_0323(:,6).*Pachinko2_3F_russo_0323(:,7); 


Pachinko2_4B_fatale_0323(:,12) = Pachinko2_4B_fatale_0323(:,6).*Pachinko2_4B_fatale_0323(:,8); 
Pachinko2_4A_marconi_0323(:,12) = Pachinko2_4A_marconi_0323(:,6).*Pachinko2_4A_marconi_0323(:,8); 
Pachinko2_4B_trincone_0323(:,12) = Pachinko2_4B_trincone_0323(:,6).*Pachinko2_4B_trincone_0323(:,8); 
Pachinko2_4A_trincone_0323(:,12) = Pachinko2_4A_trincone_0323(:,6).*Pachinko2_4A_trincone_0323(:,8); 
Pachinko2_5A_trincone_0323(:,12) = Pachinko2_5A_trincone_0323(:,6).*Pachinko2_5A_trincone_0323(:,8); 
Pachinko2_4B1_marconi_0323(:,12) = Pachinko2_4B1_marconi_0323(:,6).*Pachinko2_4B1_marconi_0323(:,8); 
Pachinko2_4B2_marconi_0323(:,12) = Pachinko2_4B2_marconi_0323(:,6).*Pachinko2_4B2_marconi_0323(:,8); 
Pachinko2_3A1_fatale_0323(:,12) = Pachinko2_3A1_fatale_0323(:,6).*Pachinko2_3A1_fatale_0323(:,8); 
Pachinko2_3A2_fatale_0323(:,12) = Pachinko2_3A2_fatale_0323(:,6).*Pachinko2_3A2_fatale_0323(:,8); 
Pachinko2_4A_fatale_0323(:,12) = Pachinko2_4A_fatale_0323(:,6).*Pachinko2_4A_fatale_0323(:,8); 
Pachinko2_5A1_fatale_0323(:,12) = Pachinko2_5A1_fatale_0323(:,6).*Pachinko2_5A1_fatale_0323(:,8); 
Pachinko2_3C_marconi_0323(:,12) = Pachinko2_3C_marconi_0323(:,6).*Pachinko2_3C_marconi_0323(:,8); 
Pachinko2_5A2_fatale_0323(:,12) = Pachinko2_5A2_fatale_0323(:,6).*Pachinko2_5A2_fatale_0323(:,8); 
Pachinko2_3A1_marconi_0323(:,12) = Pachinko2_3A1_marconi_0323(:,6).*Pachinko2_3A1_marconi_0323(:,8); 
Pachinko2_3A2_marconi_0323(:,12) = Pachinko2_3A2_marconi_0323(:,6).*Pachinko2_3A2_marconi_0323(:,8); 
Pachinko2_3B_marconi_0323(:,12) = Pachinko2_3B_marconi_0323(:,6).*Pachinko2_3B_marconi_0323(:,8); 
Pachinko2_5B_fatale_0323(:,12) = Pachinko2_5B_fatale_0323(:,6).*Pachinko2_5B_fatale_0323(:,8); 
Pachinko2_4C1_marconi_0323(:,12) = Pachinko2_4C1_marconi_0323(:,6).*Pachinko2_4C1_marconi_0323(:,8); 
Pachinko2_4C2_marconi_0323(:,12) = Pachinko2_4C2_marconi_0323(:,6).*Pachinko2_4C2_marconi_0323(:,8); 
Pachinko2_5A1_marconi_0323(:,12) = Pachinko2_5A1_marconi_0323(:,6).*Pachinko2_5A1_marconi_0323(:,8); 
Pachinko2_5A2_marconi_0323(:,12) = Pachinko2_5A2_marconi_0323(:,6).*Pachinko2_5A2_marconi_0323(:,8); 
Pachinko2_5C1_marconi_0323(:,12) = Pachinko2_5C1_marconi_0323(:,6).*Pachinko2_5C1_marconi_0323(:,8); 
Pachinko2_5C2_marconi_0323(:,12) = Pachinko2_5C2_marconi_0323(:,6).*Pachinko2_5C2_marconi_0323(:,8); 
Pachinko2_5B_marconi_0323(:,12) = Pachinko2_5B_marconi_0323(:,6).*Pachinko2_5B_marconi_0323(:,8); 

Pachinko2_4E_russo_0323(:,12) = Pachinko2_4E_russo_0323(:,6).*Pachinko2_4E_russo_0323(:,8); 
Pachinko2_4F_russo_0323(:,12) = Pachinko2_4F_russo_0323(:,6).*Pachinko2_4F_russo_0323(:,8); 
Pachinko2_4A_russo_0323(:,12) = Pachinko2_4A_russo_0323(:,6).*Pachinko2_4A_russo_0323(:,8); 
Pachinko2_5A_russo_0323(:,12) = Pachinko2_5A_russo_0323(:,6).*Pachinko2_5A_russo_0323(:,8); 
Pachinko2_3D1_russo_0323(:,12) = Pachinko2_3D1_russo_0323(:,6).*Pachinko2_3D1_russo_0323(:,8); 
Pachinko2_3D2_russo_0323(:,12) = Pachinko2_3D2_russo_0323(:,6).*Pachinko2_3D2_russo_0323(:,8); 
Pachinko2_5E_russo_0323(:,12) = Pachinko2_5E_russo_0323(:,6).*Pachinko2_5E_russo_0323(:,8); 
Pachinko2_3C_russo_0323(:,12) = Pachinko2_3C_russo_0323(:,6).*Pachinko2_3C_russo_0323(:,8); 
Pachinko2_4C_russo_0323(:,12) = Pachinko2_4C_russo_0323(:,6).*Pachinko2_4C_russo_0323(:,8); 
Pachinko2_5B_russo_0323(:,12) = Pachinko2_5B_russo_0323(:,6).*Pachinko2_5B_russo_0323(:,8); 
Pachinko2_5F_russo_0323(:,12) = Pachinko2_5F_russo_0323(:,6).*Pachinko2_5F_russo_0323(:,8); 
Pachinko2_3F_russo_0323(:,12) = Pachinko2_3F_russo_0323(:,6).*Pachinko2_3F_russo_0323(:,8);


Pachinko2_4B_fatale_0323(:,13) = Pachinko2_4B_fatale_0323(:,7).*Pachinko2_4B_fatale_0323(:,8); 
Pachinko2_4A_marconi_0323(:,13) = Pachinko2_4A_marconi_0323(:,7).*Pachinko2_4A_marconi_0323(:,8); 
Pachinko2_4B_trincone_0323(:,13) = Pachinko2_4B_trincone_0323(:,7).*Pachinko2_4B_trincone_0323(:,8); 
Pachinko2_4A_trincone_0323(:,13) = Pachinko2_4A_trincone_0323(:,7).*Pachinko2_4A_trincone_0323(:,8); 
Pachinko2_5A_trincone_0323(:,13) = Pachinko2_5A_trincone_0323(:,7).*Pachinko2_5A_trincone_0323(:,8); 
Pachinko2_4B1_marconi_0323(:,13) = Pachinko2_4B1_marconi_0323(:,7).*Pachinko2_4B1_marconi_0323(:,8); 
Pachinko2_4B2_marconi_0323(:,13) = Pachinko2_4B2_marconi_0323(:,7).*Pachinko2_4B2_marconi_0323(:,8); 
Pachinko2_3A1_fatale_0323(:,13) = Pachinko2_3A1_fatale_0323(:,7).*Pachinko2_3A1_fatale_0323(:,8); 
Pachinko2_3A2_fatale_0323(:,13) = Pachinko2_3A2_fatale_0323(:,7).*Pachinko2_3A2_fatale_0323(:,8); 
Pachinko2_4A_fatale_0323(:,13) = Pachinko2_4A_fatale_0323(:,7).*Pachinko2_4A_fatale_0323(:,8); 
Pachinko2_5A1_fatale_0323(:,13) = Pachinko2_5A1_fatale_0323(:,7).*Pachinko2_5A1_fatale_0323(:,8); 
Pachinko2_3C_marconi_0323(:,13) = Pachinko2_3C_marconi_0323(:,7).*Pachinko2_3C_marconi_0323(:,8); 
Pachinko2_5A2_fatale_0323(:,13) = Pachinko2_5A2_fatale_0323(:,7).*Pachinko2_5A2_fatale_0323(:,8); 
Pachinko2_3A1_marconi_0323(:,13) = Pachinko2_3A1_marconi_0323(:,7).*Pachinko2_3A1_marconi_0323(:,8); 
Pachinko2_3A2_marconi_0323(:,13) = Pachinko2_3A2_marconi_0323(:,7).*Pachinko2_3A2_marconi_0323(:,8); 
Pachinko2_3B_marconi_0323(:,13) = Pachinko2_3B_marconi_0323(:,7).*Pachinko2_3B_marconi_0323(:,8); 
Pachinko2_5B_fatale_0323(:,13) = Pachinko2_5B_fatale_0323(:,7).*Pachinko2_5B_fatale_0323(:,8); 
Pachinko2_4C1_marconi_0323(:,13) = Pachinko2_4C1_marconi_0323(:,7).*Pachinko2_4C1_marconi_0323(:,8); 
Pachinko2_4C2_marconi_0323(:,13) = Pachinko2_4C2_marconi_0323(:,7).*Pachinko2_4C2_marconi_0323(:,8); 
Pachinko2_5A1_marconi_0323(:,13) = Pachinko2_5A1_marconi_0323(:,7).*Pachinko2_5A1_marconi_0323(:,8); 
Pachinko2_5A2_marconi_0323(:,13) = Pachinko2_5A2_marconi_0323(:,7).*Pachinko2_5A2_marconi_0323(:,8); 
Pachinko2_5C1_marconi_0323(:,13) = Pachinko2_5C1_marconi_0323(:,7).*Pachinko2_5C1_marconi_0323(:,8); 
Pachinko2_5C2_marconi_0323(:,13) = Pachinko2_5C2_marconi_0323(:,7).*Pachinko2_5C2_marconi_0323(:,8); 
Pachinko2_5B_marconi_0323(:,13) = Pachinko2_5B_marconi_0323(:,7).*Pachinko2_5B_marconi_0323(:,8); 

Pachinko2_4E_russo_0323(:,13) = Pachinko2_4E_russo_0323(:,7).*Pachinko2_4E_russo_0323(:,8); 
Pachinko2_4F_russo_0323(:,13) = Pachinko2_4F_russo_0323(:,7).*Pachinko2_4F_russo_0323(:,8); 
Pachinko2_4A_russo_0323(:,13) = Pachinko2_4A_russo_0323(:,7).*Pachinko2_4A_russo_0323(:,8); 
Pachinko2_5A_russo_0323(:,13) = Pachinko2_5A_russo_0323(:,7).*Pachinko2_5A_russo_0323(:,8); 
Pachinko2_3D1_russo_0323(:,13) = Pachinko2_3D1_russo_0323(:,7).*Pachinko2_3D1_russo_0323(:,8); 
Pachinko2_3D2_russo_0323(:,13) = Pachinko2_3D2_russo_0323(:,7).*Pachinko2_3D2_russo_0323(:,8); 
Pachinko2_5E_russo_0323(:,13) = Pachinko2_5E_russo_0323(:,7).*Pachinko2_5E_russo_0323(:,8); 
Pachinko2_3C_russo_0323(:,13) = Pachinko2_3C_russo_0323(:,7).*Pachinko2_3C_russo_0323(:,8); 
Pachinko2_4C_russo_0323(:,13) = Pachinko2_4C_russo_0323(:,7).*Pachinko2_4C_russo_0323(:,8); 
Pachinko2_5B_russo_0323(:,13) = Pachinko2_5B_russo_0323(:,7).*Pachinko2_5B_russo_0323(:,8); 
Pachinko2_5F_russo_0323(:,13) = Pachinko2_5F_russo_0323(:,7).*Pachinko2_5F_russo_0323(:,8); 
Pachinko2_3F_russo_0323(:,13) = Pachinko2_3F_russo_0323(:,7).*Pachinko2_3F_russo_0323(:,8); 

Pachinko_2ndwave = [Pachinko2_4A_trincone_0323;
Pachinko2_4B_trincone_0323;
Pachinko2_5A_trincone_0323;
Pachinko2_3A1_fatale_0323;
Pachinko2_3A2_fatale_0323;
Pachinko2_4A_fatale_0323;
Pachinko2_5A1_fatale_0323;
Pachinko2_5A2_fatale_0323;
Pachinko2_5B_fatale_0323;
Pachinko2_4B_fatale_0323;
Pachinko2_4A_marconi_0323;
Pachinko2_3A1_marconi_0323;
Pachinko2_3A2_marconi_0323;
Pachinko2_3B_marconi_0323;
Pachinko2_3C_marconi_0323;
Pachinko2_4B1_marconi_0323;
Pachinko2_4B2_marconi_0323;
Pachinko2_4C1_marconi_0323;
Pachinko2_4C2_marconi_0323;
Pachinko2_5A1_marconi_0323;
Pachinko2_5A2_marconi_0323;
Pachinko2_5B_marconi_0323;
Pachinko2_5C1_marconi_0323;
Pachinko2_5C2_marconi_0323;
Pachinko2_3C_russo_0323;
Pachinko2_4C_russo_0323;
Pachinko2_4E_russo_0323;
Pachinko2_4F_russo_0323;
Pachinko2_4A_russo_0323;
Pachinko2_5A_russo_0323;
Pachinko2_5B_russo_0323;
Pachinko2_5F_russo_0323;
Pachinko2_3D1_russo_0323;
Pachinko2_3D2_russo_0323;
Pachinko2_3F_russo_0323;
Pachinko2_5E_russo_0323;];









