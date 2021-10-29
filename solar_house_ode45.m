function [T,D] = solar_house_ode45() %T = temperature D = day

%parameters
Tf(1) = 300; %floor starting temperature (K)
Tr(1) = 300; %house int starting temperature (K)
Ta = 290; %external temperature (K)
w = 10; %sidelength of house (m)
wt = .1; %thickness of walls (m)

A = w^2; %area of floor (m)
SA = w^2*5; %surface area of house (m^2)
V = w^3; %volume of house(m^3)
I = 100; %insulation of walls___

e = 1; %efficiency of floor___
h_a = 10; %heat transfer of air
h_w = 500; %heat transfer of walls__
h_f = 500; %heat coefficient of floor__
d = .0001;%density of air (kg/m^3)_____

d_0 = 0;
d_end = 60; %in days

Tr_0 = 300; %house interior starting temperature (K)
Tf_0 = 300; %floor starting temperature (K)

[T,D] = ode45(@rate_func,[d_0, d_end],Tf_0,Tr_0);

    function res = rate_func (~,D) 
        dUfdt = e*I*A - h_f*A*(Tf - Tr); %change in energy in the floor
        dUrdt = h_f*A*(Tf - Tr) - ((h_w*SA)/wt)*(Tr-Ta);%change in energy in the room
        D = dUrdt/(V*d*h_a); %converting energy to change in temperature
        res = D; 
    end


end
