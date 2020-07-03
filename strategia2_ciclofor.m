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

%% plot delle due orbite 
plot_orbit(ai,ei,ii,omegai,wi,theta_i)
hold on
plot_orbit(a_f,e_f,i_f,omega_f,w_f,theta_f)

%% cambio forma partendo da pericentro (con w_f=w_i)

k=0;

for w_ciclo=wi-pi/2:0.001:wi+pi/2 
k=k+1;
[deltav1,w_1,theta3,deltat12,thetaorb2] = changePeriapsisArg(ai,ei,wi,0,w_ciclo);

[deltav21,deltav22,deltat,theta_f,ah,eh,wh]=changeShape (ai,ei,w_1,a_f,e_f,w_1,theta3(1),0);

[deltav3,w_changeplane,tetaout]=changeOrbitalPlane(a_f,e_f,ii,omegai,w_1,i_f,omega_f);

[deltav4,w_4,theta3,deltat12,thetaorb2] = changePeriapsisArg2(a_f,e_f,w_changeplane,0,w_f);


deltav_vect(k)=abs(deltav3)+abs(deltav1)+abs(deltav21)+abs(deltav22)+abs(deltav4);

end


plot(deltav_vect,'r')
 min(deltav_vect)



%% cambio forma partendo da apocentro (con w_f=w_i)

k=0;

for w_ciclo=wi-pi/2:0.001:wi+pi/2 
k=k+1;
[deltav1,w_1,theta3,deltat12,thetaorb2] = changePeriapsisArg(ai,ei,wi,0,w_ciclo);

[deltav21,deltav22,deltat,theta_f,ah,eh,wh]=changeShape (ai,ei,w_1,a_f,e_f,w_1,theta3(1),1);

[deltav3,w_changeplane,tetaout]=changeOrbitalPlane(a_f,e_f,ii,omegai,w_1,i_f,omega_f);

[deltav4,w_4,theta3,deltat12,thetaorb2] = changePeriapsisArg2(a_f,e_f,w_changeplane,0,w_f);


deltav_vect(k)=abs(deltav3)+abs(deltav1)+abs(deltav21)+abs(deltav22)+abs(deltav4);

end


plot(deltav_vect,'r')
 min(deltav_vect)



%% cambio forma partendo da pericentro (con w_f=w_i+pi)
k=0;
wciclo_vect=[wi-pi/2:0.01:wi+pi/2];


for w_ciclo=wi-pi/2:0.001:wi+pi/2 
k=k+1;
[deltav1,w_1,theta3,deltat12,thetaorb2] = changePeriapsisArg(ai,ei,wi,0,w_ciclo);

[deltav21,deltav22,deltat,theta_f,ah,eh,wh]=changeShape (ai,ei,w_1,a_f,e_f,w_1+pi,theta3(1),0);

[deltav3,w_changeplane,tetaout]=changeOrbitalPlane(a_f,e_f,ii,omegai,w_1+pi,i_f,omega_f);

[deltav4,w_4,theta3,deltat12,thetaorb2] = changePeriapsisArg2(a_f,e_f,w_changeplane,0,w_f);


deltav_vect(k)=abs(deltav3)+abs(deltav1)+abs(deltav21)+abs(deltav22)+abs(deltav4);

wchangeplane_vect(k)=w_changeplane;
end


plot(deltav_vect,'r')
 min(deltav_vect)




%% cambio forma partendo da apocentro (con w_f=w_i+pi)

k=0;
wciclo_vect=[wi-pi/2:0.01:wi+pi/2];

for w_ciclo=wi-pi/2:0.01:wi+pi/2 
k=k+1;
[deltav1,w_1,theta3,deltat12,thetaorb2] = changePeriapsisArg(ai,ei,wi,0,w_ciclo);

[deltav21,deltav22,deltat,theta_f,ah,eh,wh]=changeShape (ai,ei,w_1,a_f,e_f,w_1+pi,theta3(1),1);

[deltav3,w_changeplane,teta_changeplane]=changeOrbitalPlane(a_f,e_f,ii,omegai,w_1+pi,i_f,omega_f);

[deltav4,w_4,theta3,deltat12,thetaorb2] = changePeriapsisArg2(a_f,e_f,w_changeplane,0,w_f);


deltav_vect(k)=abs(deltav3)+abs(deltav1)+abs(deltav21)+abs(deltav22)+abs(deltav4);

wchangeplane_vect(k)=w_changeplane;
tetachangeplane_vect(k)=teta_changeplane;
end


plot(deltav_vect,'r')
 min(deltav_vect)












