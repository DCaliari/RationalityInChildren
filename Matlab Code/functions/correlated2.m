function L = correlated2(x,a,b,c,N)

A = round(a*N);
B = round(b*N);
C = round(c*N);

% x(1) = gamma_4
% x(2) = gamma_5
% x(3) = gamma_2

R = 1-(x(1)*(1-x(2))*(1-x(3)) + x(2)*(1-x(1))*(1-x(3)) + x(3)*(1-x(1))*(1-x(2)) + (1-x(1))*(1-x(2))*(1-x(3)));

L = - A*log((x(1)*x(2)*(1- x(3)))/R) - B*log((x(1)*x(3)*(1- x(2)))/R)- C*log((x(2)*x(3))/R);

end
