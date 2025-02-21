Title of the project: "Exploring Choice Errors in Children."

The project contains the code to replicate tables, figures, and results for the paper: "Exploring Choice Errors in Children".
There are two coding languages:
(i) Matlab is used to create figures, tables, analysis, and datasets
(ii) Stata is used solely for the regression analysis and some descriptive statistics.


The replication software and supporting data are organised in the following directories:
(i) Data Excel: the folder contains the data sources.
(ii) Matlab Code: the folder contains the files for the replication of all figures and most tables. Further, it contains the code that creates the dataset employed in the Stata code.
(iii) Stata Code: the folder contains the file for the replication of all regression tables.
(iv) stored_datasets: the folder contains datasets that are created by the code and used for the analysis.
(v) stored_variables: the folder contains variables that are created by the code and used for the analysis.

The replication files:
(i) in the Matlab Code folder, the file FullReplicationCode.m reproduces all figures and tables, and store them.
    More specifically, the file reproduces Figures 4-11, 14, 15, 17, 19-24, and 32; and Tables 2, 3, 4, 9, 10.
(ii) in the Stata Code folder, the file Replication.do reproduces all regression tables and some descriptive statistics.
    More specifically, the file reproduces Tables 1, 5, 6, 7, 11-15, 18-27.

To replicate the figures and tables generated with Matlab, after adding the directories and subdirectories to the path, simply run "FullReplicationCode.m" which is in the "Matlab code" directory. The figures and tables generated are then stored in the directory ../figures_tables;

To replicate the tables generated with Stata, after adding the directory as "working directory", simply run the "Replication.do" file in the "Stata code" directory.

Finally, we have generated 1000 (resp. 10000) bootstrapped estimates for calculating the standard errors in the estimates of the consideration parameter in the pencils/pens task (resp. coin-drop game). These estimates are stored in the folder stored_variables within the folder figures_tables, and they are loaded on the script to ensure that the resulting figures are equivalent to those on the paper.
