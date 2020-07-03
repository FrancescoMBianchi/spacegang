function [deltav2,w_3,theta3,deltat12,thetaorb2,deltaomega] = changePeriapsisArg2(ai,ei,w_2,theta2,w_f);

%if abs(omegaf-omega2)>pi/2 && abs(omegaf-omega2)<3/2*pi    
    %omega3=omegaf+pi;
%else
if w_f>2*pi
    w_f=w_f-2*pi;
end
w_3=w_f;
%end
deltaomega=w_3-w_2;

p=ai*(1-ei^2);
mu=398600;

%calcolo anomalie vere dei punti di intersezione
thetaorb2(1)=deltaomega/2; %il vettore thetaorb2 contiene le anomalie dei punti di intersezione del orbita iniziale
thetaorb2(2)=pi+deltaomega/2;
theta3(1)=2*pi-deltaomega/2;
theta3(2)=pi-deltaomega/2;

if deltaomega>pi
    deltaomega=2*pi-deltaomega;
end
%calcolo deltav

deltav2=2*sqrt(mu/p)*ei*sin(deltaomega/2);

%calcolo tempi associati all'intersezione scelta
deltat12(1)=timeOfFlight(ai,ei,theta2,thetaorb2(1));
deltat12(2)=timeOfFlight(ai,ei,theta2,thetaorb2(2));

end

