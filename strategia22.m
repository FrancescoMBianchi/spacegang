% strategia 2 con cambio forma apocentro apocentro 

clear all
close all
clc

%% caratterizzazione orbita iniziale
% vect_ri: vettore posizione iniziale [km]
% vect_vi: vettore velocità iniziale [km/s]

vect_ri=[-5183.4184 6189.4459 4334.1737];
vect_vi=[-5.3130 -4.3350 0.2136];
[vect_ei,ei,ai,omegai,ii,wi,theta_i,vect_hi,vect_ni] = parametri_rv(vect_ri,vect_vi);

%% caratterizzazione orbita finale
% vect_e: vettore eccentricità
% e: eccentricità
% a: semiasse maggiore [km]
% omega: ascensione retta del nodo ascendente [rad]
% i: inclinazione [rad]
% w: anomalia pericentro [rad]
% teta: anomalia reale [rad]

a_f=12610.0;
e_f=0.2656;
i_f=1.0430;
omega_f=1.8790;
w_f=2.4080;
theta_f=2.3880;
[vect_rf,vect_vf] = rv_parametri(a_f,e_f,i_f,omega_f,w_f,theta_f);

%% plot orbita 1
plot_orbit(ai,ei,ii,omegai,wi,theta_i)
hold on
plot_orbit(a_f,e_f,i_f,omega_f,w_f,theta_f)
%% cambio anomalia pericentro
w_ottimo=0.6670;
[deltav1,w_1,vect_theta_1,vect_deltati1,vect_thetaorb1] = changePeriapsisArg(ai,ei,wi,theta_i,w_ottimo);

%scelgo primo punto di intersezione perchè minimizza il delta t
theta_1=vect_theta_1(1)-2*pi; 
thetaorb1=vect_thetaorb1(1)+2*pi;
deltati1=timeOfFlight(ai,ei,theta_i,thetaorb1);

%% cambio forma apocentro apocentro

w_2=w_1+pi;

[deltav2,deltav3,deltat12,theta_2,ah,eh] = changeShape (ai,ei,w_1,a_f,e_f,w_2,theta_1,1);

plot_orbit(ai,ei,ii,omegai,w_1,theta_1,theta_1,pi)
plot_orbit(ah,eh,ii,omegai,w_1+pi,0,0,pi)

%% cambio piano
[deltav4,w_3,theta_3] = changeOrbitalPlane(a_f,e_f,ii,omegai,w_2,i_f,omega_f);

theta_3=2*pi+theta_3;

deltat23=timeOfFlight(a_f,e_f,theta_2,theta_3);

plot_orbit(a_f,e_f,ii,omegai,w_2,pi,pi,theta_3)

%% secondo cambio anomalia di pericentro 
[deltav5,w_4,vect_theta_4,vect_deltat34,vect_thetaorb4] = changePeriapsisArg(a_f,e_f,w_3,theta_3,w_f);

thetaorb4=2*pi+vect_thetaorb4(1);
deltat34=vect_deltat34(1);
theta_4=vect_theta_4(1);
deltat4f=timeOfFlight(a_f,e_f,theta_4,theta_f);

plot_orbit(a_f,e_f,i_f,omega_f,w_3,theta_3,theta_3,thetaorb4)

deltattot=deltati1+deltat12+deltat23+deltat34+deltat4f;





