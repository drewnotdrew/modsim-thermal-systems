function [T,D] = solar_house_ode45() %T = temperature D = day

%parameters
Tf(1) = 293; %floor starting temperature (K)
Tr(1) = 293; %house int starting temperature (K)
Ta = 263.56; %external temperature (K)
w = 10; %sidelength of house (m)
wt = .15; %thickness of walls (m)

A = w^2; %area of floor (m)
PA = A*sind(68); %projected area (m^2)
SA = w^2*5; %surface area of house (m^2)
V = w^3; %volume of house(m^3)
I = 170.14; %incident solar radiation (w/m^2)

e = .885; %efficiency of floor (emmisivity of oak)
h_a = .1; %heat transfer of air
h_w = .8; %heat transfer of walls (brick)
h_f = .45; %heat coefficient of floor
d = 1.293;%density of air (kg/m^3)

d_0 = 0;
d_end = 5; %in days
t_span = [d_0,d_end];

Tr_0 = 300; %house interior starting temperature (K)
Tf_0 = 300; %floor starting temperature (K)

[T,D] = ode45(@rate_func,t_span,Tf_0,Tr_0);

    function res = rate_func (~,D) 
        
        dUfdt = e*I*PA - h_f*A*(Tf - Tr); %change in energy in the floor
        dUrdt = h_f*A*(Tf - Tr) - ((h_w*SA)/wt)*(Tr - Ta);%change in energy in the room
        T = dUrdt/(V*d*h_a); %converting energy to change in temperature
        res = -T; 
    end
D
T

end
