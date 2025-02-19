%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LOADING THE DATA - PENCILS/PENS CHOICE TASK %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numbers1805A = xlsread('1D_gruppo1_russo.xlsx','Choices menus'); %#ok<XLSRD> 

numbers1805B = xlsread('1D_gruppo2_russo.xlsx','Choices menus'); %#ok<XLSRD> 
a=numbers1805B(:,2)==1; % remember to eliminate the first ID - the student was problematic
numbers1805B(a,:)=[];
numbers1805B(end,:)=[];
 
numbers1805C = xlsread('1E_gruppo1_russo.xlsx','Choices menus'); %#ok<XLSRD> 
a=numbers1805C(:,2)==3; % remember to eliminate the first ID - the student was problematic
numbers1805C(a,:)=[];

numbers19053C = xlsread('3C_gruppo1_russo.xlsx','Choices menus'); %#ok<XLSRD> 

numbers19053_IEID = xlsread('Assenti_1E_1D_russo.xlsx','Choices menus'); %#ok<XLSRD> 

numbers1905_IA1 = xlsread('1A_gruppo1_russo.xlsx','Choices menus'); %#ok<XLSRD> 

numbers1905_IA2 = xlsread('1A_gruppo2_russo.xlsx','Choices menus'); %#ok<XLSRD> 


numbers_2A_trincone_181022 = xlsread('2A_trincone.xlsx','Choices menus');
numbers_4A_trincone_181022 = xlsread('4A_trincone.xlsx','Choices menus');
numbers_4B_trincone_181022 = xlsread('4B_trincone.xlsx','Choices menus');
numbers_5A_trincone_181022 = xlsread('5A_trincone.xlsx','Choices menus');

numbers_1A_trincone_191022 = xlsread('1A_trincone.xlsx','Choices menus');
numbers_3A1_fatale_191022 = xlsread('3A_fatale_gruppo1.xlsx','Choices menus');
numbers_3A2_fatale_191022 = xlsread('3A_fatale_gruppo2.xlsx','Choices menus');
numbers_4A_fatale_191022 = xlsread('4A_fatale.xlsx','Choices menus');
numbers_5A1_fatale_191022 = xlsread('5A_fatale_gruppo1.xlsx','Choices menus');
numbers_5A2_fatale_191022 = xlsread('5A_fatale_gruppo2.xlsx','Choices menus');
numbers_5B_fatale_191022 = xlsread('5B_fatale.xlsx','Choices menus');

numbers_1A_fatale_201022 = xlsread('1A_fatale.xlsx','Choices menus');
numbers_1B_fatale_201022 = xlsread('1B_fatale.xlsx','Choices menus');
numbers_2A_fatale_201022 = xlsread('2A_fatale.xlsx','Choices menus');
a=numbers_2A_fatale_201022(:,2)==2; % we do not have logic test results for this id
numbers_2A_fatale_201022(a,:)=[];


numbers_2B_fatale_201022 = xlsread('2B_fatale.xlsx','Choices menus');
numbers_4B_fatale_201022 = xlsread('4B_fatale.xlsx','Choices menus');

numbers_1A1_marconi_211022 = xlsread('1A_marconi_gruppo1.xlsx','Choices menus');
numbers_1A2_marconi_211022 = xlsread('1A_marconi_gruppo2.xlsx','Choices menus');
numbers_1B1_marconi_211022 = xlsread('1B_marconi_gruppo1.xlsx','Choices menus');
numbers_1B2_marconi_211022 = xlsread('1B_marconi_gruppo2.xlsx','Choices menus');
numbers_2B_marconi_211022 = xlsread('2B_marconi.xlsx','Choices menus');
numbers_4A_marconi_211022 = xlsread('4A_marconi.xlsx','Choices menus');

numbers_2C1_marconi_241022 = xlsread('2C_marconi_gruppo1.xlsx','Choices menus');
numbers_2C2_marconi_241022 = xlsread('2C_marconi_gruppo2.xlsx','Choices menus');
numbers_3A1_marconi_241022 = xlsread('3A_marconi_gruppo1.xlsx','Choices menus');
numbers_3A2_marconi_241022 = xlsread('3A_marconi_gruppo2.xlsx','Choices menus');
numbers_3B_marconi_241022 = xlsread('3B_marconi.xlsx','Choices menus');
numbers_3C_marconi_241022 = xlsread('3C_marconi.xlsx','Choices menus');

