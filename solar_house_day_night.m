function [Tt,Dt] =  solar_house_day_night(wt);
% Function outputs temperatures and time for running our model with solar
% insolation flipping between 170.14 and 0 W/m^2 for day and night 

    % Initialize T, D, Tt, Dt, d_0, d_end
    T = [];
    Tt = [];
    Dt = [];
    d_0 = 0;
    d_end = 0;
    Tf_0 = 293; % in K
    Tr_0 = 293; % in K
    D = [Tf_0, Tr_0]; 
    X = [];
    
    days = 10; % Number if days to run the simulation
    
    for i = 1:days*2;
        if mod(i,2) == 1; % For the first 10 hours of the day, set the incident solar radiation for daytime
            d_0 = d_end;
            I = 170.14;
            d_end = d_end + 36000; % Index end of day
            t_span = [d_0,d_end]; % Set the time span to run the simulation during day or night
            [T,D] = solar_house_ode45(I, t_span, D, wt); % Run the simulation 
        elseif mod(i,2) == 0; % For the last 14 hours of the day, set the incident solar radiation for nighttime
           d_0 = d_end;
           I = 0; %incident night solar radiation (w/m^2)
           d_end = d_end + 50400; % Index end of day
           t_span = [d_0,d_end]; % Set the time span to run the simulation during day or night
           [T,D] = solar_house_ode45(I, t_span, D, wt); % Run the simulation
        end
        
        Tt = [Tt; T]; % Collect data from the simulation and concatenate it into total matricies, Tt and Dt 
        Dt = [Dt; D];
        
    end
    Tt = Tt - 273; % Convert temperatures from K to C
    Dt = Dt - 273;
end