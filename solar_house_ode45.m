function [T,D] = solar_house_ode45(); %T = temperature D = day

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
I = 170.14*0.001; %incident solar radiation (w/m^2)

e = .885; %efficiency of floor (emmisivity of oak)
h_a = 0.026; %thermal conductivity of air
h_w = 0.720; %thermal conductivity of walls (brick)
h_f = 0.170; %thermal conductivity of floor (wood)
s_f = 1.1134; %specific heat of floor(j/kg C)
s_a = 1; %specific heat of air (j/kg C)
d = 1.293;%density of air (kg/m^3)
m_a = V*d; %mass of air k(g)
m_f = 100; %mass of floor (kg)

d_0 = 0;
d_end = 1; %in days
t_span = [d_0,d_end];

Tf_0 = 293; %floor starting temperature (K)
Tr_0 = 293; %house interior starting temperature (K)

init = [Tf_0, Tr_0]; % initial values

% 
[T,D] = ode45(@rate_func,t_span, init);
        

    function res = rate_func (~,D);
        
%         Tr = D(1)/(V*d*h_a); %converting energy to change in temperature
%         Tf = D(2)/(V*d*h_f); %converting energy to change in temperature 
        
        Tf = D(1);
        Tr = D(2);
        %Uf = temperatureToEnergy(D(1), m_f, s_f);
        %Ur = temperatureToEnergy(D(2), m_a, s_a);
        %Test = e*I*PA;
        %dUfdt = 0;
        %dUrdt = 0;
       
         dUfdt = e*I*PA - h_f*A*(Tf - Tr); %change in energy in the floor
         dUrdt = h_f*A*(Tf - Tr) - ((h_w*SA)/wt)*(Tr - Ta);%change in energy in the room
         
%         dUfdt = e*I*PA - h_f*A*(Tf - Tr); %change in energy in the floor
%         dUrdt = h_f*A*(Tf - Tr) - ((h_w*SA)/wt)*(Tr - Ta);%change in energy in the room
        %Tr = energyToTemperature(dUrdt, m, h_a);
        %Tf = energyToTemperature(dUfdt, m, h_f);
        
        res = [dUfdt; dUrdt];
    end

Test2 = D(:,2);
%Tf = energyToTemperature(D(:,1), m_f, s_f)
%Tr = energyToTemperature(D(:,2), m_a, s_a)
%D = [Tf,Tr];
end
