function LL = log_lik_model_pooled(p_par, pi_par, PER, lc, R, C1, C2)

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

F1 = exp(C1*log(Q(:,1:24))); 
F2 = exp(C2*log(Q(:,25:48))); 

LL = Log_lik_EB_pooled(pi_par',F1, F2);

end