numbers_2B1_marconi_251022 = xlsread('2B_marconi_gruppo1.xlsx','Choices menus');
numbers_2B2_marconi_251022 = xlsread('2B_marconi_gruppo2.xlsx','Choices menus');
numbers_4B1_marconi_251022 = xlsread('4B_marconi_gruppo1.xlsx','Choices menus');
a=numbers_4B1_marconi_251022(:,2)==15; % choice of pachinko was wrong
numbers_4B1_marconi_251022(a,:)=[];
numbers_4B2_marconi_251022 = xlsread('4B_marconi_gruppo2.xlsx','Choices menus');
numbers_4C1_marconi_251022 = xlsread('4C_marconi_gruppo1.xlsx','Choices menus');
numbers_4C2_marconi_251022 = xlsread('4C_marconi_gruppo2.xlsx','Choices menus');
numbers_5A1_marconi_251022 = xlsread('5A_marconi_gruppo1.xlsx','Choices menus');
numbers_5A2_marconi_251022 = xlsread('5A_marconi_gruppo2.xlsx','Choices menus');

numbers_5B_marconi_261022 = xlsread('5B_marconi.xlsx','Choices menus');
numbers_5C1_marconi_261022 = xlsread('5C_marconi_gruppo1.xlsx','Choices menus');
numbers_5C2_marconi_261022 = xlsread('5C_marconi_gruppo2.xlsx','Choices menus');

numbers_1B_russo_141122 = xlsread('1B_russo.xlsx','Choices menus');
numbers_1C1_russo_141122 = xlsread('1C_russo_gruppo1.xlsx','Choices menus');
numbers_1C2_russo_141122 = xlsread('1C_russo_gruppo2.xlsx','Choices menus');
numbers_1E_russo_141122 = xlsread('1E_russo.xlsx','Choices menus');

numbers_1F_russo_151122 = xlsread('1F_russo.xlsx','Choices menus');
numbers_2A_russo_151122 = xlsread('2A_russo.xlsx','Choices menus');
numbers_2B_russo_151122 = xlsread('2B_russo.xlsx','Choices menus');

numbers_3C_russo_161122 = xlsread('3C_russo.xlsx','Choices menus');
numbers_4C_russo_161122 = xlsread('4C_russo.xlsx','Choices menus');
numbers_4E_russo_161122 = xlsread('4E_russo.xlsx','Choices menus');
numbers_4F_russo_161122 = xlsread('4F_russo.xlsx','Choices menus');

numbers_4A_russo_171122 = xlsread('4A_russo.xlsx','Choices menus');
a=numbers_4A_russo_171122(:,2)==6; % the student did not solve the Pachinko
numbers_4A_russo_171122(a,:)=[];
numbers_5A_russo_171122 = xlsread('5A_russo.xlsx','Choices menus');
numbers_5B_russo_171122 = xlsread('5B_russo.xlsx','Choices menus');
numbers_5F_russo_171122 = xlsread('5F_russo.xlsx','Choices menus');

numbers_3D1_russo_181122 = xlsread('3D_gruppo1_russo.xlsx','Choices menus');
a=numbers_3D1_russo_181122(:,2)==9; % remember to eliminate the first ID - the student was problematic
numbers_3D1_russo_181122(a,:)=[];
numbers_3D2_russo_181122 = xlsread('3D_gruppo2_russo.xlsx','Choices menus');
a=numbers_3D2_russo_181122(:,2)==6; % remember to eliminate the first ID - the student was problematic
numbers_3D2_russo_181122(a,:)=[];
numbers_3F_russo_181122 = xlsread('3F_russo.xlsx','Choices menus');
numbers_5E_russo_181122 = xlsread('5E_russo.xlsx','Choices menus');

