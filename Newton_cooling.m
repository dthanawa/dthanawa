%% Description
% Newtons_cooling.m
%
% Description:
% Computes proptionality constant k for Newton's Law of Cooling
%
% Special requirements or dependencies:
% None; Tested in RHEL 7.4 with MATLAB R2017a
%
% Compilation and execution:
% Compilation not necessary
% Execution takes less than seconds on most modern hardware.
% 
% For the execution in LINUX terminal: 
% matlab -nodisplay -nosplash -singleCompThread -r Newton_cooling -logfile Newton_cooling.log
%% Clear the old data from workpace,command window and figure.
clear;
clc;
close all;
clf;
%% Initailization
% Set the variable datatype
format long;
% Experimental data: Temeperature and Time
Tavg=[206.4 183.6 168.05 156.15 147.4 139.8 133.9 119.15 109.9 102.85 97.2 89.05];
t=[0 5 10 15 20 25 30 45 60 75 90 120];
% Set the room temperature
Troom = 82;
%% Calculations
% Calculate the value of k for each time interval
for i = 1:10
    k(i)=((Tavg(i+1)-Tavg(i))/(Troom-Tavg(i)))/(t(i+1)-t(i));
end
% Calculate the average k
kavg = sum(k)/11;
% Set the initial temperature
Te(1) = 206.4;
% Loop BEGINS
for i=1:200000
    % Calculate the room temperature
    Te(i+1)=Te(i)+kavg*(Troom - Te(i))*1;
    % Check the difference between 2 iterations
    if abs(Te(i+1)-Te(i)) < 0.01
        break; % Break if condition satisfies
    end
end % Loop ENDS
%% Plot
% Open figure 1
figure(1)
% Plot the Experimental Temperature vs Time data
plot(t,Tavg,'-ko')
% Add grid in graph
grid on;
% Set the axis limit
xlim([-10 130])
ylim([80 220])
% Set the title
title('Experimental Temperature v/s Time')
% Label the x axis and y axis
ylabel('Temperature (Fahrenheit)')
xlabel('Time (Minutes)')
% Save the figure in .png format
saveas(gcf,'Newton_cooling_Expt.png')
% Open figure 2
figure(2)
x=1:i+1;
% Plot the calculated Temperature vs Time data
plot(x,Te,x,x*0+Te(i+1))
% Add grid in graph
grid on;
% Set the axis limit
xlim([-10 280])
ylim([70 220])
% Legend the graph
legend({'Room Temperature','Calculated Temperature'})
% Set the title
title('Calculated Temperature v/s Time')
% Label the x axis and y axis
ylabel('Temperature (Fahrenheit)')
xlabel('Time (Minutes)')
% Save the figure in .png format
saveas(gcf,'Newton_cooling_room_temp.png')
%%%
exit 
