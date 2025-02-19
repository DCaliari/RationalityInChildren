clear

import delimited "C:\Users\caliari\Dropbox\Rationality in Children\Replication Package\stored_datasets\unified_data.csv"

save "C:\Users\caliari\Dropbox\Rationality in Children\Replication Package\stored_datasets\unified_data.dta", replace

clear

import delimited "C:\Users\caliari\Dropbox\Rationality in Children\Replication Package\stored_datasets\structural_variables_dataset.csv"

save "C:\Users\caliari\Dropbox\Rationality in Children\Replication Package\stored_datasets\structural_variables_dataset.dta", replace

clear

import delimited "C:\Users\caliari\Dropbox\Rationality in Children\Replication Package\stored_datasets\unified_data.csv"

merge 1:1 group id_spec using "C:\Users\caliari\Dropbox\Rationality in Children\Replication Package\stored_datasets\structural_variables_dataset.dta"

****** missing values *******

mi set wide

* if the age is not credible it is substituted with a missing value

replace age_child = . if age_child < 1000

replace age_mother = . if age_mother < 3000		

replace age_father = . if age_father < 3000


****** GENERATE VARIABLES *********

gen s1 = (school==1)
gen s2 = (school==2)
gen s3 = (school==3)
gen s4 = (school==4)

** school parents
gen SN_mother=0
replace SN_mother = 1 if school_mother == "Nessun titolo di studio"
gen S1_mother=0
replace S1_mother = 1 if school_mother == "Scuola secondaria di 1Âº grado (Licenza media)"
gen S2_mother=0
replace S2_mother = 1 if school_mother =="Scuola secondaria di 2Âº grado (diploma di istruzione liceale, diploma di istruzione tecnica, diploma di istruzione professionale)"
gen SP_mother=0
replace SP_mother = 1 if school_mother == "Scuola primaria (Licenza elementare)"
gen SLS_mother=0
replace SLS_mother = 1 if school_mother == "Laurea specialistica" | school_mother == "Laurea Specialistica"
gen SLT_mother=0
replace SLT_mother = 1 if school_mother == "Laurea triennale"
gen SD_mother=0
replace SD_mother = 1 if school_mother == "Dottorato di ricerca"


gen SN_father=0
replace SN_father = 1 if school_father == "Nessun titolo di studio"
gen S1_father=0
replace S1_father = 1 if school_father == "Scuola secondaria di 1Âº grado (Licenza media)"
gen S2_father=0
replace S2_father = 1 if school_father =="Scuola secondaria di 2Âº grado (diploma di istruzione liceale, diploma di istruzione tecnica, diploma di istruzione professionale)"
gen SP_father=0
replace SP_father = 1 if school_father == "Scuola primaria (Licenza elementare)"
gen SLS_father=0
replace SLS_father = 1 if school_father == "Laurea specialistica" | school_father == "Laurea Specialistica"
gen SLT_father=0
replace SLT_father = 1 if school_father == "Laurea triennale"
gen SD_father=0
replace SD_father = 1 if school_father == "Dottorato di ricerca"


gen SD_parents=0
replace SD_parents = 1 if SD_mother ==1 | SD_father == 1
gen SLS_parents=0
replace SLS_parents = 1 if (SLS_mother == 1 | SLS_father == 1) & SD_parents==0
gen SLT_parents=0
replace SLT_parents = 1 if (SLT_mother == 1 | SLT_father == 1) & (SD_parents==0 & SLS_parents == 0)
gen S2_parents=0
replace S2_parents = 1 if (S2_mother == 1 | S2_father == 1) & (SD_parents==0 & SLS_parents == 0 & SLT_parents == 0)
gen S1_parents=0
replace S1_parents = 1 if (S1_mother == 1 | S1_father == 1) & (SD_parents==0 & SLS_parents == 0 & SLT_parents == 0 & S2_parents == 0)
gen SP_parents=0
replace SP_parents = 1 if (SP_mother == 1 | SP_father == 1) & (SD_parents==0 & SLS_parents == 0 & SLT_parents == 0 & S2_parents == 0 & S1_parents == 0)
gen SN_parents=0
replace SN_parents = 1 if SN_mother == 1 & SN_father == 1

gen missing_S = school_mother == "" & school_father == "" 

*** create dummy variables with risk aversion measured using the card game

