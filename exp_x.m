
%exp_x.m
%Calculating the value of e
%Part a : Taylor series
%Part b : Limit formula
%For part a set the value of 'n' as any larger number
%For part b set the value of 'n' to 10^308
%For compilation in terminal use following command

% matlab -nodisplay -nosplash -singleCompThread -r exp_x -logfile exp_x.log

clear;
clc;
k = 100000; %Assume any large value of k
x=1; %Assume value of x=1
s = 0; %Assume value of sum = 0
q = 0; %Assume value of temporary sum q = 0
for i=0:k
    s = s + (x^(k))/(factorial(i)); %summation formula for calculating e
    if abs(q-s)==0.0e-10 %Checking error with previous step
        break; %Break the loop if error is 0.0e-10
    else
        q = s;
    end
end
fprintf('Value of k = %d \n',i) %Print the value of total no of iterations
fprintf('Value of e = %.15f \n',s) %Print value of e

%Applying Limit formula

n=10^308;
e = (1 + x/n)^(n);
fprintf('Value of e = %.15f \n',e) %Print value of e

