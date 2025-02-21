%%% This function take the sets and creates the probabilties in the set
   %%% following Manzini, Mariotti ECMA (2014) - Horan (2019) conditional on the
   %%% preference order

function A = Rho_var(t, set, U_set, r)

s = size(set,2);
A = zeros(1,4);

complement_set = setdiff(U_set,set);

temp=t;
for i=1:size(complement_set,2)
    it = temp;
    temp = it(it~=complement_set(i)); % this gives me the order within the set
end


if s==2
tot = 1-(1-r(temp(1)))*(1-r(temp(2)));
A(temp(1)) = r(temp(1))/tot;
A(temp(2)) = ((1-r(temp(1)))*r(temp(2)))/tot;
elseif s==3
tot = 1-(1-r(temp(1)))*(1-r(temp(2)))*(1-r(temp(3)));
A(temp(1)) = r(temp(1))/tot;
A(temp(2)) = ((1-r(temp(1)))*r(temp(2)))/tot;
A(temp(3)) = ((1-r(temp(1)))*(1-r(temp(2)))*r(temp(3)))/tot;
elseif s==4
tot = 1-(1-r(temp(1)))*(1-r(temp(2)))*(1-r(temp(3)))*(1-r(temp(4)));
A(temp(1)) = r(temp(1))/tot;
A(temp(2)) = ((1-r(temp(1)))*r(temp(2)))/tot;
A(temp(3)) = ((1-r(temp(1)))*(1-r(temp(2)))*r(temp(3)))/tot;
A(temp(4)) = ((1-r(temp(1)))*(1-r(temp(2)))*(1-r(temp(3)))*r(temp(4)))/tot;
end

end