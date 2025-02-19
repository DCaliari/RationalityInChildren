%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% CREATE THE DATASET WITH THE STRUCTURAL ESTIMATION FROM THE PENCILS/PENS CHOICE TASK %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear

load stored_variables\WARP

load rho_model_pencils_FINAL.mat

x1 = [WARP1, attention_FINAL];

clearvars -except x1

load stored_variables\WARP

load rho_model_pens_FINAL.mat

load individual_structural.mat

x2 = [WARP2, attention_FINAL, parametersIND{1,1}', parametersIND{1,2}'];

clearvars -except x1 x2

load dataset_WARP

group = dataset_WARP(:,4);
id_spec = dataset_WARP(:,3);

DATA = array2table([group,id_spec,x1,x2],'VariableNames',{'group','id_spec','WARP1', 'rho14_pencilsFINAL', 'WARP2', 'rho14_pensFINAL','rhoIND_pencils', 'rhoIND_pens'});

writetable(DATA,['stored_datasets/structural_variables_dataset.csv'])

