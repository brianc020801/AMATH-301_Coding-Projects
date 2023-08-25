
%%% Problem 1
%%% Implement the Bisection method as we did in the Week 5 Coding Lecture
t = [0:5];
c = 1.3 * (exp(-t/11) - exp(-4 * t / 3));
dc = 1.3 * ((-1/11 * exp(-t/11)) - (-4/3 * exp(-4 * t / 3)));
plot(t, c, 'linewidth', 4)
a = 1.5;
b = 2.5;
df_a = 1.3 * ((-1/11 * exp(-a/11)) - (-4/3 * exp(-4 * a / 3)));
df_b = 1.3 * ((-1/11 * exp(-b/11)) - (-4/3 * exp(-4 * b / 3)));
xmid = (a+b)/2;
df_mid = 1.3 * ((-1/11 * exp(-xmid/11)) - (-4/3 * exp(-4 * xmid / 3)));
for i = 1:1000
    if df_mid == 0
        break
    else if sign(df_mid) == sign(df_a);
            a = xmid;
    else
        b = xmid;
    end
    end
    xmid = (a+b)/2;
    df_mid = 1.3 * ((-1/11 * exp(-xmid/11)) - (-4/3 * exp(-4 * xmid / 3)));
    df_a = 1.3 * ((-1/11 * exp(-a/11)) - (-4/3 * exp(-4 * a / 3)));
    df_b = 1.3 * ((-1/11 * exp(-b/11)) - (-4/3 * exp(-4 * b / 3)));
end
A1 = xmid;
A2 = 1.3 * (exp(-xmid/11) - exp(-4 * xmid / 3));
A3 = df_mid;


%%% Problem 2
%%% Implement Newton's method as we did in the Week 5 Coding Lecture
x = 2;
i = 1;
while 2 * x > 10^-8
    x = x - (2 * x)/(2);
    i = i + 1;
end
A4 = i;
A5 = x;

x = 2;
i = 1;
while 500 * (x^499) > 10^-8
    x = x - ((500 * (x^499))/(249500 * (x^498)));
    i = i + 1;
end
A6 = i;
A7 = x;

x = 2;
i = 1;
while 1000 * (x^999) > 10^-8
    x = x - ((1000 * (x^999))/(999000 * (x^998)));
    i = i + 1;
end
A8 = i;
A9 = x;