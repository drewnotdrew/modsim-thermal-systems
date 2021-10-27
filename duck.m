function res = duck()
% Computes the depth at which a duck of a particular radius and density will float in water.

% Set the constants to be used by our error function (error_func)
r = 10;      % radius of the duck (cm)
rho = 0.3;   % density of the duck (g / cm^3)

% And just to get our units right ...
densityOfWater = 1.0;  % (g / cm^3)

% Now invoke fzero using a function handle, as described in Chapter 7 of
% the Robot Book, using r as the initial guess. The result is a zero of
% the error function (and, as it turns out, the correct one).
res = fzero(@error_func, r);

    % (Note that the function below is nested within the duck function,
    % so it can "see" the r and rho variables. This is different from
    % what Allen calls a "helper function" on p. 80 of the Robot Book.
    % Can you see why?)

    function res = error_func(d)
        % This function returns zero when d is the depth at which a sphere
        % of density rho will float.
        
        volumeOfDuck = (4/3) * pi * (r^3)
        massOfDuck = volumeOfDuck * rho
        
        volumeSubmerged = (pi/3)*(3*r*d^2-d^3)
        massOfWaterDisplaced = volumeSubmerged * densityOfWater

        res = massOfDuck - massOfWaterDisplaced;  % Replace 0 with the result of your error calculation.
    end
end

% testest
