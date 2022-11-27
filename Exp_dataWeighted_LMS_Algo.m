%%code to implement the  Exponential data weighting LMS algorithm  

close all;
clear all;
clc;

n = 1 ;
k = 0:0.01:10 ;
N = length(k) ; % no of iterations

theta = [-0.5 1]'; % initial conditions
y = zeros(1, N);
yhat = zeros(1,N) ;
e = zeros(1, N);
%theta_hat = [zeros(1, N); zeros(1, N)];
theta_hat = zeros(1,length(theta))' ;
% theta_hat = ones(1,length(theta))' ;
% theta_hat = rand(1,length(theta))' ;
thetahat = [theta_hat] ;
u = ones(1,N) ;

phi = zeros(1,length(theta))' ;
%phi = [-y(1) u(1)]';
P=[1 0;0 1];
% Algorithm to update theta_hat,y phi and error e
a0=0.99;
a= 0.95; %initial condition
for i = 1:N-1
    y(i+1) = theta'*phi ;
    yhat(i+1) = theta_hat'*phi ;
    e(i+1)=y(i+1)- yhat(i+1);
    theta_hat = theta_hat + ((P*phi)/( a+(phi)'*P*(phi)))*(e(i+1));
    P=(1/a)*(P-(P*(phi)*(phi)'*P)/(a+phi'*P*phi));
    phi = [-y(i+1) u(i+1)]';
    a=(a0*a)+(1-a0);
    disp(P)
    thetahat = [thetahat theta_hat] ;
end
%plotting
k=0:0.01:10;
figure
plot(k,thetahat)
title("theta")
figure
% disp(y);
plot(k,y,'-g',k,yhat,'--b');
%axis([0,1100,-1,2])
title("output y")
figure
plot(k,e)
title("error e")
