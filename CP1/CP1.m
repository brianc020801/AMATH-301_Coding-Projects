
    

    %%% Problem 1
    %%% Initialize A, B, C, x, y, and z.  Then do the calculations for A1 to A5
    A = [3, -0.5; 3.14, exp(3)];
    B = [1, 2, 3, -4; pi, 6, 3, -1.4];
    C = [2.7, -3.4, 0; 1, 5.5, -3.7; 4.5, -1.1, 6.7];
    x = [1; cos(4); -2];
    y = [3, -5];
    z = [2; 0; tan(2); -3.6];
    
    A1 = 3 * x;
    A2 = (transpose(z) * transpose(B)) + y;
    A3 = C * x;
    A4 = A * B;
    A5 = transpose(B) * transpose(A);

    %%% Problem 2
    %%% Initialize x using linspace and y as a regular vector.  
    %%% Set the variables to A6 and A7, and do the calculations for A8 to A10
    
    A6 = linspace(-4, 1, 73);
    A7 = cos(0:72);
    A8 = A6 .* A7;
    A9 = A6 ./ A7;
    A10 = A6.^3 - A7;

    
    %%% Problem 3
    
    % Part 1a
    % Initialize P0, K, and r.  Calculate P1 to P3.  Save P3 as A11
    P0 = 5;
    K = 10;
    r = 2;

    P1 = r * P0 * (1 - (P0/K));
    P2 = r * P1 * (1 - (P1/K));
    A11 = r * P2 * (1 - (P2/K));
    
    % Part 1b
    % Reinitialize P0, K, and r.  Calculate P1 to P4.  Save P4 as A12
    P0 = 10;
    K = 15;
    r = 3;
    
    P1 = r * P0 * (1 - (P0/K));
    P2 = r * P1 * (1 - (P1/K));
    P3 = r * P2 * (1 - (P2/K));
    A12 = r * P3 * (1 - (P3/K));
    
    % Part 2a
    % Reinitialize P0, K, and r.  Calculate P1 to P3.  Save P3 as A13
    
    P0 = 5;
    K = 12;
    r = 2;

    P1 = P0 * exp(r * (1 - (P0/K)));
    P2 = P1 * exp(r * (1 - (P1/K)));
    A13 = P2 * exp(r * (1 - (P2/K)));
    
    % Part 2b
    % Reinitialize P0, K, and r.  Calculate P1 to P4.  Save P4 as A14
    
    P0 = 2;
    K = 25;
    r = 2.5;

    P1 = P0 * exp(r * (1 - (P0/K)));
    P2 = P1 * exp(r * (1 - (P1/K)));
    P3 = P2 * exp(r * (1 - (P2/K)));
    A14 = P3 * exp(r * (1 - (P3/K)));
    
    % Part 2c
    % Don't think too hard about this one.  No calculations will be
    % necessary.  save your educated guess as A15
    A15 = 0;
    
