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

%% plot orbita iniziale 
plot_orbit(ai,ei,ii,omegai,wi,theta_i)
hold on
%% plot orbita finale
plot_orbit(a_f,e_f,i_f,omega_f,w_f,theta_f)


%% ciclo su theta


mu=398600;

k=0;

w_ottimo=3.2986;

%% manovra tangente 
deltav_vect=zeros(1,6.28*100);  
e1_vect=zeros(1,6.28*100);
w1_vect=zeros(1,6.28*100);
for theta=0:0.01:6.28

[vect_r,vect_vi] = rv_parametri(ai,ei,ii,omegai,wi,theta);    
    r=norm(vect_r);
    
    versore_v=vect_vi/norm(vect_vi);
    
    k=k+1;

deltav=sqrt(2*mu*(1/r-1/(2*a_f)))-sqrt(2*mu*(1/r-1/(2*ai)));
deltav_vect(k)=deltav;


vect_vf=vect_vi+deltav.*versore_v;

[vector_e1,e_1,a_1,omega_1,ii,w_1,theta_1,vector_h1,vector_n1] = parametri_rv(vect_r',vect_vf');

w1_vect(k)=abs(w_1-w_ottimo);

e1_vect(k)=e_1;

thetaorb1_vect(k)=theta;
theta1_vect(k)=theta_1;
end

[minimo,posto]=min(w1_vect);
thetaorb1=thetaorb1_vect(posto);
theta_1=theta1_vect(posto);
e_1=e1_vect(posto);
deltav1=deltav_vect(posto);
[deltati1] = timeOfFlight(ai,ei,theta_i,thetaorb1);

hold on

plot_orbit(a_f,e_1,ii,omegai,w_ottimo,theta_1,theta_1,2*pi)

%% manovra di change shape per cambiare eccentricità

[deltav2,deltav3,deltat12,theta_2,ah,eh] = changeShape (a_f,e_1,w_ottimo,a_f,e_f,w_ottimo,theta_1,0);

plot_orbit(ah,eh,ii,omegai,w_ottimo,0,0,pi)





%% manovra di cambio piano

[deltav4,w_3,theta_3] = changeOrbitalPlane(a_f,e_f,ii,omegai,w_ottimo,i_f,omega_f);
[deltat23] = timeOfFlight(a_f,e_f,theta_2,theta_3+2*pi);
%%
plot_orbit(a_f,e_f,ii,omegai,w_ottimo,pi,pi,theta_3+2*pi)



%% manovra di cambio anomalia di pericentro 
[deltav5,w_4,theta_4_vect,deltat34_vect,thetaorb4_vect] = changePeriapsisArg(a_f,e_f,w_3,theta_3,w_f);
%scelgo la pima intersezione perchè conviene per il tempo
thetaorb4=thetaorb4_vect(1);
deltat34=deltat34_vect(1);
theta_4=theta_4_vect(1);
%%
plot_orbit(a_f,e_f,i_f,omega_f,w_3,theta_3,theta_3,thetaorb4)
%%
plot_orbit(a_f,e_f,i_f,omega_f,w_4,0,0,theta_f)

%% calcolo deltav e deltat totali
deltavtot=abs(deltav1)+abs(deltav2)+abs(deltav3)+abs(deltav4)+abs(deltav5);
[deltat4f] = timeOfFlight(a_f,e_f,theta_4,theta_f);
deltattot=deltati1+deltat12+deltat23+deltat34+deltat4f;




