%%% Problem 1
%%% Use ode45 to solve the Fitzhugh-Nagumo IVP
%%% For the maxima use the plot to narrow down the times you use to search
%%% for the maximum.
dt = 0.5;
T = 100;
t = 0:dt:T;
v0 = 1;
w0 = 0;
[T, Y] = ode45(@(t, y) Voltage(t, y), t, [v0, w0]);
A1 = Y(:, 1);
[v, A2] = max(A1(1:21));
A2 = t(A2);
[v, A3] = max(A1(81:101));
A3 = t(A3 + 80);
A4 = 1/(A3-A2);

%%% Problem 2
%%% Use ode45 to solve the Chua equation
%%% You can tell something is chaotic if it is seemingly random
%%% If it looks like all solutions tend toward a point or a circle it is
%%% not chaotic.
dt = 0.05;
T = 100;
t = 0:dt:T;
IV = [0.1; 0.2; 0.3];
alpha = 16;
beta = 30;
params = [alpha, beta];
[T, Y] = ode45(@(t, y) Chua(t, y, params), t, IV);
x1 = Y(:,1); y1 = Y(:,2); z1 = Y(:,3);
t1 = T;
plot(t1, x1);
A5 = 1;
A6 = transpose(Y);
IV = [0.1, 0.2 + 10^-5, 0.3];
[T, Y] = ode45(@(t, y) Chua(t, y, params), t, IV);
A7 = max(max(abs(A6 - transpose(Y))));
IV = [0.1; 0.2; 0.3];
beta = 100;
params = [alpha, beta];
[T, Y] = ode45(@(t, y) Chua(t, y, params), t, IV);
x1 = Y(:,1); y1 = Y(:,2); z1 = Y(:,3);
t1 = T;
plot(t1, x1);
A8 = 0;

%%% Problem 3

%%% Part 1: Finite Differences
%%% Use finite differences to solve the BVP
%%% Be careful about the shape of the vectors, you may have to transpose to
%%% get the correct shape.  It's a good idea to print the solutions out to
%%% make sure the shape is correct.

x0 = 1;
xT = 0.5;
T = 6;
dt = 0.1;

t = (0:dt:T);
n = length(t);
f = @(t)(5 * cos(4 * t));

v = (dt^2 - 2)*ones(n-2, 1);
u = ones(n-3, 1);
A = (1/dt^2) * (diag(v) + diag(u, 1) + diag(u, -1));

b = zeros(n-2, 1);
b(1) = f(t(2)) - x0/dt^2;
b(end) = f(t(60)) -xT/dt^2;
for i = 2:length(b)-1
    b(i) = f(t(i + 1));
end

A9 = A;
A10 = b;

x_int = A\b;
x = [x0; x_int; xT];
A11 = x;
t = t';

C1 = (1/2 + cos(24)/3 - 4*cos(6)/3)/sin(6);
C2 = 4/3;
x_true = @(t)(C1*sin(t) + C2*cos(t) - cos(4*t)/3);

plot(t, x_true(t), 'k', t, x, 'r')
err = max(abs(x - x_true(t)));
A12 = err;
%%% Part 2: Shooting Method via Bisection
%%% Use the shooting method to solve the BVP
%%% It's a good idea to test out a few in the command window first to make
%%% sure that your initial conditions gets you to different sides of the right
%%% boundary condition.
%%% Use the plot to help you figure out what your choices of initial
%%% conditions should be
x0 = 1;
v1 = 0;
v2 = 3;
%%% Test v1 and v2
[T, Y] = ode45(@(t, x) myODE(t,x), t, [x0 v1]);
Y(end, 1)
[T, Y] = ode45(@(t, x) myODE(t,x), t, [x0 v2]);
Y(end, 1)


v_mid = (v1 + v2)/2;
[T, Y] = ode45(@(t, x) myODE(t,x), t, [x0 v1]);
t_a = T; % for plotting
x_a = Y(:, 1);
[T, Y] = ode45(@(t, x) myODE(t,x), t, [x0 v2]);
t_b = T; % for plotting
x_b = Y(:, 1);
[T, Y] = ode45(@(t, x) myODE(t,x), t, [x0 v_mid]);
t_mid = T; % for plotting
x_mid = Y(:, 1);

plot(t_a, x_a, t_mid, x_mid, '--', t_b, x_b, 'linewidth', 4)

while abs(x_mid(end) - xT) > (10^-8)
    if sign(x_mid(end) - xT) == sign(x_a(end)-xT)
        v1 = v_mid;
        [T, Y] = ode45(@(t, x) myODE(t,x), t, [x0 v1]);
        t_a = T; % for plotting
        x_a = Y(:, 1);
    else
        v2 = v_mid;
        [T, Y] = ode45(@(t, x) myODE(t,x), t, [x0 v2]);
        t_b = T; % for plotting
        x_b = Y(:, 1);
    end
    v_mid = (v1 + v2)/2;
    [T, Y] = ode45(@(t, x) myODE(t,x), t, [x0 v_mid]);
    t_mid = T; % for plotting
    x_mid = Y(:, 1);
    plot(t_a, x_a, t_mid, x_mid, '--', t_b, x_b, 'linewidth', 4)
    pause(0.1)
end
A13 = x_mid;
A14 = max(abs(A13 - x_true(t)));
A15 = max(abs(A13 - A11));
%%% You can set up your ODEs as functions here if you like
function dv = Voltage(t, y)
    a = 0.7;
    b = 1;
    g = 12;
    v = y(1);
    w = y(2);
    I = @(t)((5 + sin((pi * t)/10))/10);
    dv1 = v - ((v^3)/3) - w + I(t);
    dv2 = (a + v - (b*w))/g;
    dv = [dv1; dv2];
end

function dx = Chua(t, v, params)
    alpha = params(1);
    beta = params(2);
    x = v(1);
    y = v(2);
    z = v(3);
    dx1 = alpha * (y + x/6 - (x^3)/16);
    dx2 = x - y + z;
    dx3 = -beta * y;
    dx = [dx1; dx2; dx3];
end

function dx = myODE(t, x)
    f = @(t)(5 * cos(4 * t)); 
    dx1 = x(2);
    dx2 = f(t) - x(1);
    dx = [dx1; dx2];
end
