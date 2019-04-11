%% Code Details:
% birthday_paradox.m
%
% Description:
% Calculates the probablity of 2 people who have same birth date
%
% Special requirements or dependencies:
% None; Tested in RHEL 7.4 with MATLAB R2017a
%
% Compilation and execution:
% Compilation not necessary
% Execution takes less than a second on most modern hardware.
% 
%For the execution in LINUX terminal 
% matlab -nodisplay -nosplash -singleCompThread -r birthday_paradox -logfile birthday_paradox.log

%% Clear the old data from workpace,command window and figure.
clear;
clc;
clf;
close all;

%% Initialization

% Maximum number of people in classroom
N = 100; 

% Initialize probability
PrevP = 1;

% Create the .dat file
fout = fopen('birthday_paradox.dat', 'w');

% Print the header
fprintf(fout,"N\tProb\n");

%% Calculations

% Loop BEGINS
for i = 1 : N
    
    % Probability that no birthdays are the same
    Pnot     = PrevP*(365-i+1)/365; 
    
    % Probability that at least two birthdays are the same
    P(i)     = 1-Pnot; 
    PrevP    = Pnot;
    
    % Printing the results in .dat file
    fprintf(fout,'%d\t%0.15f\n',i,P(i));
end % Loop ENDS

%% Plot

% initialize the x axis
x = 1:N;

% Plot the curve
plot(x, P, '-')

% Label the axis
xlabel('no. of people')
ylabel('prob. that at least two have same birthday')

% Grid on
grid on

% Save the plot in png format
saveas(gcf,'birthday_paradox.png');

% exit
exit
