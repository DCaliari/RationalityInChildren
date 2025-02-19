function [P] = P_Rho_varying_type(r,PER,u,R)
%
t=PER(u,:);

U_set = [1,2,3,4];

%
for j=1:size(R,1)
set = find(R(j,:)==1);

A(j,:) = Rho_var(t, set, U_set, r);
end

N=A';
Q=N(N>0);
%
P=Q;
end