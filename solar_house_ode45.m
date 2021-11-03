function [T,D] = solar_house_ode45() %T = temperature D = day

%parameters
% Tf(1) = 293; %floor starting temperature (K)
% Tr(1) = 293; %house int starting temperature (K)
Ta = 263.56; %external temperature (K)
w = 10; %sidelength of house (m)
wt = .30; %thickness of walls (m)
wf = .05715; %thickness of floor (m)

A = w^2; %area of floor (m)
PA = A*sind(68); %projected area (m^2)**
SA = w^2*5; %surface area of house (m^2)
V = w^3; %volume of house(m^3)
V_f = wf*w*w; %volume of floor
I = 170.14; %incident solar radiation (w/m^2)

e = 0.885; %efficiency of floor (emmisivity of oak)
h_a = 0.026; %thermal conductivity of air
h_w = 0.05; %thermal conductivity of walls (insulation)
h_f = 15; %thermal conductivity of floor (wood)********
s_f = 1850; %specific heat of floor(j/kg C)
s_a = 1005; %specific heat of air (j/kg C)
d = 1.293;%density of air (kg/m^3)
d_f = 745; %density of floor (kg/m^3)
m_a = V*d; %mass of air k(g)
m_f = d_f*V_f; %mass of floor (kg)

d_0 = 0;
d_end = 60*60*24*0.5; %in seconds
t_span = [d_0,d_end];

Tf_0 = 293; %floor starting temperature (K)
Tr_0 = 293; %house interior starting temperature (K)


 Uf = temperatureToEnergy(Tf_0, m_f, s_f);
 Ur = temperatureToEnergy(Tr_0, m_a, s_a);
init = [Uf, Ur]; % initial values

[T,D] = ode45(@rate_func,t_span, init);
    for 
    function res = rate_func (~,D)
                  Tf = D(2)/(V_f*d_f*s_f); %converting energy to change in temperature 
                  Tr = D(1)/(V*d*s_a); %converting energy to change in temperature
        
        Tf = energyToTemperature(D(1), m_f, s_f);
        Tr = energyToTemperature(D(2), m_a, s_a);
        %Uf = temperatureToEnergy(D(1), m_f, s_f);
        %Ur = temperatureToEnergy(D(2), m_a, s_a);
        Test = e*I*PA;% Delete
%         dUfdt = 0;
%         dUrdt = 0;
% 
%         tf_minus_tr = Tf-Tr
%         tr_minus_ta = Tr-Ta
%         room_heat_to_outside = -((h_w*SA)/wt)*(Tr - Ta)
       
        i = i + 1

        flowin = e*I*PA;
        flowout = h_f*A*(Tf - Tr);
        dUfdt = e*I*PA - h_f*A*(Tf - Tr); %change in energy in the floor
        dUrdt = h_f*A*(Tf - Tr) - ((h_w*SA)/wt)*(Tr - Ta);%change in energy in the room
        
%         dTfdt = energyToTemperature(dUrdt, m_a, h_a);
%         dTrdt = energyToTemperature(dUfdt, m_f, h_f);
        
        res = [dUfdt; dUrdt];
    end

D(:,1) = energyToTemperature(D(:,1), m_f, s_f);
D(:,2) = energyToTemperature(D(:,2), m_a, s_a);
D = D - 273;
%D = [Tf,Tr]; 
end
