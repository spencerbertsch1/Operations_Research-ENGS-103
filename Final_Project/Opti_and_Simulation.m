%%%% ENGG 103 -- Final Project 
% Dartmouth College - Fall 2018
% Operations Research - Professor Vikrant Vaze
% Spencer Bertsch, Amritansh Varshney, Ross Warner
% Optimization Section
% 

%% Clear all variables 
%clear all variables 
clear 
clc

%% Import Data
 
% Call setters and getters to create global variables which represent each of our
% raw datasets 

setGlobal_2003(csvread('2003Covariance.csv')); 
cov2003 = getGlobal_2003;

setGlobal_2004(csvread('2004Covariance.csv')); 
cov2004 = getGlobal_2004;

setGlobal_2005(csvread('2005_Covariance.csv')); 
cov2005 = getGlobal_2005;

setGlobal_2006(csvread('2006_Covariance.csv')); 
cov2006 = getGlobal_2006;

setGlobal_2007(csvread('2007_Covariance.csv')); 
cov2007 = getGlobal_2007;

setGlobal_2008(csvread('2008_Covariance.csv')); 
cov2008 = getGlobal_2008;

RETURNS = csvread('Avg_Returns.csv');

N = size(cov2003);
N = N(1);

Aeq = ones(1,N);
beq = 1;

%% SIMULATION
 
%NUMBER OF SIMULATIONS
simulations = 2; 

% Raw Data 
% ASSUMING NORMALLY DISTRIBUTED DEFAULT RATES
% Source - (statista.com/statistics/205964/us-mortgage-delinquency-rates-since-2000/)
% Annual Mean Values 
delin_avg = [1.83, 1.55, 1.55, 1.72, 2.55, 4.98];

% Annual Standard Deviations Values 
delin_std = [0.0901, 0.0897, 0.0788, 0.1249, 0.3858, 1.095];

% delin_avg= csvread("mortgage delinquency avg.csv")
% delin_std= csvread("mortgage delinquency std.csv")

%STORE OPTIMIZATION VALUES 
%Optimization code to get 1000 times for a single year
investment_strategy = zeros(26,6); 

%Three dimensional investment decisions - stored as: (All stocks, i'th year, j'th simulation)
Inv_Strategy_Matx = zeros(26,6,simulations); 

TEST = [];
d_values = [];

for i= 1:6
   for j= 1:simulations
        
        %Statistics 
        mu = delin_avg(i); 
        STD = delin_std(i);
        X = normrnd(mu,STD); 
        
        half_sigma = mu + (STD/2);  
        sigma = mu + STD; 
        three_half_sigma = mu + ((3*STD)/2);
        two_sigma = mu + (2*STD); 
        
        if (X < mu)
            c_rating = 'AAA';
            MBS_ub = 1; %Maximum percentage portfolio investment into AAA rated MBS
            
        elseif (X >= mu && X < half_sigma)
            c_rating = 'AA';
            MBS_ub = 0.9; %Maximum percentage portfolio investment into AA rated MBS
            
        elseif (X >= half_sigma && X < sigma)
            c_rating = 'A';
            MBS_ub = 0.7; %Maximum percentage portfolio investment into A rated MBS
            
        elseif (X >= sigma && X < three_half_sigma)
            c_rating = 'BBB';
            MBS_ub = 0.5; %Maximum percentage portfolio investment into BBB rated MBS
            
        elseif (X >= three_half_sigma && X < two_sigma)
            c_rating = 'BB';
            MBS_ub = 0.3; %Maximum percentage portfolio investment into BB rated MBS
            
        else
            c_rating = 'B';
            MBS_ub = 0.1; %Maximum percentage portfolio investment into B rated MBS
            
        end
        
       TEST(i,j) = MBS_ub; %store values for inspection
       X_values(i,j) = X; 
        
        % ~~~ OPTIMIZATION ~~~

        A = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0]; 
        B = MBS_ub; %<--- This B comes from the result of the simulation!
        
        temp_objective = @(x) -x'*(RETURNS(1,:)'); %objective function

        x0 = zeros(N,1); %Initial guess 

        %Linear Equality Constraints
        Aeq = ones(1,N);  
        beq = 1; 

        high_cap = 0.2; %<-- Force investments in several funds 
        low_cap = 0; 

        lb = low_cap * (ones(N,1)); %lower bound for each variable is zero, signifying no investment 
        ub = high_cap * (ones(N,1)); %upper bound for each variable is one, signifying investment in a single fund cannot exceed 100%

        
        %optimization code - stores results in 3D matrix of investment info
        if(i==1)
            non_lin_con1 = @nlcon1;
            investment_strategy(:,1) = fmincon(temp_objective, x0, A, B, Aeq, beq, lb,ub, non_lin_con1);
            Inv_Strategy_Matx(:, i, j) = investment_strategy(:,1); %(All stocks, i'th year, j'th simulation)
        elseif (i==2)
            non_lin_con2 = @nlcon2;
            investment_strategy(:,2) = fmincon(temp_objective, x0, A, B, Aeq, beq, lb,ub, non_lin_con2);
            Inv_Strategy_Matx(:, i, j) = investment_strategy(:,2); %(All stocks, i'th year, j'th simulation)
        elseif (i==3)
            non_lin_con3 = @nlcon3;
            investment_strategy(:,3) = fmincon(temp_objective, x0, A, B, Aeq, beq, lb,ub, non_lin_con3);
            Inv_Strategy_Matx(:, i, j) = investment_strategy(:,3); %(All stocks, i'th year, j'th simulation)
        elseif (i==4)
            non_lin_con4 = @nlcon4;
            investment_strategy(:,4) = fmincon(temp_objective, x0, A, B, Aeq, beq, lb,ub, non_lin_con4);
            Inv_Strategy_Matx(:, i, j) = investment_strategy(:,4); %(All stocks, i'th year, j'th simulation)
        elseif (i==5)  
            non_lin_con5 = @nlcon5;
            investment_strategy(:,5) = fmincon(temp_objective, x0, A, B, Aeq, beq, lb,ub, non_lin_con5);
            Inv_Strategy_Matx(:, i, j) = investment_strategy(:,5); %(All stocks, i'th year, j'th simulation)
        else 
            non_lin_con6 = @nlcon6;
            investment_strategy(:,6) = fmincon(temp_objective, x0, A, B, Aeq, beq, lb,ub, non_lin_con6);
            Inv_Strategy_Matx(:, i, j) = investment_strategy(:,6); %(All stocks, i'th year, j'th simulation)
        end
        

    end
