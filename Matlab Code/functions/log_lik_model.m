function LL = log_lik_attempt(p_par, pi_par, PER, lc, R, C)

temp_par = repmat(p_par,1,4);
Q=[];
for i=1:size(p_par,1)
for u=1:lc
P(:,u) = P_Rho_varying_type(temp_par(i,:),PER,u,R); 
end
%
temp=P;
Q=[Q,temp];
%
end

F=exp(C*log(Q)); 

LL = Log_lik_EB(pi_par',F);

end