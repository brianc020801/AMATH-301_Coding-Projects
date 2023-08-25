
%%% Problem 1
data = readmatrix('lynx.csv');
t = data(1, :);
pop = data(2, :);
%%% Don't delete the lines above when submitting to gradescope

%%% Replace the value of the population for the years given in the assignment file and save it as A1

pop(1, 11) = 34;
pop(1, 29) = 27;

A1 = pop;

%%% Calculate the value of the cubic spline interpolation of the data at t = 24.5 using the interp1 function.  Save this as A2.

A2 = interp1(t, pop, 24.5, 'spline', 'extrap');

%%% Use polyfit to calculate the coefficients for A3, A5, and A7
%%% Use norm to calculate the error for A4, A6, and A8

A3 = polyfit(t, pop, 1);
A4 = norm(polyval(A3, t) - pop);
A5 = polyfit(t, pop, 2);
A6 = norm(polyval(A5, t) - pop);
A7 = polyfit(t, pop, 10);
A8 = norm(polyval(A7, t) - pop);


%%% Problem 2
data = readmatrix('CO2_data.csv');
t = data(1, :);
co2 = data(2, :);
%%% Don't delete the lines above when submitting to gradescope

%%% Use polyfit to calculate the coefficients for A9
%%% Use norm to calculate the error for A10

A9 = polyfit(t, co2, 1);
A10 = norm(polyval(A9, t) - co2);

%%% Fit the exponential

coeffs = polyfit(t, log(co2 - 260), 1);
A11 = [exp(coeffs(2)), coeffs(1), 260];
A12 = norm(exp(A11(2) * t + log(A11(1))) + 260 - co2);

%%% Fit the sinusoidal
sum = 0;
seasons = co2 - (A11(1) * exp(A11(2) * t) + A11(3));
for i = 1: 12: 733
    sum = sum + ((max(seasons(i:i+11)) - (min(seasons(i:i+11))))/2);
end
A13 = [sum/62, 2*pi];
A14 = norm((A11(1) * exp(A11(2) * t) + A11(3) + (A13(1) * sin(A13(2) * t)))  - co2);
%%% There are a few different ways to do this, and we will refrain from giving away the answer to this part.  The class has been doing loops for a while now, so this part should be doable, albeit a little tricky.  We can however check to see if there are any bugs that we can spot.