numbers = [numbers1805A;numbers1805B;numbers1805C;numbers19053C;numbers19053_IEID;numbers1905_IA1;numbers1905_IA2;
    numbers_2A_trincone_181022;numbers_4A_trincone_181022;numbers_4B_trincone_181022;numbers_5A_trincone_181022;
    numbers_1A_trincone_191022;numbers_3A1_fatale_191022;numbers_3A2_fatale_191022;numbers_4A_fatale_191022;numbers_5A1_fatale_191022;numbers_5A2_fatale_191022;numbers_5B_fatale_191022;
    numbers_4B_fatale_201022; numbers_1A_fatale_201022;numbers_1B_fatale_201022;numbers_2A_fatale_201022;numbers_2B_fatale_201022;
    numbers_4A_marconi_211022; numbers_1A1_marconi_211022;numbers_1A2_marconi_211022;numbers_1B1_marconi_211022;numbers_1B2_marconi_211022;numbers_2B_marconi_211022;
    numbers_2C1_marconi_241022;numbers_2C2_marconi_241022;numbers_3A1_marconi_241022;numbers_3A2_marconi_241022;numbers_3B_marconi_241022;numbers_3C_marconi_241022;
    numbers_2B1_marconi_251022;numbers_2B2_marconi_251022;numbers_4B1_marconi_251022;numbers_4B2_marconi_251022;numbers_4C1_marconi_251022;numbers_4C2_marconi_251022;numbers_5A1_marconi_251022;numbers_5A2_marconi_251022;
    numbers_5B_marconi_261022;numbers_5C1_marconi_261022;numbers_5C2_marconi_261022;
    numbers_1B_russo_141122; numbers_1C1_russo_141122; numbers_1C2_russo_141122; numbers_1E_russo_141122;
    numbers_1F_russo_151122; numbers_2A_russo_151122; numbers_2B_russo_151122;
    numbers_3C_russo_161122; numbers_4C_russo_161122; numbers_4E_russo_161122; numbers_4F_russo_161122;
    numbers_4A_russo_171122; numbers_5A_russo_171122; numbers_5B_russo_171122; numbers_5F_russo_171122;
    numbers_3D1_russo_181122; numbers_3D2_russo_181122; numbers_3F_russo_181122; numbers_5E_russo_181122];

NUMBERS = {numbers1805A;numbers1805B;numbers1805C;numbers19053C;numbers19053_IEID;numbers1905_IA1;numbers1905_IA2;
    numbers_2A_trincone_181022;numbers_4A_trincone_181022;numbers_4B_trincone_181022;numbers_5A_trincone_181022;
    numbers_1A_trincone_191022;numbers_3A1_fatale_191022;numbers_3A2_fatale_191022;numbers_4A_fatale_191022;numbers_5A1_fatale_191022;numbers_5A2_fatale_191022;numbers_5B_fatale_191022;
    numbers_4B_fatale_201022; numbers_1A_fatale_201022;numbers_1B_fatale_201022;numbers_2A_fatale_201022;numbers_2B_fatale_201022;
    numbers_4A_marconi_211022; numbers_1A1_marconi_211022;numbers_1A2_marconi_211022;numbers_1B1_marconi_211022;numbers_1B2_marconi_211022;numbers_2B_marconi_211022;
    numbers_2C1_marconi_241022;numbers_2C2_marconi_241022;numbers_3A1_marconi_241022;numbers_3A2_marconi_241022;numbers_3B_marconi_241022;numbers_3C_marconi_241022;
    numbers_2B1_marconi_251022;numbers_2B2_marconi_251022;numbers_4B1_marconi_251022;numbers_4B2_marconi_251022;numbers_4C1_marconi_251022;numbers_4C2_marconi_251022;numbers_5A1_marconi_251022;numbers_5A2_marconi_251022;
    numbers_5B_marconi_261022;numbers_5C1_marconi_261022;numbers_5C2_marconi_261022;
    numbers_1B_russo_141122; numbers_1C1_russo_141122; numbers_1C2_russo_141122; numbers_1E_russo_141122;
    numbers_1F_russo_151122; numbers_2A_russo_151122; numbers_2B_russo_151122;
    numbers_3C_russo_161122; numbers_4C_russo_161122; numbers_4E_russo_161122; numbers_4F_russo_161122;
    numbers_4A_russo_171122; numbers_5A_russo_171122; numbers_5B_russo_171122; numbers_5F_russo_171122;
    numbers_3D1_russo_181122; numbers_3D2_russo_181122; numbers_3F_russo_181122; numbers_5E_russo_181122};