gen risk_loving = 0
replace risk_loving = 1 if treatment ~=. & ra_2w>4
gen risk_neutral = 0
replace risk_neutral = 1 if treatment ~=. & ra_2w==4
gen risk_averse = 0
replace risk_averse = 1 if treatment ~=. & ra_2w<4

gen t_rl = (treatment == 1)  * (risk_loving==1)
gen t_ra = (treatment == 1)  * (risk_averse==1)
gen t_rn = (treatment == 1)  * (risk_neutral==1)

*** create a dummy variable for the kids who failed in the card game

gen fail_ra2w =0 if ra_2w ~=.
replace fail_ra2w = 1 if ra_2w==0 | ra_2w==8

*** create a dummy variable for the kids who failed in the card game (first wave)

gen fail_ra =0 if treatment ~=.
replace fail_ra = 1 if ra==0 | ra==8

*** create dummy variables for the kids who failed in the pachinko independent (first/second wave)

gen fail_mon = 0 if treatment ~=.
gen fail_mon2w = 0 if ind1_2w ~=.
replace fail_mon2w = 1 if ind3_2w~=1 & ind1_2w ~=.
replace fail_mon = 1 if c3~=1 & treatment ~=.

gen succ_mon2w = 0 if ind1_2w ~=.
replace succ_mon2w = 1 if fail_mon2w~=1 & ind1_2w ~=.

*** create dummy variables for the kids who did not choose anything in the pachinko correlated

gen fail_corr = 0 if treatment ~=.
replace fail_corr = 1 if corr1_2w + corr2_2w + corr3_2w == 0

*** create variables with father/mother/parents education levels

gen father_edu = 0
replace father_edu = 1 if SP_father == 1
replace father_edu = 2 if S1_father == 1
replace father_edu = 3 if S2_father == 1
replace father_edu = 4 if SLT_father == 1
replace father_edu = 5 if SLS_father == 1
replace father_edu = 6 if SD_father == 1

table father_edu if missing==0, stat(mean age_father) stat(sd age_father)

gen mother_edu = 0
replace mother_edu = 1 if SP_mother == 1
replace mother_edu = 2 if S1_mother == 1
replace mother_edu = 3 if S2_mother == 1
replace mother_edu = 4 if SLT_mother == 1
replace mother_edu = 5 if SLS_mother == 1
replace mother_edu = 6 if SD_mother == 1

table mother_edu if missing==0, stat(mean age_mother) stat(sd age_mother)

gen parents_edu = 0
replace parents_edu = 1 if SP_parents == 1
replace parents_edu = 2 if S1_parents == 1
replace parents_edu = 3 if S2_parents == 1
replace parents_edu = 4 if SLT_parents == 1
replace parents_edu = 5 if SLS_parents == 1
replace parents_edu = 6 if SD_parents == 1
replace parents_edu = . if missing_S == 1

gen no_high = 0
replace no_high = 1 if parents_edu < 3 & parents_edu > 0
replace no_high =. if missing_S == 1
gen highschool = 0
replace highschool = 1 if parents_edu == 3
replace highschool =. if missing_S == 1
gen univ = 0
replace univ = 1 if parents_edu > 3
replace univ =. if missing_S == 1

*** repeated observations (few kids were observed twice spring and fall)

gen repeated1 = 1 if group==6 | group==7 | group==4
gen repeated2 = 1 if group==52 | group==55

*** generate WARP variables

gen warp1_2 = warp1^2
gen warp2_2 = warp2^2

gen tot_warp = warp1+warp2
gen tot_warp_2 = tot_warp^2

*** normalize between 0 and 1 raven, consistency and risk aversion

gen raven_norm = raven/8
gen warp_norm = tot_warp/26

gen consistency = 1-warp_norm

gen consistency_pencils = 1-(warp1/13)
gen consistency_pens = 1-(warp2/13)

gen ra_norm = (ra_2w-1)/6

*** create a variable for preference intensity

gen cv_total = cv_slider_pencils + cv_slider_pens

*** define dummy for school High and school L

gen schoolMR = 0 if s1==1
replace schoolMR = 1 if s4==1

*** unify the schools

gen schoolHL = 0 if s1==1
replace schoolHL = 1 if s1~=1

*** school L, M, H

gen schoolM = 0 
replace schoolM = 1 if s2==1 | s3==1

*** generate a variable for kids who were completely indifferent in stated preferences

gen indiff = 0
replace indiff =1 if cv_total==0

*** generate the multinomial variables for the pachinko and card game

gen CORR = 1 if corr1_2w==1
replace CORR = 2 if corr2_2w==1
replace CORR = 3 if corr3_2w==1

