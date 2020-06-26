function [deltav2,omega3,theta3] = changePeriapsisArg(ai,ei,omega2,theta2,omegaf);

if abs(omegaf-omega2)>pi/2     
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
thetaorb3(1)=2*pi-deltaomega/2;
thetaorb3(2)=pi-deltaomega/2;

%calcolo delle velocità in corrispondenza dei punti di intersezione (nei sistemi di riferimento perifocali)
vorb2(1,:)=sqrt(mu/p)*[-sin(thetaorb2(1));ei+cos(thetaorb2(1))];
vorb2(2,:)=sqrt(mu/p)*[-sin(thetaorb2(2));ei+cos(thetaorb2(2))];
vorb3(1,:)=sqrt(mu/p)*[-sin(thetaorb3(1));ei+cos(thetaorb3(1))];
vorb3(2,:)=sqrt(mu/p)*[-sin(thetaorb3(2));ei+cos(thetaorb3(2))];

%calcolo dei deltav (due casi) 
%riporto le velocità dell'orbita 2 nel sistema di riferimento perifocale 3
R=[cos(deltaomega),sin(deltaomega);-sin(deltaomega),cos(deltaomega)]';

vorb2(1,:)=R*(vorb2(1,:))';
vorb2(2,:)=R*(vorb2(2,:))';
deltav2(1)=norm(vorb2(1,:)-vorb3(1,:));
deltav2(2)=norm(vorb2(2,:)-vorb3(2,:));

%calcolo anomalia vera dell'orbita 3 (due casi)  
theta3(1)=thetaorb3(1);
theta3(2)=thetaorb3(2);

end

