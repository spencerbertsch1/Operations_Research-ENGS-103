% Spencer Bertsch
% Worked with Carmen R. 
% ENGS 103
% PSET 3 
% Problem 8
% Spring - Dartmouth College 

% clear variables and command window 
clc
clear

%% Define Matrix 
% Define Matrix based on Google Maps Data 
% -------------------------------------------------------------------------
% Note that the distance between Point A and Point B will be the same as
% the distance between Point B and Point A. This means that our matrix will
% be symmetric about the main diagonal. Our resulting matrix will be an
% adjacency matrix filled with distance values. 

M = 1000000; %Set M equal to a large distance (1 million miles) 

D = [M,M,M,23,31,M,M,M,13,17;
     M,M,5,M,M,17,M,M,M,49;
     M,5,M,12,8,50,M,M,55,M;
     23,M,12,M,M,M,4,M,M,6;
     31,M,8,M,M,56,6,11,M,M;
     M,17,50,M,56,M,M,65,M,M;
     M,M,M,4,6,M,M,M,41,M;
     M,M,M,M,11,65,M,M,M,27;
     13,M,55,M,M,M,41,M,M,61;
     17,49,M,6,M,M,M,27,61,M];

D_test = [M 3.5 4.8 5 M M M M M M;
    3.5 M 4.5 M M 7 M M M M;
    4.8 4.5 M 2.5 8.5 6.5 M M M M;
    5 M 2.5 M M M 4 M M M;
    M M 8.5 M M 7.5 2.4 1.5 1 M;
    M 7 6.5 M 7.5 M M 8 M M;
    M M M 4 2.4 M M M 2.2 M;
    M M M M 1.5 8 M M M 2;
    M M M M 1 M 2.2 M M 3;
    M M M M M M M 2 3 M];


%% Set Initial Conditions 

curTreeNodes = [1]; %represents the set of nodes in current tree

curTree = []; %Represents the set of arcs in the current tree. 

vals = zeros(9); 
%% Loop

for (i = 1:9) %#ok<*NO4LP>
    
    cur_rows = D * M;
    
    %Reduce only the current rows in matrix 
    cur_rows(curTreeNodes,:) = cur_rows(curTreeNodes,:) * (1/M);

    %If the column number is in the current set of nodes, multiply by M
    cur_rows(:,curTreeNodes) = cur_rows(:,curTreeNodes) * M;
    
    [val, ind] = min(cur_rows(:));
    c = ceil(ind/size(cur_rows,1)); 
    r = ind - (c-1) * size(cur_rows,1); 
    
    
    vals(i) = val; 
    
    %Update Current Tree Nodes
    curTreeNodes = horzcat(curTreeNodes, c); 
    
    %Update Current Tree Arcs
    new_branch = [r,c]; 
    curTree = vertcat(curTree, new_branch);

end

disp("Final Tree Paths:") 
disp(curTree)

sum_vals = sum((sum(vals)));

disp("Minimum cost fiber optic network for the company:") 
disp(sum_vals)