gen IND = 1 if ind1_2w==1
replace IND = 2 if ind2_2w==1
replace IND = 3 if ind3_2w==1

gen risk = 1 if risk_averse==1
replace risk = 2 if risk_neutral==1
replace risk = 3 if risk_loving==1

gen PAC1st = 1 if threes_twos ==1
replace PAC1st = 2 if threes_ones ==1
replace PAC1st = 3 if twos_ones ==1

*** generate dummy variable for those who violate FOSD in independent or correlated pachinko

gen fosd = 0 if ind1_2w ~=.
replace fosd = 1 if (ind3_2w==0 | corr3_2w ==0) & ind1_2w ~=.

*** normalize the classes to ease the interpretation of the constants in the regressions

gen class_norm = class-1

gen class3_norm = class-3

*** generate a dummy for grades to look for non-linearity

gen grade1 = 0 
gen grade2 = 0 
gen grade3 = 0
gen grade4 = 0 
gen grade5 = 0 

replace grade1 = 1 if class_norm == 0
replace grade2 = 1 if class_norm == 1
replace grade3 = 1 if class_norm == 2
replace grade4 = 1 if class_norm == 3
replace grade5 = 1 if class_norm == 4

*** standardize the variables to read them in terms of standard deviations

egen _raven_norm = std(raven_norm)
egen _consistency = std(consistency)
egen _cv_total = std(cv_total)
egen _ra_2w = std(ra_norm)

*** generate a dummy variable for the few groups collected in spring

gen spring =0
replace spring = 1 if group<8


** generate approximate bayesian

gen rhoapprox = (rho14_pencilsfinal + rho14_pensfinal)/2



***********************************************************************************************************
********* MAIN REGRESSIONS - unconditional + conditional ************** without spring ************************** normalized but not standardized *******************
************************** PENCILS ************************************************************************
************************ TABLE 5 ****************************************************************

reg rhoind_pencils raven_norm cv_slider_pencils gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, replace ctitle(Rho)
reg rhoind_pencils grade2 grade3 grade4 grade5 cv_slider_pencils gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils parents_edu cv_slider_pencils gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils raven_norm grade2 grade3 grade4 grade5 parents_edu cv_slider_pencils gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils raven_norm cv_slider_pencils gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils grade2 grade3 grade4 grade5 cv_slider_pencils gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils parents_edu cv_slider_pencils gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils raven_norm grade2 grade3 grade4 grade5 parents_edu cv_slider_pencils gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)

*** correlations in the text, section 6.1

pwcorr raven_norm gender class_norm parents_edu if (s1==1 | s4==1) & ~spring, star(0.01)

reg rhoind_pencils raven_norm class3_norm parents_edu cv_slider_pencils gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)


***********************************************************************************************************
********* MAIN REGRESSIONS - unconditional + conditional ************** without spring ************************** normalized but not standardized *******************
************************** PENS ************************************************************************
************************ TABLE 9 ****************************************************************

reg rhoind_pens raven_norm cv_slider_pens gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, replace ctitle(Rho)
reg rhoind_pencils grade2 grade3 grade4 grade5 cv_slider_pens gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils parents_edu cv_slider_pens gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils raven_norm grade2 grade3 grade4 grade5 parents_edu cv_slider_pens gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils raven_norm cv_slider_pens gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils grade2 grade3 grade4 grade5 cv_slider_pens gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils parents_edu cv_slider_pens gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils raven_norm grade2 grade3 grade4 grade5 parents_edu cv_slider_pens gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)



***********************************************************************************************************
********* ALL SCHOOLS - unconditional + conditional ************** without spring ************************** normalized but not standardized *******************
************************** PENCILS ************************************************************************
************************* TABLE 12 *****************************************************************

reg rhoind_pencils raven_norm cv_slider_pencils gender if  ~spring, cluster(group)
outreg2 using c.xls, replace ctitle(Rho)
reg rhoind_pencils grade2 grade3 grade4 grade5 cv_slider_pencils gender if ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils parents_edu cv_slider_pencils gender if ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils raven_norm grade2 grade3 grade4 grade5 parents_edu cv_slider_pencils gender if  ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils raven_norm cv_slider_pencils gender schoolHL if  ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils grade2 grade3 grade4 grade5 cv_slider_pencils gender schoolHL if  ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils parents_edu cv_slider_pencils gender schoolHL if  ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils raven_norm grade2 grade3 grade4 grade5 parents_edu cv_slider_pencils gender schoolHL if  ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)

