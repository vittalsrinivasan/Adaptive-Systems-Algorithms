%{
code to implement the projection algorithm for any order of system
you have to input the coefficients of num and den of tf into theta.
 
First enter the denominator coeff and then the numerator coefficients.
%}

close all;
clear all;
clc;

num=input("Enter numerator coefficients in descending order:");
den=input("Enter denominator coefficients in descending order:");


%initialising values
n = length(num) ;%no of zeros in tf
k = 0:0.01:10;

N = length(k) ; % no of iterations
theta = [den,num]'; %coefficents of den poly and num poly in descending order 
p=length(theta); 
y = zeros(1, N);
yhat = zeros(1,N) ;
e = zeros(1, N);
theta_hat = zeros(1,length(theta))' ;
thetahat = [] ;
%u = [1, ones(1,N-1)] ;
%u=sin(0.2*k)+sin(0.8*k);
u=[ 1, zeros(1,N-1)];
phi = zeros(1,length(theta))' ;

% Algorithm to update theta_hat,y, phi and error e
for i = 0:N-p-1
   %desired value of y
    y(i+1) = theta'*phi ; 
%estimated value of y
    yhat(i+1) = theta_hat'*phi ;
%error in estimation    
    e(i+1)=y(i+1)- yhat(i+1);
%updating theta_hat values    
    theta_hat = theta_hat + (phi/(1 + phi'*phi))*(e(i+1));
    thetahat = [thetahat theta_hat] ;
 %updating phi values   
    for j=1:p-n
        phi(j) = -y(i+j);
    end
    for J=1:n
    phi(j+1)=u(i+n);
    end
    disp(phi)
end
    
%plotting
k=0:0.01:10-(0.01*p);
k1=0:0.01:10;

figure
plot(k,thetahat);
title("theta-hat")

figure
plot(k1,y,'-g',k1,yhat,'--b');
title("output y")

figure
plot(k1,e)
title("error e")
