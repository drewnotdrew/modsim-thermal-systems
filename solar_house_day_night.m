function [Tt,Dt] =  solar_house_day_night(wt);
    % Initialize T, D, Tt, Dt, d_0, d_end
    T = [];
    Tt = [];
    Dt = [];
    d_0 = 0;
    d_end = 0;
    D = [293, 293];
    X = [];
    
    % Normal distribution setup
    mu = 170.14*(1/2.5);
    sigma = (1/2)*mu;
    
    days = 10; % Number if days to run the simulation
    
    for i = 1:days*2;
        
        if mod(i,2) == 1; % For the first 10 hours of the day, set the incident solar radiation for daytime
            d_0 = d_end;
            I = 170.14;
            d_end = d_end + 36000; % Index end of day
            t_span = [d_0,d_end]; % Set the time span to run the simulation during day or night
            [T,D] = solar_house_ode45(I, t_span, D, wt); % Run the simulation
%            for x = 0.1:0.1:0.9; % Hour in the day (0.2 = 1st hour)
%              d_0 = d_end;
%              y = icdf('Normal',x,mu,sigma);
%              X = [X, y];
%              I = y; %incident day solar radiation (w/m^2)
%              d_end = d_end + 36000/(9); % Index end of day
%              t_span = [d_0,d_end]; % Set the time span to run the simulation during day or night
%              [T,D] = solar_house_ode45(I, t_span, D, wt); % Run the simulation
%            end
           
           %x = 0.2; % Hour in the day (0.2 = 1st hour)
           %y = icdf('Normal',x,mu,sigma)
        elseif mod(i,2) == 0; % For the last 14 hours of the day, set the incident solar radiation for nighttime
           d_0 = d_end;
           I = 0; %incident night solar radiation (w/m^2)
           d_end = d_end + 50400; % Index end of day
           t_span = [d_0,d_end]; % Set the time span to run the simulation during day or night
           [T,D] = solar_house_ode45(I, t_span, D, wt); % Run the simulation
        end
        
        %t_span = [d_0,d_end]; % Set the time span to run the simulation during day or night
        %[T,D] = solar_house_ode45(I, t_span, D, wt); % Run the simulation
        
        Tt = [Tt; T]; % Collect data from the simulation and concatenate it into total matricies, Tt and Dt 
        Dt = [Dt; D];
        
    end
    Tt = Tt - 273; % Convert temperatures from K to C
    Dt = Dt - 273;
end