***********************************************************************************************************
********* ALL SCHOOLS - unconditional + conditional ************** without spring ************************** normalized but not standardized *******************
************************** PENS ************************************************************************
*************************** TABLE 13 ******************************************************************


reg rhoind_pens raven_norm cv_slider_pens gender if  ~spring, cluster(group)
outreg2 using c.xls, replace ctitle(Rho)
reg rhoind_pens grade2 grade3 grade4 grade5 cv_slider_pens gender if ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pens parents_edu cv_slider_pens gender if ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pens raven_norm grade2 grade3 grade4 grade5 parents_edu cv_slider_pens gender if  ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pens raven_norm cv_slider_pens gender schoolHL if  ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pens grade2 grade3 grade4 grade5 cv_slider_pens gender schoolHL if  ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pens parents_edu cv_slider_pens gender schoolHL if  ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pens raven_norm grade2 grade3 grade4 grade5 parents_edu cv_slider_pens gender schoolHL if  ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)



***********************************************************************************************************
********* MAIN REGRESSION - unconditional + conditional ************** without spring ************************** normalized but not standardized *******************
************************** RAVEN ************************************************************************
************************** TABLE 8 *****************************************************************


reg raven_norm grade2 grade3 grade4 grade5 gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, replace ctitle(Raven)
reg raven_norm parents_edu gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Raven)
reg raven_norm grade2 grade3 grade4 grade5 parents_edu gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Raven)
reg raven_norm grade2 grade3 grade4 grade5 gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Raven)
reg raven_norm parents_edu gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Raven)
reg raven_norm grade2 grade3 grade4 grade5 parents_edu gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Raven)




reg raven_norm class_norm parents_edu gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Raven)


***********************************************************************************************************
********* ALL SCHOOLS - unconditional + conditional ************** without spring ************************** normalized but not standardized *******************
************************** RAVEN ************************************************************************
***************************** TABLE 15 *************************************************************


reg raven_norm grade2 grade3 grade4 grade5 gender if ~spring, cluster(group)
outreg2 using c.xls, replace ctitle(Raven)
reg raven_norm parents_edu gender if ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Raven)
reg raven_norm grade2 grade3 grade4 grade5 parents_edu gender if  ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Raven)
reg raven_norm grade2 grade3 grade4 grade5 gender schoolHL if  ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Raven)
reg raven_norm parents_edu gender schoolHL if  ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Raven)
reg raven_norm grade2 grade3 grade4 grade5 parents_edu gender schoolHL if  ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Raven)


***********************************************************************************************************
********* MAIN REGRESSIONS (Logit) - unconditional + conditional ************** without spring ************************** normalized but not standardized *******************
****************************** TABLE 7 *********************************************************

mlogit CORR raven_norm gender succ_mon2w if  (s1==1 |s4==1) & class>2 & fail_corr==0, cluster(group) b(1) noomit
outreg2 using c.xls, replace ctitle(Correlation Neglect)
estat ic
mlogit CORR grade4 grade5  gender succ_mon2w if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR parents_edu  gender succ_mon2w if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR raven_norm grade4 grade5 parents_edu  gender succ_mon2w if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit 
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR raven_norm  gender schoolMR succ_mon2w if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit 
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR grade4 grade5  gender schoolMR succ_mon2w if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR parents_edu  gender schoolMR succ_mon2w if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR raven_norm grade4 grade5 parents_edu gender schoolMR succ_mon2w if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic


***********************************************************************************************************
********* MAIN REGRESSIONS (Logit) - unconditional + conditional ************** without spring ************************** normalized but not standardized *******************
************************ TABLE 6 ***************************************************************

mlogit IND raven_norm gender  if  (s1==1 |s4==1) & class>2 & fail_corr==0, cluster(group) b(1) noomit
outreg2 using c.xls, replace ctitle(Independent Task)
estat ic
mlogit IND grade4 grade5  gender  if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Independent Task)
estat ic
mlogit IND parents_edu  gender  if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Independent Task)
estat ic
mlogit IND raven_norm grade4 grade5 parents_edu  gender  if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit 
outreg2 using c.xls, append ctitle(Independent Task)
estat ic
mlogit IND raven_norm  gender schoolMR  if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit 
outreg2 using c.xls, append ctitle(Independent Task)
estat ic
mlogit IND grade4 grade5  gender schoolMR  if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Independent Task)
estat ic
mlogit IND parents_edu  gender schoolMR  if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Independent Task)
estat ic
mlogit IND raven_norm grade4 grade5 parents_edu gender schoolMR  if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Independent Task)
estat ic


