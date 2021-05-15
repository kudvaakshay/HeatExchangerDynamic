%Exampleone double pipe HE
l = 80; %m pipe length
r1 = 0.1; %m inner radius
r2 = 0.15; %m outer pipe radius
n = 10; % number of nodes used

%Fluid 1 data
m1 = 20; %kg/s mass flowrate
Cp1 = 4180; %J/kg K Cp
rho1 = 1000; %kg/m3

%Fluid 2 data
m2 = 10; %kg/s
Cp2 = 4180; %J/kg K Cp
rho2 = 1000; %kg/m3

Ac1 = pi * (r1 ^ 2); % Crosssectional area of inner tube
Ac2 = pi * (r2 ^ 2 - r1 ^ 2); % Cross sectional area of outer tube

T1in = 298; % K Inlet temp of fluid 1
T2in = 363; % K Inlet temperature of fluid 2

T0 = 298; %K initial temperature of fluid through pipe
U = 400; %W/m2 - Overall HT coeff

dx = l/n; % Dividing length into nodes
time_final=1000; %seconds
dt=10; %seconds

x=linspace(0,l,n); %Array containing space between node 2 to n-1
T1=ones(1,n)*T0; %Initial conditions for all the nodes in geometry 1
T2=ones(1,n)*T0; %Initial conditions for all the nodes in geometry 2

dTdt1 = ones(1,n-2); %Rate of change in temerature of liquid 1
dTdt2 = ones(1,n-2); %Rate of change in temperature of liquid 2
t=0:dt:time_final; %array for time

for j=1:length(t)
    clf
    %Energy balance for fluid 1
    dTdt1(1:n-1)=(m1*Cp1*(T1(2:n)-T1(1:n-1))+U*2*pi*r1*dx*(T2(1:n-1)-T1(1:n-1)))/(rho1*Cp1*Ac1*dx);
    dTdt1(n)=(m1*Cp1*(T1in-T1(n))+U*2*pi*r1*dx*(T2(n)-T1(n)))/(rho1*Cp1*Ac1*dx);
    %Energy balance for fluid 2
    dTdt2(2:n)=(m2*Cp2*(T2(1:n-1)-T2(2:n))-U*2*pi*r1*dx*(T2(2:n)-T1(2:n)))/(rho2*Cp2*Ac2*dx);
    dTdt2(1)=(m2*Cp2*(T2in-T2(1))-U*2*pi*r1*dx*(T2(1)-T1(1)))/(rho2*Cp2*Ac2*dx);
    T1 = T1 + dTdt1 * dt; 
    T2 = T2 + dTdt2 * dt;
   
    plot(x,T1,'-b','LineWidth',5)
    axis([0,80,290,400])
    xlabel('Distance (m)');
    ylabel('Temperature (K)');
    hold on
    plot(x,T2,'-r','LineWidth',5)
    pause(0.1)
end

