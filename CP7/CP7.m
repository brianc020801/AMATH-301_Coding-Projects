%%% Problem 1
data = readmatrix('population.csv');
t = data(1, :);
N = data(2, :);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Determine your stepsize dt from the vector t
dt = 10;
A1 = backward_sec_order(24, dt, N);
A2 = central_sec_order(10, dt, N);
A3 = foward_sec_order(1, dt, N);
%%% Use the appropriate second order differences from the Theory Lecture
A4 = zeros(1,24);
for i = 1:24
    if i == 1
        A4(i) = foward_sec_order(i, dt, N);
    elseif i == 24 
        A4(24) = backward_sec_order(i, dt, N);
    else
        A4(i) = central_sec_order(i, dt, N);
    end
end
A5 = zeros(1,24);
for i = 1:24
    A5(i) = A4(i) / N(i);
end
A6 = mean(A5);


%%% For dN/dt you will need to use a combination of the above differences,
%%% but the choice will be obvious based on which direction you can/cannot
%%% go in the horizontal axis.  Whenever possible use central difference;
%%% only use forward or backward when central is not possible.




%%% Problem 2
data = readmatrix('brake_pad.csv');
r = data(1, :);
T = data(2, :);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Determine your stepsize dr from the vector r

dr = 0.017;

%%% Use the LHR formula from the coding lecture
T_new = T * 0.7051 * dr;
A7 = 0;
A_left = 0;
for i = 1:length(T) - 1
    A7 = A7 + (r(i) * T_new(i));
    A_left = A_left + (r(i) * 0.7051 * dr);
end
A8 = A7/A_left;

A9 = 0;
A_right = 0;
for i = 2:length(T)
    A9 = A9 + (r(i) * T_new(i));
    A_right = A_right + (r(i) * 0.7051 * dr);
end
A10 = A9/A_right;


%%% Use the RHR formula from the coding lecture

A9 = 0;
A_right = 0;
for i = 2:length(T)
    A9 = A9 + (r(i) * T_new(i));
    A_right = A_right + (r(i) * 0.7051 * dr);
end
A10 = A9/A_right;


%%% Use the Trapezoid rule formula or the trapz function from the coding lecture

A11 = (A7 + A9) / 2;
A12 = A11 / ((A_right + A_left) / 2);

%%% Problem 3
%%% You'll have to use anonymous functions here.  You can see the syntax in
%%% the Numerical Integration coding lecture where the builtin function
%%% "integrand" is used.


A13 = p3(0.95);
A14 = p3(0.5);
A15 = p3(0.01);

function y = foward_sec_order(x, h, data)
    y = (-3 * data(x) + 4 * data(x + 1) - data(x + (2 * 1))) / (2 * h);
end

function y = backward_sec_order(x, h, data)
    y = (3 * data(x) - 4 * data(x - 1) + data(x - (2 * 1))) / (2 * h);
end

function y = central_sec_order(x, h, data)
    y = (data(x + 1) - data(x - 1)) / (2 * h);
end

function y = p3(u)
    f = @(x)((x.^2/2) - (x.^3/3));
    T = @(z)(u./(sqrt(f(u) - f(u*z))));
    a = 0;
    b = 1;
    y = integral(T, a, b);
end
