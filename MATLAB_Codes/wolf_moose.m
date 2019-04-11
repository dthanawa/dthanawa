%% Description
% wolf_moose.m
%
% Description:
% Computes the population of Wolf and Moose by Runge-Kutta order 4 method
%
% Special requirements or dependencies:
% None; Tested in RHEL 7.4 with MATLAB R2017b
%
% Compilation and execution:
% Compilation not necessary
% Execution takes less than a second on most modern hardware.
%
% For the execution in LINUX terminal
% matlab -nodisplay -nosplash -singleCompThread -r wolf_moose -logfile wolf_moose.log

%% Clear the old data from workpace,command window and figure.
clear;
clc;
close all;
clf;

%% Initailization
% Set the variable datatype
format long;
% Create file to write the data
fout = fopen('wolf_moose_sim.dat', 'w');
% Import the experimental data 
data=importdata('wolf_moose_expt.dat');
Q=data.data;
% Calculate # of years
n=length(Q(:,1));
% Step size
h=1/64;
year = 1959;
% Printing the heading in output file
fprintf(fout,"year\twolf population\tmoose population\n");
%Initial Number of moose and wolves
m(1) = 538;
w(1) = 20;

%% Calculations of Wolf and Moose Population
%Calculating the population of the wolf and moose
% LOOP BEGINS
for i=2:n*(1/h)+1
    m(i) = moose(w(i-1),m(i-1),h);
    w(i) = wolf(w(i-1),m(i-1),h);
end % LOOP ENDS
%% Printing the calculated data
% Write the wolf and moose population in dat file
% LOOP BEGINS
for i=1:n*(1/h)
    fprintf(fout,"%f\t%f\t%f\n",year+(i*h),w(i),m(i));
end % LOOP ENDS

%% Plot
% Open Figure
figure(1)
% Interval
i=1:1/h:n*(1/h);
% Add grid in graph
grid on
% Set axis for Moose (Left side) 
yyaxis left
% Plot Moose population v/s Year
plot(year+(i*h),m(i),'-g*',Q(:,1),Q(:,3),'-k+')
% Label the axis
xlabel('Time(Years)')
ylabel('Moose(Prey)')
% Set axis for Wolf (Right side)
yyaxis right
% Plot Wolf population v/s Year
plot(year+(i*h),w(i),'-bsquare',Q(:,1),Q(:,2),'-ro')
% Label the axis
xlabel('Time(Years)')
ylabel('Wolf(Predators)')
% Legend the graph
legend({'Moose(RK4)','Moose(Expt)','Wolf(RK4)','Wolf(Expt)'},'Location','northwest')
legend('boxoff')
% Save the figure in .png format
saveas(gcf,'wolf_moose_sim.png')
exit;

%% RK4 Method
%Calculating moose population using RK4 method
function m = moose(w,m,h)
km1 = 0.25*m - 0.0081*m*w;
km2 = 0.25*(m+h/2.0*km1) - 0.0081*(m+h/2.0*km1)*w;
km3 = 0.25*(m+h/2.0*km2) - 0.0081*(m+h/2.0*km2)*w;
km4 = 0.25*(m+h*km3) - 0.0081*(m+h*km3)*w;
m = m + (h/6.0)*(km1 + 2.0*km2 + 2.0*km3 + km4);
end
%Calculating wolf population using RK4 method
function w =wolf(w,m,h)
kw1 = 0.000203*m*w-0.25*w;
kw2 = 0.000203*m*(w+h/2.0*kw1) - 0.25*(w+h/2.0*kw1);
kw3 = 0.000203*m*(w+h/2.0*kw2) - 0.25*(w+h/2.0*kw2);
kw4 = 0.000203*m*(w+h*kw3) - 0.25*(w+h*kw3);
w = w + (h/6.0)*(kw1 + 2.0*kw2 + 2.0*kw3 + kw4);
end
%%%
