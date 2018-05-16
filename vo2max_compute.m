%% Description
% vo2max_compute.m
%
% Description:
% Calculates the Daniels and Gilbert formula for VO2Max using d is 
% the distance in meters, t is the time in minutes, and v is the 
% speed in meters per minute.
%
% Special requirements or dependencies:
% None; Tested in RHEL 7.4 with MATLAB R2017b
%
% Compilation and execution:
% Compilation not necessary
% Execution takes a few seconds on most modern hardware.
%
% matlab -nodisplay -nosplash -singleCompThread -r "vo2max_compute('distance in miles', 'time in h:mm:ss format')" -logfile vo2max_compute.log

%% VO2_Compute Function
% Function BEGINS
function vo2max = vo2max_compute(dist, t) 
    % Convert time to minutes
    time_minutes = time2minutes(t);
    % Convert distance from miles to meters
    meters_distance = miles2meters(dist);
    % Calculate running speed of v = d/t meters per minute
    vel = meters_distance/time_minutes;
    % To calculate the value of vo2max split the equation to two parts
    % i.e., Numerator and Denominator
    % Calculating Numerator (Oxygen Cost)
    oxygen_cost = 0.000104 * vel^2 + 0.182258 * vel - 4.60;
    % Calculating Denominator (Drop Dear)
    drop_dead = 0.2989558 * exp(-0.1932605 * time_minutes) + 0.1894393 * exp(-0.012778 * time_minutes) + 0.80;
    % Calculate vo2max
    vo2max = oxygen_cost/drop_dead;
    % Debug
    %disp(vo2max);
end % Function ENDS
%% Convert Distance Function
function dist = miles2meters(miles)
    % Convert distance in miles to meters
    dist = str2double(miles)*(1/0.00062137);
end
%% Convert Time Function
function minutues = time2minutes(time) 
%   Convert time format to minutes
    [~, ~, ~, H, MN, S] = datevec(time);
    minutues = H*60+MN+S*(1/60);
end
