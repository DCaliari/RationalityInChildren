%%% This function take the sets and creates the probabilties in the set
   %%% following Manzini, Mariotti ECMA (2014) conditional on the
   %%% preference order

function Q = ProbIndPachinko(r)

tot = 1- (1-r)^3;
Q(1) = ((1-r)*(1-r)*r)/tot;
Q(2) = ((1-r)*r)/tot;
Q(3) = r/tot;

end