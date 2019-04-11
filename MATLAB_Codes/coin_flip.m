% coin_flip.m
%
% Description:
% Computes the probability of getting heads from flipping a coin 10 times
% for the fairness factor p=0:0.1:1
%
% Special requirements or dependencies:
% None; Tested in RHEL 7.4 with MATLAB R2017b
%
% Compilation and execution:
% Compilation not necessary
% Execution takes a few seconds on most modern hardware.
% 
%For the execution in LINUX terminal 
% matlab -nodisplay -nosplash -singleCompThread -r coin_flip -logfile coin_flip.log
%


% 
clc;
close all;
clear all;
format long;

% Initializing variables
heads = 0;
prob  = 0.0;
fman  = 0.0;           % Fairness factor manipulator
c     = 1;             % Counter
total = zeros(100,11); % Total numbers of heads for each p

% Open the file
fout = fopen('coin_flip.dat', 'w');

% Fairness factor loop BEGINS
for p = 0.0:0.1:1.0 %fairness factor
    % Coin flip loop BEGINS
    for i = 1:1:100
        % Variable declaration and initiliazation
        heads = 0;
        prob  = 0.0;

        % for j = 1:1:10%set of flip coin 10 times
        for j = 1:1:10
           fman = rand();
           prob = (p*10)+fman; %find the prob of coin in 10 flips

           % Heads or Tails based on fairness factor
           if prob >= 0.5 && fman <= p
              heads = heads + 1; 
           end            
        end

        % Debug BEGINS
        % fprintf ("p : %f , heads : %d, i : %d, j : %d\n ", c, heads, i, j);
        % Debug ENDS

        % Write the data to the file
        fprintf(fout,"%f % d \n",p,heads);%stores the data in file
        total(i, c) = heads;       
    end
    % Coin flip loop ENDS

    % Increament the counter
    c = c+1;
end
% Fairness factor loop ENDS

fclose(fout);%close the file

% Plot
sz = size(total);
figure(1)
x = repmat(linspace(0,1,sz(2)),sz(1),1);
axis([0,1.1,-1,11])
plot(x+0.001*rand(sz),total+0.6*rand(sz),'ko','MarkerEdgeColor','red',...
    'MarkerSize',20)
xlabel('Fairness (p)')
ylabel('# of heads in 10 tosses')
set(gca,'Xtick',-0.1:0.1:1)
set(gca,'Ytick',-1:1:11)
grid on;
