
function [deltav2,omega3,theta3,deltat12,thetaorb2] = changePeriapsisArg(ai,ei,omega2,theta2,omegaf);

if abs(omegaf-omega2)>pi/2 && abs(omegaf-omega2)<3/2*pi    
    omega3=omegaf+pi;
else
omega3=omegaf;
end
deltaomega=omega3-omega2;
p=ai*(1-ei^2);
mu=398600;

%calcolo anomalie vere dei punti di intersezione
thetaorb2(1)=deltaomega/2; %il vettore thetaorb2 contiene le anomalie dei punti di intersezione del orbita iniziale
thetaorb2(2)=pi+deltaomega/2;
theta3(1)=2*pi-deltaomega/2;
theta3(2)=pi-deltaomega/2;

%calcolo deltav
deltav2=2*sqrt(mu/p)*ei*sin(deltaomega/2);

%calcolo tempi associati all'intersezione scelta
deltat12(1)=timeOfFlight(ai,ei,theta2,thetaorb2(1));
deltat12(2)=timeOfFlight(ai,ei,theta2,thetaorb2(2));

end
%thetaorb2 vettore che serve per plot orbita tra theta 