***********************************************************************************************************
********* ALL SCHOOLS (Logit) - unconditional + conditional ************** without spring ************************** normalized but not standardized *******************
************************ TABLE 14a ***************************************************************

mlogit IND raven_norm gender  if  class>2 & fail_corr==0, cluster(group) b(1) noomit
outreg2 using c.xls, replace ctitle(Independent Task)
estat ic
mlogit IND grade4 grade5  gender  if  class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Independent Task)
estat ic
mlogit IND parents_edu  gender  if  class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Independent Task)
estat ic
mlogit IND raven_norm grade4 grade5 parents_edu  gender  if   class>2  & fail_corr==0, cluster(group) b(1)  noomit 
outreg2 using c.xls, append ctitle(Independent Task)
estat ic
mlogit IND raven_norm  gender schoolHL  if   class>2  & fail_corr==0, cluster(group) b(1)  noomit 
outreg2 using c.xls, append ctitle(Independent Task)
estat ic
mlogit IND grade4 grade5  gender schoolHL  if  class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Independent Task)
estat ic
mlogit IND parents_edu  gender schoolHL  if class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Independent Task)
estat ic
mlogit IND raven_norm grade4 grade5 parents_edu gender schoolHL  if class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Independent Task)
estat ic



***********************************************************************************************************
********* ALL SCHOOLS (Logit) - unconditional + conditional ************** without spring ************************** normalized but not standardized *******************
****************************** TABLE 14b *********************************************************

mlogit CORR raven_norm gender succ_mon2w if  class>2 & fail_corr==0, cluster(group) b(1) noomit
outreg2 using c.xls, replace ctitle(Correlation Neglect)
estat ic
mlogit CORR grade4 grade5  gender succ_mon2w if  class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR parents_edu  gender succ_mon2w if   class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR raven_norm grade4 grade5 parents_edu  gender succ_mon2w if   class>2  & fail_corr==0, cluster(group) b(1)  noomit 
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR raven_norm  gender schoolHL succ_mon2w if   class>2  & fail_corr==0, cluster(group) b(1)  noomit 
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR grade4 grade5  gender schoolHL succ_mon2w if   class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR parents_edu  gender schoolHL succ_mon2w if   class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR raven_norm grade4 grade5 parents_edu gender schoolHL succ_mon2w if class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic




*****************************************************
*************  ONLINE APPENDIX **********************
*****************************************************


***********************************************************************************************************
********* MAIN REGRESSIONS - uncondtional + conditional - approx Bayes ************** without spring ************************** normalized but not standardized *******************
************************* TABLE 16 ******************************************************************

reg rho14_pencilsfinal raven_norm cv_slider_pencils gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, replace ctitle(Rho)
reg rho14_pencilsfinal grade2 grade3 grade4 grade5 cv_slider_pencils gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rho14_pencilsfinal parents_edu cv_slider_pencils gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rho14_pencilsfinal raven_norm  grade2 grade3 grade4 grade5 parents_edu cv_slider_pencils gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rho14_pencilsfinal raven_norm cv_slider_pencils gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rho14_pencilsfinal  grade2 grade3 grade4 grade5 cv_slider_pencils gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rho14_pencilsfinal parents_edu cv_slider_pencils gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rho14_pencilsfinal raven_norm  grade2 grade3 grade4 grade5 parents_edu cv_slider_pencils gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)


***********************************************************************************************************
********* MAIN REGRESSIONS - uncondtional + conditional - approx Bayes ************** without spring ************************** normalized but not standardized *******************
************************* TABLE 17 ******************************************************************

reg rho14_pensfinal raven_norm cv_slider_pens gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, replace ctitle(Rho)
reg rho14_pensfinal grade2 grade3 grade4 grade5 cv_slider_pens gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rho14_pensfinal parents_edu cv_slider_pens gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rho14_pensfinal raven_norm  grade2 grade3 grade4 grade5 parents_edu cv_slider_pens gender if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rho14_pensfinal raven_norm cv_slider_pens gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rho14_pensfinal  grade2 grade3 grade4 grade5 cv_slider_pens gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rho14_pensfinal parents_edu cv_slider_pens gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rho14_pensfinal raven_norm  grade2 grade3 grade4 grade5 parents_edu cv_slider_pens gender schoolMR if (s1==1 | s4==1) & ~spring, cluster(group)
outreg2 using c.xls, append ctitle(Rho)





