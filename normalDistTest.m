mu = 170.14*(1/2.5);
sigma = (1/2)*mu;

X = [];

for x = 0.01:0.01:0.99; % Hour in the day (0.2 = 1st hour)
    y = icdf('Normal',x,mu,sigma)
    X = [X, y];
end

clf;
x = [0.01:0.01:0.99]
hold on
   plot(X, x)

