function LL = Log_lik_EB_pooled(pi_par,F1,F2)

LL = - (sum(log(F1*pi_par(1:24)),'all') + sum(log(F2*pi_par(25:48)),'all'));

end