***********************************************************************************************************
********* MAIN REGRESSIONS - uncondtional + conditional - BETA ************** without spring ************************** normalized but not standardized *******************
************************** PENCILS ************************************************************************
****************** TABLE 18 ********************************************************************

gen RHOIND_pencils = rhoind_pencils
replace RHOIND_pencils=0.999 if RHOIND_pencils == 1

betareg RHOIND_pencils raven_norm cv_slider_pencils gender if (s1==1 | s4==1) & ~spring
outreg2 using c.xls, replace ctitle(Rho)
betareg RHOIND_pencils grade2 grade3 grade4 grade5 cv_slider_pencils gender if (s1==1 | s4==1) & ~spring
outreg2 using c.xls, append ctitle(Rho)
betareg RHOIND_pencils parents_edu cv_slider_pencils gender if (s1==1 | s4==1) & ~spring
outreg2 using c.xls, append ctitle(Rho)
betareg RHOIND_pencils raven_norm  grade2 grade3 grade4 grade5  parents_edu cv_slider_pencils gender if (s1==1 | s4==1) & ~spring
outreg2 using c.xls, append ctitle(Rho)
betareg RHOIND_pencils raven_norm cv_slider_pencils gender schoolMR if (s1==1 | s4==1) & ~spring
outreg2 using c.xls, append ctitle(Rho)
betareg RHOIND_pencils  grade2 grade3 grade4 grade5  cv_slider_pencils gender schoolMR if (s1==1 | s4==1) & ~spring
outreg2 using c.xls, append ctitle(Rho)
betareg RHOIND_pencils parents_edu cv_slider_pencils gender schoolMR if (s1==1 | s4==1) & ~spring
outreg2 using c.xls, append ctitle(Rho)
betareg RHOIND_pencils raven_norm  grade2 grade3 grade4 grade5  parents_edu cv_slider_pencils gender schoolMR if (s1==1 | s4==1) & ~spring
outreg2 using c.xls, append ctitle(Rho)


***********************************************************************************************************
********* MAIN REGRESSIONS - uncondtional + conditional - BETA ************** without spring ************************** normalized but not standardized *******************
************************** PENS ************************************************************************
***************** TABLE 19 *****************************************************************************

gen RHOIND_pens = rhoind_pens
replace RHOIND_pens=0.999 if RHOIND_pens == 1

betareg RHOIND_pens raven_norm cv_slider_pens gender if (s1==1 | s4==1) & ~spring
outreg2 using c.xls, replace ctitle(Rho)
betareg RHOIND_pens grade2 grade3 grade4 grade5  cv_slider_pens gender if (s1==1 | s4==1) & ~spring
outreg2 using c.xls, append ctitle(Rho)
betareg RHOIND_pens parents_edu cv_slider_pens gender if (s1==1 | s4==1) & ~spring
outreg2 using c.xls, append ctitle(Rho)
betareg RHOIND_pens raven_norm grade2 grade3 grade4 grade5  parents_edu cv_slider_pens gender if (s1==1 | s4==1) & ~spring
outreg2 using c.xls, append ctitle(Rho)
betareg RHOIND_pens raven_norm cv_slider_pens gender schoolMR if (s1==1 | s4==1) & ~spring
outreg2 using c.xls, append ctitle(Rho)
betareg RHOIND_pens grade2 grade3 grade4 grade5  cv_slider_pens gender schoolMR if (s1==1 | s4==1) & ~spring
outreg2 using c.xls, append ctitle(Rho)
betareg RHOIND_pens parents_edu cv_slider_pens gender schoolMR if (s1==1 | s4==1) & ~spring
outreg2 using c.xls, append ctitle(Rho)
betareg RHOIND_pens raven_norm grade2 grade3 grade4 grade5  parents_edu cv_slider_pens gender schoolMR if (s1==1 | s4==1) & ~spring
outreg2 using c.xls, append ctitle(Rho)



***********************************************************************************************************
********* MAIN REGRESSIONS - uncondtional + conditional ************** without repeated ************************** normalized but not standardized *******************
************************** PENCILS ************************************************************************
************** TABLE 20 ****************************************************************************

