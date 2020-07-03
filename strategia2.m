
clear
clc

%% caratterizzazione orbita iniziale
% vect_ri: vettore posizione iniziale [km]
% vect_vi: vettore velocità iniziale [km/s]

vect_ri=[-5183.4184 6189.4459 4384.1737];
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

for w_ciclo=3.311:0.001:2*pi 
k=k+1;
[deltav1,w_0,theta3,deltat12,thetaorb2,delta_w1] = changePeriapsisArg(ai,ei,wi,0,w_ciclo);

[deltav21,deltav22,deltat,theta_f,ah,eh,wh]=changeShape (ai,ei,w_ciclo,a_f,e_f,w_ciclo,theta3(1),1);

[deltav3,w_daplottare,tetaout]=changeOrbitalPlane(a_f,e_f,ii,omegai,w_ciclo,i_f,omega_f);

[deltav4,w_3,theta3,deltat12,thetaorb2,delta_wf] = changePeriapsisArg(a_f,e_f,w_daplottare,0,w_f);

w_vectfinale(k)=w_daplottare;
deltavvect(k)=abs(deltav3)+abs(deltav1)+abs(deltav21)+abs(deltav22)+abs(deltav4);
delta_wfvect(k)=delta_wf;
w_3vect(k)=w_3;
end
w_iniziale=[0:0.001:2*pi];
w_differenza=w_vectfinale-w_f;
plot(w_differenza,'b')
hold on
plot(deltavvect,'r')
%plot(delta_wfvect,'g')
%plot(w_3vect,'y')
xlabel('')
ylabel('')

%% cambio forma partendo da apocentro (con w_f=w_i+pi)

k=0;

for w_ciclo=0.674:0.001:2*pi 
k=k+1;
[deltav1,w_0,theta3,deltat12,thetaorb2,delta_w1] = changePeriapsisArg(ai,ei,wi,0,w_ciclo);

[deltav21,deltav22,deltat,theta_f,ah,eh,wh]=changeShape (ai,ei,w_ciclo,a_f,e_f,w_ciclo+pi,theta3(1),1);

[deltav3,w_daplottare,tetaout]=changeOrbitalPlane(a_f,e_f,ii,omegai,w_ciclo+pi,i_f,omega_f);

[deltav4,w_3,theta3,deltat12,thetaorb2,delta_wf] = changePeriapsisArg(a_f,e_f,w_daplottare,0,w_f);

w_vectfinale(k)=w_daplottare;
deltavvect(k)=abs(deltav3)+abs(deltav1)+abs(deltav21)+abs(deltav22)+abs(deltav4);
delta_wfvect(k)=delta_wf;
w_3vect(k)=w_3;
end
w_iniziale=[0:0.001:2*pi];
w_differenza=w_vectfinale-w_f;
plot(w_differenza,'b')
hold on
plot(deltavvect,'r')
%plot(delta_wfvect,'g')
%plot(w_3vect,'y')
xlabel('')
ylabel('')
























