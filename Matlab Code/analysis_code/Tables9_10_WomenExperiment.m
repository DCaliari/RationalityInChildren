clear

Dati_merletti = readtable('Dati_Paola.xls');

Treatment = Dati_merletti.indep2corr;

Choices = Dati_merletti.Scegliunastrisciaperlapossi;

Progress = Dati_merletti.Progress;

for z=1:size(Choices,1)
L5ind(z,1) = isequal(Choices{z,1},'5');
L6ind(z,1) = isequal(Choices{z,1},'6');
L7ind(z,1) = isequal(Choices{z,1},'7');
L5corr(z,1) = isequal(Choices{z,1},'4,5');
L6corr(z,1) = isequal(Choices{z,1},'4,2');
L7corr(z,1) = isequal(Choices{z,1},'5,2');
end

IND = [sum(L5ind(Treatment==1 & Progress>=97))/sum(Treatment==1 & Progress>=97);sum(L6ind(Treatment==1 & Progress>=97))/sum(Treatment==1 & Progress>=97);sum(L7ind(Treatment==1 & Progress>=97))/sum(Treatment==1 & Progress>=97)];
CORR = [sum(L5corr(Treatment==2 & Progress>=97))/sum(Treatment==2 & Progress>=97);sum(L6corr(Treatment==2 & Progress>=97))/sum(Treatment==2 & Progress>=97);sum(L7corr(Treatment==2 & Progress>=97))/sum(Treatment==2 & Progress>=97)];

N1 = sum(Treatment==1 & Progress>=97);
N2 = sum(Treatment==2 & Progress>=97);

options=optimoptions('fmincon','display','off','MaxFunctionEvaluations',1e6,...
    'StepTolerance',1e-8,'FunctionTolerance',1e-8,'OptimalityTolerance',1e-8,'FiniteDifferenceType','central' );

z=1;
x0 = [0.5, 0.5, 0.5];

Aeq = [1,-1,0; 1,0,-1];
beq = [0;0];
lb=[0;0;0];
ub=[1;1;1];

[xc] = fmincon(@(x) independent(x,IND(1),IND(2),IND(3),N1), x0', [],[],Aeq,beq,lb,ub,[],options)

[xu] = fmincon(@(x) independent(x,IND(1),IND(2),IND(3),N1), x0', [],[],[0,0,1],IND(1),lb,ub,[],options)

A = IND(1)*N1;
B = IND(2)*N1;
C = IND(3)*N1;


R = 1 - (1-xc(1))*(1-xc(2))*(1-xc(3));
LL1 = - A*log((xc(1)*(1-xc(2))*(1- xc(3)))/R) - B*log((xc(2)*(1- xc(3)))/R) - C*log((xc(3))/R);
P1 = [(xc(1)*(1-xc(2))*(1- xc(3)))/R, (xc(2)*(1- xc(3)))/R, (xc(3))/R];

R = 1 - (1-xu(1))*(1-xu(2))*(1-xu(3));
LL2 = - A*log((xu(1)*(1-xu(2))*(1- xu(3)))/R) - B*log((xu(2)*(1- xu(3)))/R) - C*log((xu(3))/R);
P2 = [(xu(1)*(1-xu(2))*(1- xu(3)))/R, (xu(2)*(1- xu(3)))/R, (xu(3))/R];

LL3 = - A*log(IND(1)) - B*log(IND(2)) - C*log(IND(3));

[h(z), pvalue(z)] = lratiotest(-LL2, -LL1, 1)

TABLE9 = array2table([N1,IND',pvalue],"VariableNames",{'N','L5','L6','L7','LRT'});



%%% Estimates correlated


x0 = [0.5, 0.5, 0.5];

Aeq = [1,-1,0; 1,0,-1];
beq = [0;0];
lb=[0;0;0];
ub=[1;1;1];

[xc] = fmincon(@(x) correlated2(x,CORR(1),CORR(2),CORR(3),N2), x0', [],[],Aeq,beq,lb,ub,[],[])

[xu] = fmincon(@(x) correlated2(x,CORR(1),CORR(2),CORR(3),N2), x0', [],[],[0,1,0],0.5,lb,ub,[],[])

A = CORR(1)*N2;
B = CORR(2)*N2;
C = CORR(3)*N2;


R = 1-(xc(1)*(1-xc(2))*(1-xc(3)) + xc(2)*(1-xc(1))*(1-xc(3)) + xc(3)*(1-xc(1))*(1-xc(2)) + (1-xc(1))*(1-xc(2))*(1-xc(3)));
LL1 = - A*log((xc(1)*xc(2)*(1- xc(3)))/R) - B*log((xc(1)*xc(3)*(1- xc(2)))/R)- C*log((xc(2)*xc(3))/R);
P1 = [(xc(1)*xc(2)*(1- xc(3)))/R, (xc(1)*xc(3)*(1- xc(2)))/R, (xc(2)*xc(3))/R];

R = 1-(xu(1)*(1-xu(2))*(1-xu(3)) + xu(2)*(1-xu(1))*(1-xu(3)) + xu(3)*(1-xu(1))*(1-xu(2)) + (1-xu(1))*(1-xu(2))*(1-xu(3)));
LL2 = - A*log((xu(1)*xu(2)*(1- xu(3)))/R) - B*log((xu(1)*xu(3)*(1- xu(2)))/R)- C*log((xu(2)*xu(3))/R);
P2 = [(xu(1)*xu(2)*(1- xu(3)))/R, (xu(1)*xu(3)*(1- xu(2)))/R, (xu(2)*xu(3))/R];

LL3 = - A*log(CORR(1)) - B*log(CORR(2)) - C*log(CORR(3));

[h(z), pvalue(z)] = lratiotest(-LL2, -LL1, 1)

TABLE10 = array2table([N2,CORR',pvalue],"VariableNames",{'N','L5','L6','L7','LRT'});