reg rhoind_pencils raven_norm cv_slider_pencils gender if (s1==1 | s4==1) & repeated2~=1, cluster(group)
outreg2 using c.xls, replace ctitle(Rho)
reg rhoind_pencils grade2 grade3 grade4 grade5 cv_slider_pencils gender if (s1==1 | s4==1) & repeated2~=1, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils parents_edu cv_slider_pencils gender if (s1==1 | s4==1) & repeated2~=1, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils raven_norm grade2 grade3 grade4 grade5 parents_edu cv_slider_pencils gender if (s1==1 | s4==1) & repeated2~=1, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils raven_norm cv_slider_pencils gender schoolMR if (s1==1 | s4==1) & repeated2~=1, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils grade2 grade3 grade4 grade5 cv_slider_pencils gender schoolMR if (s1==1 | s4==1) & repeated2~=1, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils parents_edu cv_slider_pencils gender schoolMR if (s1==1 | s4==1) & repeated2~=1, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pencils raven_norm grade2 grade3 grade4 grade5 parents_edu cv_slider_pencils gender schoolMR if (s1==1 | s4==1) & repeated2~=1, cluster(group)
outreg2 using c.xls, append ctitle(Rho)



***********************************************************************************************************
********* MAIN REGRESSIONS - uncondtional + conditional ************** without repeated ************************** normalized but not standardized *******************
************************** PENS ************************************************************************
************** TABLE 21 ****************************************************************************

reg rhoind_pens raven_norm cv_slider_pens gender if (s1==1 | s4==1) & repeated2~=1, cluster(group)
outreg2 using c.xls, replace ctitle(Rho)
reg rhoind_pens grade2 grade3 grade4 grade5 cv_slider_pens gender if (s1==1 | s4==1) & repeated2~=1, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pens parents_edu cv_slider_pens gender if (s1==1 | s4==1) & repeated2~=1, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pens raven_norm grade2 grade3 grade4 grade5 parents_edu cv_slider_pens gender if (s1==1 | s4==1) & repeated2~=1, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pens raven_norm cv_slider_pens gender schoolMR if (s1==1 | s4==1) & repeated2~=1, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pens grade2 grade3 grade4 grade5 cv_slider_pens gender schoolMR if (s1==1 | s4==1) & repeated2~=1, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pens parents_edu cv_slider_pens gender schoolMR if (s1==1 | s4==1) & repeated2~=1, cluster(group)
outreg2 using c.xls, append ctitle(Rho)
reg rhoind_pens raven_norm grade2 grade3 grade4 grade5 parents_edu cv_slider_pens gender schoolMR if (s1==1 | s4==1) & repeated2~=1, cluster(group)
outreg2 using c.xls, append ctitle(Rho)



***********************************************************************************************************
********* MAIN REGRESSIONS (linear - rational) - unconditional + conditional ************** ************************** normalized but not standardized *******************
***********************************************************************************************************
************** TABLE 23 ****************************************************************************

reg corr3_2w raven_norm gender succ_mon2w if  (s1==1 |s4==1) & class>2 & fail_corr==0, cluster(group)
outreg2 using c.xls, replace ctitle(Correlation Neglect)

reg corr3_2w grade4 grade5  gender succ_mon2w if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) 
outreg2 using c.xls, append ctitle(Correlation Neglect)

reg corr3_2w parents_edu  gender succ_mon2w if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) 
outreg2 using c.xls, append ctitle(Correlation Neglect)

reg corr3_2w raven_norm grade4 grade5 parents_edu  gender succ_mon2w if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group)  
outreg2 using c.xls, append ctitle(Correlation Neglect)

reg corr3_2w raven_norm  gender schoolMR succ_mon2w if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group)  
outreg2 using c.xls, append ctitle(Correlation Neglect)

reg corr3_2w grade4 grade5  gender schoolMR succ_mon2w if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) 
outreg2 using c.xls, append ctitle(Correlation Neglect)

reg corr3_2w parents_edu  gender schoolMR succ_mon2w if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) 
outreg2 using c.xls, append ctitle(Correlation Neglect)

reg corr3_2w raven_norm grade4 grade5 parents_edu gender schoolMR succ_mon2w if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) 
outreg2 using c.xls, append ctitle(Correlation Neglect)



***********************************************************************************************************
********* MAIN REGRESSIONS (linear - rational) - unconditional + conditional ************** without spring ************************** normalized but not standardized *******************
***********************************************************************************************************
************** TABLE 22 ****************************************************************************

