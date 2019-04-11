%% Code Details:
% matrix_multiply_s.m
%
% Description:
% Computes the Multiplication of Matrices
%
% Special requirements or dependencies:
% None; Tested in RHEL 7.4 with MATLAB R2017b
%
% Compilation and execution:
% Compilation not necessary
% Execution takes approx 1-2 seconds on most modern hardware.
%
% For the execution in LINUX terminal
% matlab -nodisplay -nosplash -singleCompThread -r matrix_multiply_s -logfile matrix_multiply_s.log
%% Clear the old data from workpace,command window and figure.
clear;
clc;
clf;
close all;

%% Initialization

% Define format of all variable to long
format long;

% Timer starts for the code
tic

% Create the .dat file
fout = fopen('birthday_paradox.dat', 'w');

% Print the header
fprintf(fout,"N\tProb\n");

% Memory Preallocation for Time array
t = zeros(1,7);
% Loop BEGINS for order N
for N = 1 : 7
    
    % Timer starts for every value of N
    tic
    
    % Call Multiplication function
    Matrix_Multiply(2.^N);
    
    % Timer ends for N and save the time 
    t(N) = toc;
end % Loop ENDS
%% Plot

% x axis
x = 1 : 7;

% curvefit
p = polyfit(x,t,10);
y = polyval(p,1:0.05:7);

% plot the graph
plot(x,t(x),'-ko',1:0.05:7,y);

% Label the axis
xlabel({'i';'(N = 2^i)'});
ylabel('Running time for N');

% Grid on
grid on;

% Set axis Limit
axis([0 8 -0.01 0.1]);

% Set legend for the graph
legend('Actual graph','Curve-fit')

% Save the graph to .png format
saveas(gcf,'matrix_multiply_s.png')

% Timer off for the code
toc

% Exit code
%exit

%% Multiplication Function

% Function BEGINS
function C = Matrix_Multiply(N)

% Memory Preallocation for Order N matrix
A = zeros(N,N);
B = zeros(N,1);
C = zeros(N,1);

% Generate the matrix A 
% Loop BEGINS
for i = 1:N
    for j = 1:N
        A(i,j) = i*(N-i-1)*j*(N-j-1);
    end
end % Loop ENDS

% Print Matrix A
A


% Generate the matrix B 
% Loop BEGINS
for i = 1:N
    B(i,1)=i+3;
end % Loop ENDS

% Print Matrix B
B

% Save rows and columns of 
[rowsA, colsA] = size(A);
[rowsB, colsB] = size(B);


% Multiplication 

% Row Loop BEGINS
for r = 1 : rowsA
    
    % Columns Loop BEGINS
    for c = 1 : colsB
        
        % Initialize Sum =0
        Sum = 0;
        
        % Multiplication Loop BEGINS (Row by Columns)
        for k = 1 : colsA
            
            % Row by Coloumn Multiplication
            Sum = Sum + A(r, k) * B(k, c);
        end % Multiplication Loop ENDS
        C(r, c) = Sum;
    end % Columns Loop ENDS
end % Rows Loop ENDS

% Print Matrix B
C

end % Function ENDS
