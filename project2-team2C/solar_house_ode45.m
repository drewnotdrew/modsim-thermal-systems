function [T,D] = solar_house_ode45(I, t_span, D, wt) %T = temperature D = day

% Model Parameters
Ta = 263.56; % external temperature (K)
w = 10; % sidelength of house (m)
wf = .05715; % thickness of floor (m)

A = w^2; % area of floor (m)
S = 68; % Angle between incident sun rays and the floor
PA = A*sind(S); % projected area (m^2)**
SA = w^2*5; % surface area of house (m^2)
V = w^3; % volume of house(m^3)
V_f = wf*w*w; % volume of floor

e = 0.473; % efficiency of floor (emmisivity of oak)
h_a = 0.026; % thermal conductivity of air
h_w = 0.05; % thermal conductivity of walls (insulation)
h = 15; % Convection heat coefficient of air
s_f = 1850; % specific heat of floor(j/kg C)
s_a = 1005; % specific heat of air (j/kg C)
d = 1.293;% density of air (kg/m^3)
d_f = 745; % density of floor (kg/m^3)
m_a = V*d; % mass of air k(g)
m_f = d_f*V_f; % mass of floor (kg)

Ds = size(D, 1);

Tf_0 = D(Ds, 1);
Tr_0 = D(Ds, 2);

 Uf = temperatureToEnergy(Tf_0, m_f, s_f); % Converting temperature to energy
 Ur = temperatureToEnergy(Tr_0, m_a, s_a);% Converting temperature to energy

 init = [Uf, Ur]; % initial values

[T,D] = ode45(@rate_func,t_span, init);
    function res = rate_func (~,D);
        Tf = D(1)/(V_f*d_f*s_f); % change in energy to change in temperature 
        Tr = D(2)/(V*d*s_a); % change in energy to change in temperature
        
        Tf = energyToTemperature(D(1), m_f, s_f);
        Tr = energyToTemperature(D(2), m_a, s_a);
        
        % For model verification
        energyIntoFloor = e*I*PA;
        energyOutofFloor = h*A*(Tf - Tr);
        
        energyIntoRoom = h*A*(Tf - Tr);
        EnergyOutofRoom = ((h_w*SA)/wt)*(Tr - Ta);
        
        dUfdt = e*I*PA - h*A*(Tf - Tr); %Energy into the floor (radiation) minus energy out of the floor (conduction)
        dUrdt = h*A*(Tf - Tr) - ((h_w*SA)/wt)*(Tr - Ta);%Energy into the rom (conduction) minus energy out of the room (convection)
        
        res = [dUfdt; dUrdt];
    end

D(:,1) = energyToTemperature(D(:,1), m_f, s_f); %Converting energy to temperature
D(:,2) = energyToTemperature(D(:,2), m_a, s_a); %Converting energy to temperature

end
