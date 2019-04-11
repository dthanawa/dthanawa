%% Code Description:
% matrix_mutiply_p.m
%
% Description: Parallelization of matrix multiplication
% 
% Special requirements or dependencies:
% None; Tested in RHEL 7.4 with MATLAB R2017b
%
% Compilation (not necessary) and execution (from a Terminal):
% Takes 20-30 seconds on most modern hardware running Linux OS
%
%   export NPROCS=4 (E.g 1,2,4,6,8,16)
%   matlab -nodisplay -nosplash -r matrix_multiply_p -logfile matrix_multiply_p.txt

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

% Variable declaration and initialization
NPROCS = str2double(getenv('NPROCS'));

% Open the PARPOOL with NPROCS workers
parpool('local', NPROCS)

% Parfor loop BEGINS
parfor (i = 1:NPROCS)
    % Loop BEGINS for order N
<<<<<<< HEAD
    for j = 1 : 7
=======
    for N = 1 : 7
>>>>>>> d78c0cca372dc92f3f2e9b79f054a5709c6b51e6
         % Call Multiplication function
        Matrix_Multiply(2.^N);
    end % Loop ENDS for order N
 end % Parfor loop ENDS

% Stop the timer
toc

% Exit (comment the line below if running interactively)
exit

%% Multiplication Function
<<<<<<< HEAD

% Function BEGINS
function C = Matrix_Multiply(N)

=======

% Function BEGINS
function C = Matrix_Multiply(N)

>>>>>>> d78c0cca372dc92f3f2e9b79f054a5709c6b51e6
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
<<<<<<< HEAD
=======

>>>>>>> d78c0cca372dc92f3f2e9b79f054a5709c6b51e6
