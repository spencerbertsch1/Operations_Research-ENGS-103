% Spencer Bertsch
% PSET 1
% Problem 1
% Operations Research 
% Fall 2018, Dartmouth College 
% I worked with: Ross Warner 
% I received advice from: Amritansh V., Carmen R. 
% 

%Clear all variables 
clc
clear 

%% Section 1 
c= -[5.1, 1.4]; % C1 = -5.1, C2 = -1.4

A=[5, 2; 2, 0.5; 1, 0; 0, 1];

b=[600; 300; 80; 200];

%define lower bound 
lb = [0;0];  

[x,fval,exitflag,output,lambda] = linprog(c,A,b,[],[],lb);

%% Section 2: Results 
disp('Question 1)') 
disp('Part b)') 
disp('Optimal Number of Pastries:')
disp(x(1))
disp('Optimal Number of Muffins:')
disp(x(2))
disp('Optimal Profit:')
disp(-fval)


% ------------------------------------------------------------------------
%% Part (e) 
c= -[5.1, 1.4, 3.8]; % C1 = -5.1, C2 = -1.4

A=[5, 2, 0; 2, 0.5, 1; 1, 0, 0; 0, 1, 0; 0, 0, 1];

b=[600; 300; 80; 200; 99];

%define lower bound 
lb = [0;0;0];  

[x,fval,exitflag,output,lambda] = linprog(c,A,b,[],[],lb);

%% Results 
disp('') 
disp('Part e)') 
disp('Optimal Number of Pastries:')
disp(x(1))
disp('Optimal Number of Muffins:')
disp(x(2))
disp('Optimal Number of Candies:')
disp(x(3))
disp('Optimal Profit:')
disp(-fval)



