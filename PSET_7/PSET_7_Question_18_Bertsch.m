% ENGM 103 PSET 7 
% Question 18
% Spencer Bertsch
% Worked with: Ross Warner
% Original Source Code: Professor Vikrant Vaze. 
% Dartmouth College - Fall 2018 

%clear all variables 
clear
clc

%% Declare Vars
%Declare Variables 
N = 2;
S = [100; 100]; %<-- Capacity of plane 
p = 200; %<-- Ticket Fare (p) = $200.00
C = [10000;10000]; %<-- 
M = 1000; %<-- Market size (M) = 1000 passengers
tol = 0; %<-- toleranc to break the while loop 
x = [0;0]; %<-- Number of flights offered by each player 
max_flights = 20; %<-- Max flights offered by each company
plane_size = [80, 100, 120]; %<-- plane size 

% TESTING DIFFERENT INITIAL VALUES FOR S and x 
S = [100; 100]; x = [0;0]; %<-- Test 1, RESULT: NO CHANGE 
S = [80; 80]; x = [10;10]; %<-- Test 2, RESULT: NO CHANGE 
S = [120; 120]; x = [15;10]; %<-- Test 3, RESULT: NO CHANGE 
S = [80; 120]; x = [5;5]; %<-- Test 4, RESULT: NO CHANGE 
S = [120; 80]; x = [5;10]; %<-- Test 5, RESULT: NO CHANGE 
S = [80; 100]; x = [10;5]; %<-- Test 6, RESULT: NO CHANGE 
S = [100; 80]; x = [0;10]; %<-- Test 7, RESULT: NO CHANGE 
S = [100; 120]; x = [10;0]; %<-- Test 8, RESULT: NO CHANGE 
S = [120; 100]; x = [5;0]; %<-- Test 9, RESULT: NO CHANGE 
S = [90; 110]; x = [0;-5]; %<-- Test 10, RESULT: NO CHANGE 
%ALL TESTS CONVERGED TO THE SAME NASH EQUILIBRIUM

%NEW VARIABLES 
small_plane = 80; %<-- small_plane has 80 seats 
medium_plane = 100; %<-- medium_plane has 80 seats 
large_plane = 120; %<-- large_plane has 80 seats 

profits= -1 * ones(max_flights+1,1);

profits_matrix= -1 * ones(21,3);

%% Find optimal number of seats and plane size
while (1)
    dev_flight = 0; %<-- initialize dev flights
    dev_seat = 0; %<-- Initialize dev seats 
    x_prev=x;
    
    for i=1:N
        disp('Optimal number of flights:')
        disp(x') %<-- diaplay number of seats
        disp('Optimal Number of Seats:')
        disp(S') %<-- diaplay plane capacity
        
        for j=0:max_flights
            
            %Populate the cost matrix for three different plane sizes 
            for k=1:3
              
                if(k==1)
                    plane = small_plane;
                elseif(k==2)
                    plane = medium_plane;
                else
                    plane = large_plane;
                end
                
                S_ = S; 
                S_(i) = plane; %<-- set plane size
                
                 x_=x;
                 x_(i)=j;
                 pax=min(M*(power(x_(i),1.5)/sum(power(x_,1.5))),x_(i)*S_(i)); %<-- Number of passengers
                 rev=p*pax; %<-- Calculate revenue 

                 operate_cost = (2000 + (80*plane)); %<-- Find new cost for this plane 
                 total_cost = operate_cost * x_(i); 
                 new_profit = (rev - total_cost); %<-- Find optimal profit
                 profits_matrix(j+1, k)=new_profit;  
                
            end
        
        end
        
        max_profit = max(max(profits_matrix)); 
        [ind_flight, ind_seat] = find(profits_matrix == max_profit); 
        
        dev_flight = dev_flight + abs(x(i)-(ind_flight-1)); 
        dev_seat = dev_seat + abs(S(i)-(plane_size(ind_seat)));

        
         x(i) = ind_flight-1; %<--Number of flights offered on the i'th iteration 
         S(i) = (plane_size(ind_seat)); %<--Capacity of plane on this iteration
    
    end
    
    if(dev_flight <= tol && dev_seat <= tol)
        
        break;
    end
end


%% Calculate range of acceptable x-values to consider 

% passengers = (ci/p) 

operating_cost = operate_cost;
passengers = (operating_cost)/p; 

market_size = M; 
total_flights = market_size/passengers; 

disp('total flights')
disp(total_flights)





