% Spencer Bertsch
% PSET 1
% Problem 2
% Operations Research 
% Fall 2018, Dartmouth College 
% I worked with: Ross Warner 
% I received advice from: Amritansh V., Carmen R. 
%

%Clear all variables 
clc
clear 

%% Section 1 
c= [56, 29, 35, 25, 47]; 

A=-[17, 9, 8, 7, 26; 13, 4, 30, 8, 18; 19, 9, 4, 17, 6; 0, 0, 0, -1, 0];

b= -[1000; 1000; 500; -15];

%define lower bound 
lb = [0;0];  

[x,fval,exitflag,output,lambda] = linprog(c,A,b,[],[],lb);

%% Section 2: Results 
disp('Question 2)') 
disp('Part a)') 
disp('Optimal Amount of Ingredient 1:')
disp(x(1))
disp('Optimal Amount of Ingredient 2:')
disp(x(2))
disp('Optimal Amount of Ingredient 3:')
disp(x(3))
disp('Optimal Amount of Ingredient 4:')
disp(x(4))
disp('Optimal Amount of Ingredient 5:')
disp(x(5))


disp('Part b)') 
disp('Shadow Price:')
disp(lambda.ineqlin)

disp('Reduced Cost:')
disp(lambda.lower)


% 
