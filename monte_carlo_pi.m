%% Description
% monte_carlo_pi.m
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
%For the execution in LINUX terminal 
% matlab -nodisplay -nosplash -singleCompThread -r monte_carlo_pi -logfile monte_carlo_pi.log
%% Clear the old data from workpace,command window and figure.
clear;
clc;
close all;
clf;
%% Initialization
% Timer on
tic
% Set the data type of variables
format long;
% Create file to save the data
fout = fopen('monte_carlo_pi.dat', 'w');
% Initial Declaration;
N = 0;
monte_pi = 0.0;
a = -1;
b = 1;
r = 0.0;
% Memory preallocation for Monte Carlo Pi and Error
mpi = zeros(10,1);
err = zeros(10,1);
% Print the heading of the table
fprintf("k\t  value of pi\t\t\terror\t\t\t%%error\n");
% Printing the heading in output file
fprintf(fout,"N\tvalue_of_pi\terror\t%%error\n");
%% Calculations
% Loop 1 BEGINS
for k = 0 : 9
    % Timer on for each value of k
    tic
    % Initialize the Circle points to zero
    c = 0;
    % Calculating the Value of N
    N = 10^k;
    % Loop 2 BEGINS 
    for i = 1:N
        % Generate the Random numbers for x and y in the range of -1 to 1
        x = (b-a).*rand() + a;
        y = (b-a).*rand() + a;
        % Calculating the radius
        r = sqrt(x.^2+y.^2);
        % Calculating whether the point is inside the circle or not
        if(r <= 1)
            % If condition satisfy then increment c by 1
            c = c+1;
        end
        % Calcilating the value of Pi using Monte Carlo formula
        monte_pi = 4*c/i; 
    end % Loop 2 ENDS
    % Save the value of Pi
    mpi(k+1) = monte_pi;
    % Calculate the absolute error
    err(k+1) = abs(pi-monte_pi);
    elapsedTime(k+1) = toc; % Save the time for the value of k
    % Printing the result for each iteration    
    % Print the output in command window
    fprintf('%d\t%1.15f\t%1.15f\t%1.15f\n',k,mpi(k+1),err(k+1),100*err(k+1)/pi)
    % Write the calculated values in dat file
    fprintf(fout,'%d\t%1.15f\t%1.15f\t%1.15f\n',10^k,mpi(k+1),err(k+1),100*err(k+1)/pi);
end % Loop 1 ENDS
%% Plot 
% Open Figure 1
figure(1);
t = 0:k;
u = -1:10;
% Plot exact value of Pi and Calculated value of Pi
plot(u,u*0 + pi,t,mpi(t+1),'ko')
% Add grid in graph
grid on;
% Set the axis limit
xlim([-1 10])
ylim([-0.5 4.5])
% Set the title
title('Pi v/s N')
% Label the x axis and y axis
ylabel('Pi')
xlabel({'k';'(N=10^k)'})
% Save the figure in .png format
saveas(gcf,'monte_carlo_pi.png')
% Open Figure 2
figure(2);
% Plot the Error vs N plot
plot(t,err(t+1),'-ko')
% Add grid in graph
grid on;
% Set the axis limit
xlim([-1 10])
ylim([-0.1 1])
% Set the title
title('Error v/s k')
% Label the x axis and y axis
ylabel('Error')
xlabel({'k';'(N=10^k)'})
% Save the figure in .png format
saveas(gcf,'monte_carlo_pi_error.png')
% Open figure 3
figure(3)
% Scalabilty: plot time vs N
plot(t,elapsedTime(t+1),'-ko');
% Add grid in graph
grid on;
% Label the x axis and y axis
ylabel('Time')
xlabel({'k';'(N = 10^k)'})
% Set the axis limit
xlim([-1 10])
ylim([-10 100])
% Set the title
title('Time v/s k')
% Save the figure in .png format
saveas(gcf,'monte_carlo_pi_scalability.png')
toc % Timer off    
%%%
exit
