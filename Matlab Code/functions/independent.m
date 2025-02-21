function L = independent(x,a,b,c,N)
%function F = independent(x,a,b,c)


%F(1) = (x(1)*(1- x(1))^2)/(1-(1-x(1))^3) - a;
%F(2) = (x(1)*(1- x(1)))/(1-(1-x(1))^3) - b;
%F(3) = (x(1))/(1-(1-x(1))^3) - c;



A = round(a*N);
B = round(b*N);
C = round(c*N);

R = 1 - (1-x(1))*(1-x(2))*(1-x(3));

L = - A*log((x(1)*(1-x(2))*(1- x(3)))/R) - B*log((x(2)*(1- x(3)))/R) - C*log((x(3))/R);

end