end %Outer loop gives the 1000 optimization values for all the years

    
%% Visualize Results 

% disp('RESULTS'); 
% disp(investment_strategy(:,1))
% %plot(investment_strategy(:,1))
% 
% figure('Position',[97   22   1216   776]); %make initial size large
% plot(investment_strategy(:,1),'b','linewidth',1.2)
% hold on
% plot(investment_strategy(:,2),'black','linewidth',1.2)
% hold on
% plot(investment_strategy(:,3),'cyan','linewidth',1.2)
% hold on
% plot(investment_strategy(:,4),'m','linewidth',1.2)
% hold on
% plot(investment_strategy(:,5),'g','linewidth',1.2)
% hold on
% plot(investment_strategy(:,6),'y','linewidth',1.2)
% grid 
% xlabel('Investment Option - Security, T-Bill, or MBS','fontSize',20);
% ylabel('Percentage of Portfolio Invested','fontSize',20);
% title('Optimized Portfolio Investment in Each Stock','fontsize',22)
% hold off

%% More visualization - stacked bar chart
%SOURCE: mathworks.com/matlabcentral/answers/175955-how-to-assign-a-label-to-each-bar-in-stacked-bar-graph
D = investment_strategy;
figure(1)
hBar = bar(D, 'stacked');
h = legend('2003','2004','2005','2006','2007','2008');
set(h,'FontSize',13,'Location','northwest');
xlabel('Investment Option - Security, T-Bill, or MBS','fontSize',20);
ylabel('Portfolio Investment - Annual Percentage','fontSize',20);
title('Optimized Portfolio Investment in Each Security','fontsize',22)



%% surf test
% figure(1), surf(investment_strategy);
% colormap parula  
% colorbar
% xlabel('Time (Years Since 2002)','fontSize',20)
% ylabel('Invested Security','fontSize',20)
% zlabel('Percentage Portfolio Invested','fontSize',20) 
% title('Portfolio Investments between 2003 and 2008', 'fontSize',22)


%% Define Necessary Functions

function[c, ceq] = nlcon1(x)

    cov2003 = getGlobal_2003;
    
    Risk=x'*cov2003*x;
    
    %Return c and ceq
    c = Risk; 
    ceq = 0; 
    
end

function[c, ceq] = nlcon2(x)

    cov2004 = getGlobal_2004;
    
    Risk=x'*cov2004*x;
    
    %Return c and ceq
    c = Risk; 
    ceq = 0; 
    
end

function[c, ceq] = nlcon3(x)

    cov2005 = getGlobal_2005;
    
    Risk=x'*cov2005*x;
    
    %Return c and ceq
    c = Risk; 
    ceq = 0; 
    
end

function[c, ceq] = nlcon4(x)

    cov2006 = getGlobal_2006;
    
    Risk=x'*cov2006*x;
    
    %Return c and ceq
    c = Risk; 
    ceq = 0; 
    
end

function[c, ceq] = nlcon5(x)

    cov2007 = getGlobal_2007;
    
    Risk=x'*cov2007*x;
    
    %Return c and ceq
    c = Risk; 
    ceq = 0; 
    
end

function[c, ceq] = nlcon6(x)

    cov2008 = getGlobal_2008;
    
    Risk=x'*cov2008*x;
    
    %Return c and ceq
    c = Risk; 
    ceq = 0; 
    
end


%Make setters and getters !

% ------ 2003 ------

function setGlobal_2003(cov2003)
global x1
x1 = cov2003;
end

function return_value = getGlobal_2003
global x1
return_value = x1;
end

% ------ 2004 ------

function setGlobal_2004(cov2004)
global x2
x2 = cov2004;
end

function return_value = getGlobal_2004
global x2
return_value = x2;
end

% ------ 2005 ------

function setGlobal_2005(cov2005)
global x3
x3 = cov2005;
end

function return_value = getGlobal_2005
global x3
return_value = x3;
end

% ------ 2006 ------

function setGlobal_2006(cov2006)
global x4
x4 = cov2006;
end

function return_value = getGlobal_2006
global x4
return_value = x4;
end

% ------ 2007 ------
function setGlobal_2007(cov2007)
global x5
x5 = cov2007;
end

function return_value = getGlobal_2007
global x5
return_value = x5;
end

% ------ 2008 ------

function setGlobal_2008(cov2008)
global x6
x6 = cov2008;
end

function return_value = getGlobal_2008
global x6
return_value = x6;
end

