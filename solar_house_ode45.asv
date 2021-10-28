function [T,D] = solar_house_ode45() %T = temperature D = day

%parameters
t(1) = 300; %house int starting temperature (K)
t_e = 290; %external temperature (K)
w = 10; %sidelength of house (m)
wt = .1; %thickness of walls (m)

SA = w^2*5; %surface area of house (m^2)
V = w^3; %volume of house(m^3)

h_a = 10; %heat transfer of air
h_w = 500;%heat transfer of walls

d_0 = 0;
d_end = 60; %in days

t_0 = 300; %house interior starting temperature (K)

[T,D] = ode45(@rate_func,[d_0, d_end],[t_0]);

    function res = rate_func (~,D) 
        c_d = k*SA/c_t*(D(1)-k_e); %calculating conduction
        c_vr = 1/(h_a*A) + 1/(h_c*A); %calculating convective resistance
        c_v = (1/c_vr) * (D(1)-k_e); %calculating conduction
        dTdt = c_u + c_v;
        C_c = dTdt/(V*d*h); %converting energy to change in temperature
        res = -C_c; %calculating net flow
    end


end
