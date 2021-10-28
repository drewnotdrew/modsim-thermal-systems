function [T,D] = solar_house_ode45()

%parameters
k(1) = 300; %house int starting temperature (K)
k_e = 290; %external temperature (K)
w = 10; %sidelength of house (m)
wt = .1; %thickness of walls (m)

SA = w^2*5; %surface area of house (m)



t_0 = 0;
t_end = 30*60; %in seconds

k_0 = 370; %interior starting temperature (K)

[t, M] = ode45(@rate_func,[t_0, t_end],[C_0]);

    function res = rate_func (~,M) 
        dQdt = -(k*SA/c_t)*(M(1)-k_e); %formula for conductive cooling (Energy)
        dTdt = dQdt/(V*d*h); %converting energy to change in temperature
        res = dTdt;
    end


end