reg ind3_2w raven_norm gender  if  (s1==1 |s4==1) & class>2 & fail_corr==0, cluster(group)
outreg2 using c.xls, replace ctitle(FOSD)

reg ind3_2w  grade4 grade5   gender  if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) 
outreg2 using c.xls, append ctitle(FOSD)

reg ind3_2w parents_edu  gender  if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) 
outreg2 using c.xls, append ctitle(FOSD)

reg ind3_2w raven_norm  grade4 grade5  parents_edu  gender  if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group)  
outreg2 using c.xls, append ctitle(FOSD)

reg ind3_2w raven_norm  gender schoolMR  if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group)  
outreg2 using c.xls, append ctitle(FOSD)

reg ind3_2w  grade4 grade5   gender schoolMR  if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) 
outreg2 using c.xls, append ctitle(FOSD)

reg ind3_2w parents_edu  gender schoolMR  if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) 
outreg2 using c.xls, append ctitle(FOSD)

reg ind3_2w raven_norm  grade4 grade5  parents_edu gender schoolMR  if  (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) 
outreg2 using c.xls, append ctitle(FOSD)




***********************************************************************************************************
********* MAIN REGRESSIONS (Logit) - unconditional + conditional ************** without spring ************************** normalized but not standardized *******************
***********************************************************************************************************
************** TABLE 24 ****************************************************************************


mlogit CORR raven_norm gender if succ_mon2w>0 &  (s1==1 |s4==1) & class>2 & fail_corr==0, cluster(group) b(1) noomit
outreg2 using c.xls, replace ctitle(Correlation Neglect)
estat ic
mlogit CORR grade4 grade5  gender if succ_mon2w>0 &   (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR parents_edu  gender if succ_mon2w>0 &   (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR raven_norm  grade4 grade5 parents_edu  gender  if succ_mon2w>0 &   (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit 
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR raven_norm  gender schoolMR  if succ_mon2w>0 &   (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit 
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR  grade4 grade5  gender schoolMR  if succ_mon2w>0 &   (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR parents_edu  gender schoolMR  if succ_mon2w>0 &   (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR raven_norm  grade4 grade5 parents_edu gender schoolMR  if succ_mon2w>0 &   (s1==1 |s4==1) & class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic



***********************************************************************************************************
********* ALL SCHOOLS (Logit) - unconditional + conditional ************** without spring ************************** normalized but not standardized *******************
***********************************************************************************************************
************** TABLE 25 ****************************************************************************


mlogit CORR raven_norm gender if succ_mon2w>0 &  class>2 & fail_corr==0, cluster(group) b(1) noomit
outreg2 using c.xls, replace ctitle(Correlation Neglect)
estat ic
mlogit CORR grade4 grade5  gender if succ_mon2w>0 &  class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR parents_edu  gender if succ_mon2w>0 &  class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR raven_norm  grade4 grade5 parents_edu  gender  if succ_mon2w>0 &   class>2  & fail_corr==0, cluster(group) b(1)  noomit 
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR raven_norm  gender schoolHL  if succ_mon2w>0 &   class>2  & fail_corr==0, cluster(group) b(1)  noomit 
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR  grade4 grade5  gender schoolHL  if succ_mon2w>0 &   class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR parents_edu  gender schoolHL  if succ_mon2w>0 &  class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic
mlogit CORR raven_norm  grade4 grade5 parents_edu gender schoolHL  if succ_mon2w>0 &  class>2  & fail_corr==0, cluster(group) b(1)  noomit
outreg2 using c.xls, append ctitle(Correlation Neglect)
estat ic



*****************
**** TABLE 1 ****
*****************


mi extract 0, clear

gen schoolname = "School L" if s1==1
replace schoolname = "Schools M" if s2==1 | s3==1
replace schoolname = "School H" if s4==1

gen schoolnameHL = "School H" if s4==1
replace schoolnameHL = "School L" if s1==1


gen Class = class
gen Gender = gender

************************************************ TABLE 1

table1_mc if ~spring, by(school) ///
vars( ///
Gender bin %4.2f \ ///
Class cat %4.2f \ ///
missing_S cate %4.2f \ ///
) ///
nospace percent onecol missing total(before) ///
saving("table 3.xlsx", replace)

table1_mc if ~spring, by(schoolnameHL) ///
vars( ///
Gender bin %4.2f \ ///
Class cat %4.2f \ ///
missing_S cate %4.2f \ ///
) ///
nospace percent onecol missing total(before) ///
saving("table 3.xlsx", replace)


*********************************************************




