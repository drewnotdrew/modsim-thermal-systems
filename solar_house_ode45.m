function [T,D] = solar_house_ode45()

%parameters
C(1) = 300; %house int starting temperature (K)
k_e = 290; %external starting temperature (K)
c_d = .08; %diameter of coffee mug(m)
c_h = .10; %height of coffe mug(m)
c_t = .007; %thickness of coffe mug (m)
A = (pi*c_d)*c_h + pi*(c_d/2)^2; %surface area of coffee
V =(c_d/2)^2*pi*c_h; %volume of coffee

k = 1.5; %hermal conductivity of house walls (W/(m*K))
h = 4186; %specific heat of coffee (J/(kg*K) (same as water))
d = 1000; %density of coffee (kg/m^3)(same as water)

t_0 = 0;
t_end = 30*60; %in seconds

C_0 = 370; %coffee starting temperature (K)

[t, M] = ode45(@rate_func,[t_0, t_end],[C_0]);

    function res = rate_func (~,M) 
        dQdt = -(k*A/c_t)*(M(1)-k_e); %formula for conductive cooling (Energy)
        dTdt = dQdt/(V*d*h); %converting energy to change in temperature
        res = dTdt;
    end


end
