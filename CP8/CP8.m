%%% Problem 1
%%% Initialize t, and x_true
dt = 0.1;
T = 10;
t = 0:dt:T;
n = length(t);
A1 = zeros(1, n);
x0 = 1;
A1(1) = x0; 
x_true = @(t)(0.5 * (cos(t) + sin(t) + exp(-t)));



%%% Forward Euler
%%% Write a forward Euler scheme
tplot = 0:0.1:T;
for k = 1:n-1
    A1(k+1) = A1(k) + dt * (cos(t(k)) - A1(k));
end
plot(tplot, x_true(tplot), 'k', t, A1, 'r')
A2 = zeros(1, n);
for k = 1:n
    A2(k) = abs(A1(k) - x_true(t(k)));
end
%%% Backward Euler
%%% Write a backward Euler scheme
A3 = zeros(1, n);
A3(1) = x0;
for k = 1:n-1
    A3(k+1) = (A3(k) + dt * cos(t(k+1)))/(dt + 1);
end
plot(tplot, x_true(tplot), 'k', t, A3, 'r')
A4 = zeros(1, n);
for k = 1:n
    A4(k) = abs(A3(k) - x_true(t(k)));
end

%%% Built-in Solver
%%% Use ode45
%%% Don't forget to transpose the solution you get from ode45.

x_i = @(t, x)(cos(t) - x);
[t, x] = ode45(x_i, t, x0);
A5 = transpose(x);
plot(tplot, x_true(tplot), 'k', t, A5, 'r')
A6 = zeros(1, n);
for k = 1:n
    A6(k) = abs(A5(k) - x_true(t(k)));
end

%%% Problem 2
%%% Initialize the parameters
dt = 0.01;
T = 2;
t = 0:dt:T;
a = 8;
n = length(t);
A7 = zeros(1, n);
x0 = pi/4;
A7(1) = x0; 
x_true = @(t)(2 * atan((exp(8 * t)/(1 + sqrt(2)))));



%%% Forward Euler for dt = 0.01
%%% Initialize t and x_true
%%% Write a forward Euler scheme
tplot = 0:0.01:T;
for k = 1:n-1
    A7(k+1) = A7(k) + dt * (a * sin(A7(k)));
end
plot(tplot, x_true(tplot), 'k', t, A7, 'r')
A8 = zeros(1, n);
for k = 1:n
    A8(k) = abs(A7(k) - x_true(t(k)));
end
A8 = max(A8);

%%% Forward Euler dt = 0.001
%%% Reinitialize t and x_true
%%% Write a forward Euler scheme
dt = 0.001;
t = 0:dt:T;
n = length(t);
x = A7;
for k = 1:n-1
    x(k+1) = x(k) + dt * (a * sin(x(k)));
end
for k = 1:n
    x(k) = abs(x(k) - x_true(t(k)));
end
A9 = A8/max(x);

%%% Predictor-Corrector dt = 0.01
%%% Reinitialize t and x_true
%%% Write a forward Euler scheme and a backward Euler scheme in the same
%%% loop.
%%% The forward Euler scheme is the predictor.  The answer from forward
%%% Euler will be plugged into the sin(x_n+1) in the backward Euler scheme.
dt = 0.01;
t = 0:dt:T;
n = length(t);
A10 = A7;
for k = 1:n-1
    A10(k+1) = A10(k) + dt * a * sin(A10(k));
    A10(k+1) = A10(k) + dt * a * sin(A10(k+1));
end
plot(tplot, x_true(tplot), 'k', t, A10, 'r')
A11 = A10;
for k = 1:n
    A11(k) = abs(A10(k) - x_true(t(k)));
end
A11 = max(A11);
%%% Predictor-Corrector dt = 0.001
%%% Reinitialize t and x_true
%%% Write a forward Euler scheme and a backward Euler scheme in the same
%%% loop.
%%% The forward Euler scheme is the predictor.  The answer from forward
%%% Euler will be plugged into the sin(x_n+1) in the backward Euler scheme.
dt = 0.001;
t = 0:dt:T;
n = length(t);
x = A7;
for k = 1:n-1
   x(k+1) = x(k) + dt * a * sin(x(k));
   x(k+1) = x(k) + dt * a * sin(x(k+1));
end
for k = 1:n
    x(k) = abs(x(k) - x_true(t(k)));
end
A12 = A11/max(x);

%%% Builtin Solver
%%% Reinitialize t and x_true
%%% Use ode45 to solve the ODE.
%%% Don't forget to transpose the solution you get from ode45.
dt = 0.01;
t = 0:dt:T;
n = length(t);
x_i = @(t, x)(a * sin(x));
[t, x] = ode45(x_i, t, x0);
A13 = transpose(x);
A14 = zeros(1, n);
for k = 1:n
    A14(k) = abs(A13(k) - x_true(t(k)));
end
A14 = max(A14);
dt = 0.001;
t = 0:dt:T;
n = length(t);
[t, x] = ode45(x_i, t, x0);
for k = 1:n
    x(k) = abs(x(k) - x_true(t(k)));
end
A15 = A14/max(x);



%%%  If you want to write local functions, put them here
