function [Tt,Dt] =  solar_house_day_night();
    T = [];
    D = [];
    Tt = [];
    Dt = [];
    d_0 = 0;
    d_end = 0;
    D = [293, 293];
    for i = 1:60
        d_0 = d_end;
        if mod(i,2) == 1;
           I = 170.14; %incident solar radiation (w/m^2)
           d_end = d_end + 36000;
        elseif mod(i,2) == 0;
           I = 0; %incident solar radiation (w/m^2)
           d_end = d_end + 50400;
        end
        t_span = [d_0,d_end];
        %t_span
        %d_end = 60*60*24*(5/12); %in seconds
        [T,D] = solar_house_ode45(I, t_span, D);
        Tt = [Tt; T];
        Dt = [Dt; D];
    end
    Tt = Tt - 273;
    Dt = Dt - 273;
end