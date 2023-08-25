
%%%  Problem 1
%%%  First go to the end of your m-file to create your Jacobi and
%%%  Gauss-Seidel functions.

%%% Once you have created your functions return here.
%%% Initialize your matrix A and RHS b
    
A = [1.1, 0.2, -0.2, 0.5; 0.2, 0.9, 0.5, 0.3; 0.1, 0, 1, 0.4; 0.1, 0.1, 0.1, 1.2];
b = [1; 0; 1; 0];

%%% Use your Jacobi and Gauss-Seidel functions to find A1 through A4.

[Tj_2, Ej_2] = jacobi(A, b, 10^-2);
[Tj_4, Ej_4] = jacobi(A, b, 10^-4);
[Tj_6, Ej_6] = jacobi(A, b, 10^-6);
[Tj_8, Ej_8] = jacobi(A, b, 10^-8);
[Tgs_2, Egs_2] = gauss_seidel(A, b, 10^-2);
[Tgs_4, Egs_4] = gauss_seidel(A, b, 10^-4);
[Tgs_6, Egs_6] = gauss_seidel(A, b, 10^-6);
[Tgs_8, Egs_8] = gauss_seidel(A, b, 10^-8);
A1 = [Tj_2, Tj_4, Tj_6, Tj_8];
A2 = [Ej_2, Ej_4, Ej_6, Ej_8];
A3 = [Tgs_2, Tgs_4, Tgs_6, Tgs_8];
A4 = [Egs_2, Egs_4, Egs_6, Egs_8];

%%%  Problem 2
%%%  Initialize your Day 0 vector x
    
x0 = [0.9; 0.09; 0.01];

      
%%%  Part 1: without a vaccine
%%%  Make sure to have p = 0
%%%  Initialize the SIR matrix M, and save it as A5

A5 = [1, 0, 0; 0, 1, 0; 0, 0, 1] + [-1/200, 0, 1/10000; 1/200, -1/1000, 0; 0, 1/1000, -1/10000];


%%%  Create a loop to find the day that the number of infected
%%%  individuals hits 50% and another loop for the steady state of the
%%%  infected population
%%%  There is a way to put everything under one loop if you make clever use
%%%  of conditionals

D0 = 0;
while x0(2) < 0.5
    x0 = A5 * x0;
    D0 = D0 + 1;
end

x0 = [0.9; 0.09; 0.01];

for i = 1:100000
    x0 = A5 * x0;
    x1 = A5 * x0;
    x2 = A5 * x1;
    if (x1(2) < 10^-8 && x2(2) < 10^-8)
        break
    end
end
F0 = x0(2);


%%% Save the days and steady state in a row vector A6


A6 = [D0 F0];


%%%  Reinitialize your Day 0 vector x


x0 = [0.9; 0.09; 0.01];
       

%%%  Part 2: with a vaccine
%%%  Make sure to have p = 2/1000
%%%  Initialize the SIR matrix M, and save it as A7


A7 = [1, 0, 0; 0, 1, 0; 0, 0, 1] + [-7/1000, 0, 1/10000; 1/200, -1/1000, 0; 2/1000, 1/1000, -1/10000];


%%%  Create a loop to find the day that the number of infected
%%%  individuals hits 50% and another loop for the steady state of the
%%%  infected population
%%%  There is a way to put everything under one loop if you make clever use
%%%  of conditionals

D1 = 0;
while x0(2) < 0.5
    x0 = A7 * x0;
    D1 = D1 + 1;
end

x0 = [0.9; 0.09; 0.01];

for i = 1:100000
    x0 = A7 * x0;
    x1 = A7 * x0;
    x2 = A7 * x1;
    if (x1(2) < 10^-8 && x2(2) < 10^-8)
        break
    end
end
F1 = x0(2);


%%% Save the days and steady state in a row vector A8

A8 = [D1 F1];
 
 
%%%  Problem 3
  
%%%  Initialize your 114x114 tridiagonal matrix A

A114 = diag(zeros(114, 1) + 2) + diag(zeros(113, 1) - 1, -1) + diag(zeros(113, 1) - 1, 1);

A9 = A114;


%%%  Initialize your 114x1 RHS column vector rho


p = zeros(114, 1);
for i = 1:114
    p(i) = 2 * (1 - cos((53 * pi)/115)) * sin(53 * pi * i/115);
end
A10 = p;

%%%  Implement Jacobi's method for this system.
%%%  Don't use the function you created before because that was designed for
%%%  a specific task, and will not work here.


j114 = A114;
L = tril(j114,-1);
U = triu(j114,+1);
D = diag(j114);
j114_old = ones(114,1);
M = -(L+U)./D;
c = p./D;
j114_new = M*j114_old+ c;
T = 2;
while(max(abs(j114_new - j114_old)) > 10^-5)
    j114_old = j114_new;
    j114_new = M*j114_old + c;
    T = T+1;
end
A11 = j114_new;
A12 = T;


%%%  Create a column vector phi that contains the exact solution given in
%%%  the assignment file

phi = zeros(114, 1);
for i = 1:114 
    phi(i) = sin((53 * pi * i)/115);
end


%%%  Save the difference of the Jacobi solution and the exact solution as
%%%  A13.  Use the maximal entry in absolute value to calculate this error.


A13 = max(abs(j114_new - phi));

%%%  Implement Gauss-Seidel for this system.
%%%  Don't use the function you created before because that was designed for
%%%  a specific task, and will not work here.

gs114_old = ones(114, 1);
gs114 = A114;
LpD = tril(gs114);
U = triu(gs114,+1);
M = -LpD\U;
c = LpD\p;
gs114_new = M*gs114_old + c;
T = 2;

while(max(abs(gs114_new - gs114_old) > 10^-5))
    gs114_old = gs114_new;
    gs114_new = M*gs114_old + c;
    T = T + 1;
end
A14 = gs114_new;
A15 = T;


%%%  Save the difference of the Gauss-Seidel solution and the exact solution as
%%%  A13.  Use the maximal entry in absolute value to calculate this error.


A16 = max(abs(gs114_new - phi));
  

%%% Jacobi and Gauss Seidel Iteration functions
%%% Create your functions here
%%% Both functions will need two outputs and three inputs
%%% The code within the function will be very similar to
%%% Week 4 coding lecture 2
function [T, x] = jacobi(A, b, e)
    y = zeros(4, 1);
    T = 0;
    L = tril(A,-1);
    U = triu(A,+1);
    D = diag(A);
    M = -(L+U)./D;
    c = b./D;
    while(max(abs((A * y) - b) > e))
        y = M*y + c;
        T = T + 1;
    end
    x = max(abs((A * y) - b));
end

function [T, x] = gauss_seidel(A, b, e)
    y = zeros(4, 1);
    T = 0;
    LpD = tril(A);
    U = triu(A,+1);
    M = -LpD\U;
    c = LpD\b;
    while(max(abs((A * y) - b) > e))
        y = M*y + c;
        T = T + 1;
    end
    x = max(abs((A * y) - b));
end

