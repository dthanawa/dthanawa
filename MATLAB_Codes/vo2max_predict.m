%% Description
% vo2max_predict.m
%
% Description:
% Computes time and error using calculated vo2_max in vo2max_compute.m
% and distance.
%
% Special requirements or dependencies:
% None; Tested in RHEL 7.4 with MATLAB R2017a
%
% Compilation and execution:
% Compilation not necessary
% Execution takes a few seconds on most modern hardware.
%
% matlab -nodisplay -nosplash -singleCompThread -r "vo2max_predict('distance in miles', 'time in h:mm:ss format')" -logfile vo2max_predict.log

% The main function name must match the filename
%% VO2Predict Function
% Function BEGINS 
function tc = vo2max_predict(dist, time)
        % Check whether file exists or not
        if exist('vo2max.dat', 'file') == 2
        % File exists.
        % Open and read the file 
        fout = fopen('vo2max.dat', 'rt');
        % Scan the data in file
        A = textscan(fout, '%s %f', 'HeaderLines', 1);
        % Select first column from data
        B = A{1};
        % Close the file
        fclose(fout);
        % Finding the index of 
        index = find(strcmp(B, dist));
        vo2max_arr = A{2};
        vo2max =  vo2max_arr(index);
        % Call time functions which converts in minutes
        t_new = time2minutes(time);
        % Conversion of miles in to meters
        meters_dist = miles2meters(dist);
        % Convert time to minutes
        minutes_time = time2minutes(time);
        error_flag = 1;
        while(error_flag > 0)
            t = t_new;
            % Daniels and Gilbert Equation
            f_t = vo2max * (0.2989558 * exp(-0.1932605 * t) + 0.1894393 * exp(-0.012778 * t) + 0.80) - (0.000104 * (meters_dist/t).^2 + 0.182258 * (meters_dist/t) - 4.60);
            df_t = vo2max * (0.2989558 * -0.1932605 * exp(-0.1932605 * t) + 0.1894393 * -0.012778 * exp(-0.012778 * t)) - (-2 * 0.000104 * meters_dist.^2 * (1/t).^3 + -1 * 0.182258 * meters_dist * (1/t).^2);

            % Using Newton Raphson method to find the roots of f_t equation
            t_new = t - f_t/df_t;
            % Check and Stop when error is less than set value 
            if(abs(t_new - t) <= 0.001)
                error_flag = -1;
                tc = t_new;
            end
        end
        % Compute time
        tc = minutes2time(t_new);
        % Error
        error = abs(t_new - minutes_time)
        else
        % File doesn't exist
        fprintf('File does not exist');
    end
end % Function ENDS
%% Distance Conversion
% Function BEGINS
function distance = miles2meters(miles)
%   Convert distance in miles to meters
    distance = str2double(miles)*(1/0.00062137);
end % Function ENDS
%% Time Conversion
% Function BEGINS
function minutues = time2minutes(time) 
%  Convert time format to minutes
    [~, ~, ~, H, MN, S] = datevec(time);
    minutues = H*60+MN+S*(1/60);
end % Function ENDS
% Function BEGINS
function time = minutes2time(min) 
%  Convert time format to minutes
    time = datestr(minutes(double(min)),'HH:MM:SS');
end % Function ENDS
