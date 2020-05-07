function [vect_r,vect_v] = rv_parametri(a,e,i,OMEGA,omega,theta)

mu=398600;
p=a*(1-e^2);

%sistema perifocale
rpf=[p*cos(theta)/(1+e*cos(theta));p*sin(theta)/(1+e*cos(theta));0];
vpf=sqrt(mu/p)*[-sin(theta);e+cos(theta);0];

%% passaggio a sistema equatoriale celeste
%matrici di rotazione da I,J,K a pf 
ROMEGA=[cos(OMEGA),sin(OMEGA),0; -sin(OMEGA),cos(OMEGA),0; 0,0,1];
Ri=[1,0,0; 0,cos(i),sin(i); 0,-sin(i),cos(i)];
Romega=[cos(omega),sin(omega),0; -sin(omega),cos(omega),0; 0,0,1];
Rtot=Romega*Ri*ROMEGA;

%rotazione di rpf e vpf in I,J,K
vect_r=Rtot'*rpf
vect_v=Rtot'*vpf

end

