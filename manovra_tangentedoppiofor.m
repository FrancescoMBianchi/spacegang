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


%% ciclo su theta


mu=398600;


j=0;
for w_ciclo=0:0.01:2*pi
j=j+1;
%parte il ciclo per trovare il deltav per portarsi in w_ciclo+pi   
deltav_vect=zeros(1,6.28*100);  
e2_vect=zeros(1,6.28*100);
w2_vect=zeros(1,6.28*100);
k=0;
for theta=0:0.01:6.28

[vect_r,vect_vi] = rv_parametri(ai,ei,ii,omegai,wi,theta);    
    r=norm(vect_r);
    
    versore_v=vect_vi/norm(vect_vi);
    
    k=k+1;

deltav=sqrt(2*mu*(1/r-1/(2*a_f)))-sqrt(2*mu*(1/r-1/(2*ai)));
deltav_vect(k)=deltav;


vect_vf=vect_vi+deltav.*versore_v;

[vector_e2,e_2,a_2,omega_2,ii,w_2,theta_2,vector_h2,vector_n2] = parametri_rv(vect_r',vect_vf');

w2_vect(k)=abs(w_2-w_ciclo);
%plot_orbit(a_2,e_2,ii,omega_2,w_2,theta_2)


e2_vect(k)=e_2;

end

[minimo,posto]=min(w2_vect);


%DA CONTROLLARE POI SE CONVIENE 0 o 1 IN BASE AL TEMPO (COMMENTO PER CHANGE SHAPE)
[deltav2,deltav3,dt_t,theta_f,ah,eh] = changeShape (a_f,e2_vect(posto),w_ciclo,a_f,e_f,w_ciclo,0,0);

[deltav4,w_changeplane,teta_f] = changeOrbitalPlane(a_f,e_f,ii,omegai,w_ciclo,i_f,omega_f);

[deltav5,w_periapsisf,theta3,deltat12,thetaorb2,deltaomega] = changePeriapsisArg2(a_f,e_f,w_changeplane,0,w_f);
deltav4_vect(j)=deltav4;
deltav5_vect(j)=deltav5;
deltav23_vect(j)=abs(deltav2)+abs(deltav3);
deltav1_vect(j)=deltav_vect(posto);
deltavtot_vect(j)=abs(deltav_vect(posto))+abs(deltav2)+abs(deltav3)+abs(deltav4)+abs(deltav5);
end

%%
w_ciclo_vect=[0:0.01:2*pi];
[minimodeltavtot,jmin]= min(deltavtot_vect)
plot(w_ciclo_vect, deltavtot_vect,'r')
hold on
plot(w_ciclo_vect, deltav4_vect,'g')
plot(w_ciclo_vect, deltav5_vect,'b')

plot(w_ciclo_vect, abs(deltav23_vect),'g')

 plot(w_ciclo_vect, abs(deltav1_vect),'r')













