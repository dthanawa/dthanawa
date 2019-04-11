%% Problem Description
% CatLewis.m
%
% Description:
% Computes the value of Pi by Monte Carlo method
%
% Special requirements or dependencies:
% None; Tested in RHEL 7.4 with MATLAB R2017a
%
% Compilation and execution:
% Compilation not necessary
% Execution takes approx 80-100 seconds on most modern hardware.
% 
% For the execution in LINUX terminal 
% matlab -nodisplay -nosplash -singleCompThread -r CatLewis -logfile CatLewis.log

%% Clear the old data from workpace,command window and figure.

clear;
clc;
close all;
%% 
x = 2;
for i = 1:100
    
    y = x/(x-1);
    z1 = x*y
    z2 = x+y
    x= x+0.1;

end
