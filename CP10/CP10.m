%%% Problem 1
%%% First model the problem, and then solve it using ode45.
T = 6;
dt = 0.01;
t = 0:dt:T;
s0 = 2; % g
v1_0 = 1; % L
v2_0 = 1; % L
[T, Y] = ode45(@(t, y) Volume(t, y), t, [v1_0, v2_0]);
A1 = Y(:, 1);
A2 = Y(:, 2);

indx = find(A2 > 10);
A3 = round(t(indx(1)));
A4 = 2;

[T, Y] = ode45(@(t, y) Salt(t, y), t, [s0, s0, v1_0]);
A5 = Y(:, 1);
A6 = Y(:, 2);

A7 = A6(indx(1))/A2(indx(1));
%%% Problem 2
%%% Use finite differences for boundary value problems and loop to iterate
%%% each timstep

dx = 0.01;
x = [-1:dx:1];
dt = 0.01;
X = length(x);

u_f = @(x)(exp(1 - (1./(1-x.^2))));
u = transpose(u_f(x));

mu = dt/(2*dx^2);

u_a = 0; u_b = 0;

main_diag = (1+2*mu)*ones(1,X-2);
second_diag = -mu*ones(1, X-3);
A = diag(main_diag) + diag(second_diag,1) + diag(second_diag, -1);
main_diag = (1-2*mu)*ones(1,X-2);
B = diag(main_diag) - diag(second_diag,1) - diag(second_diag, -1);

    %%%plot(x,u)
    %%%axis([-1 1 0 2])
    %%%pause(0.1)
    %%%hold on

A8 = A;
b = B*u(2:end-1);
b(1) = b(1) + mu*u_a;
b(end) = b(end) + mu*u_b;
A9 = b;

u_vals = zeros(201, 101);
u_vals(:, 1) = u;

i = 2;
for t = dt:dt:1
    b = B*u(2:end-1);
    b(1) = b(1) + mu*u_a;
    b(end) = b(end) + mu*u_b;
    u(2:end-1) = A\b;
    u_vals(:, i) = u;
    i = i + 1;
    %%%plot(x,u)
    %%%axis([-1 1 0 2])
    %%%pause(0.1)
end
A10 = b;
%%%hold off
A11 = u(151);
A12 = 0;
%%% Problem 3

load CP10_M1.mat
load CP10_M2.mat
load CP10_M3.mat
%%%%%%%%%%%%%%%%%
U = M2;
S = M3;
V = M1;
data = M2 * M3 * M1;
A13 = 672 * 658 * (8/10^6);

k = 1;
[m,n] = size(data);
while (m * k + k + n * k)/(m * n) < 0.99
    k = k + 1;
end

W = V';
[m,n] = size(A);
B =  U(:,1:k)*S(1:k,1:k)*W(1:k,:);
size_B  = size(B);
B = uint8(B);
imshow(B)
fprintf('Compression ratio = %.5f', (m*k+k+n*k)/(m*n))
A14 = k;
A15 = 672 * 658 * (8/10^6);
A16 = 17;
%%% Functions
function dv = Volume(t, v)
    dv1 = 2 - v(1);
    dv2 = v(1);
    dv = [dv1; dv2];
end
function ds = Salt(t, s)
    dv1 = 2 - s(3);
    ds1 = 2 - (s(1)/s(3) * s(3));
    ds2 = s(1);
    ds = [ds1; ds2; dv1];
end
