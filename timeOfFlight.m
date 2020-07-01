function [deltat12] = timeOfFlight(a,e,theta1,theta2);
mu=398600;
p=a*(1-e^(2));
h=sqrt(mu*p);
T=2*pi*sqrt(a^(3)/mu); %periodo orbita
t=@(theta) ((1/((1-e^(2))^(3/2)))*(2*atan(sqrt((1-e)/(1+e))*tan(theta/2))-(e*sqrt(1-e^(2))*sin(theta))/(1+e*cos(theta))))*(h^(3)/(mu)^(2));
if theta2>theta1
    deltat12=t(theta2)-t(theta1);
else
    deltat12=t(theta2)-t(theta1)+T;
    
end

