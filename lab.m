clear
clc
%% caratterizzazione orbita iniziale
% vect_ri: vettore posizione iniziale [km]
% vect_vi: vettore velocit� iniziale [km/s]

vect_ri=[-5183.4184 6189.4459 4384.1737];
vect_vi=[-5.3130 -4.3350 0.2136];

[vect_ei,ei,ai,omegai,ii,wi,thetai,vect_hi,vect_ni] = parametri_rv(vect_ri,vect_vi)
%% caratterizzazione orbita finale
% vect_e: vettore eccentricit�
% e: eccentricit�
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

[vect_rf,vect_vf] = rv_parametri(a_f,e_f,i_f,omega_f,w_f,theta_f)
%% plot delle due orbite
%figure 
%plot_orbit(ai,ei,ii,omegai,wi,thetai)
%hold on
%plot_orbit(a_f,e_f,i_f,omega_f,w_f,theta_f)
%% cambio S.R.
%deltav1: deltav necessario per la manovra di cambio del S.R. [km/s^2]
%w2: anomalia del pericentro della nuova orbita [rad]
%deltat12: tempo che interccorre tra punto iniziale e punto di manovra per
%il cambio S.R. [s]
[deltav1,w2,theta2] = changeOrbitalPlane(ai,ei,ii,omegai,wi,i_f,omega_f)
deltat12=timeOfFlight(ai,ei,thetai,theta2);

%% cambio anomalia pericentro
%deltav2: delta v necessario per la manovra di cambio anomalia del
%pericentro
%w3: anomalia del pericentro dell'orbita dopo la manovra
%vect_theta3: � un vettore riga che contiene le due anomalie (sfasate di pi) in cui � possibile
%fare la manovra;
%deltat23: vettore riga che contiene l'intervallo di tempo che intercorre
%tra punto di manovra di cambio S.R (2) a quello di cambio anomalia (3);
%vettore riga perch� come detto prima ci sono due nodi in cui poter fare la
%manovra
[deltav2,w3,vect_theta3,deltat23] = changePeriapsisArg(ai,ei,w2,theta2,w_f);

%% cambio forma partendo da pericentro --> manovra biellittica (due impulsi)
%deltav3_p: delta v del primo impulso, il pedice _p nella notazione indica
%che il primo impukso � fatto al pericentro
%deltav4_p: delta v secondo impulso
%deltat34_p: tempo di manovra che intercorre tra il punto 3 (punto di
%cambio anomalia del pericentro) e il punto quattro (punto di arrivo
%manovra biellittica); � un vettore di due componenti perch� non abbiamo
%ancora deciso in quale dei due punti sfasati di pi fare la manovra di
%cambio piano
%theta4_p: angolo in cui termina la manovra biellittica; sar� apogeoo
%perigeo
%ah_p: semiasse maggiore orbita di trasferimento
%eh_p: eccentricit� orbita di trasferimento
%wh_p: anomalia pericentro orbita di trasferimento; questi tre dati
%mi serviranno per plottare l'orbita di trasferimento

[deltav3_p,deltav4_p,deltat34_p,theta4_p,ah_p,eh_p,wh_p] = changeShape (ai,ei,w3,a_f,e_f,w_f,vect_theta3,0);
deltav_p=[deltav1,deltav2,deltav3_p,deltav4_p]; %vettore contenente i deltav di ogni manovra; in ordine cambio piano, cambio anomalia pericentro, cambio forma (primo e secondo impulso)
deltat24_p=deltat23+deltat34_p; %tempo che intercorre dal punto 2 al punto 4; sar� sempre un vettore di due componenti perch� non abbiamo ancora scelto il punto 3 in cui fare la manovra di cambio anomalia pericentro
deltat4f_p=timeOfFlight(a_f,e_f,theta4_p,theta_f); %tempo che intercorre dal punto 4 al punto finale
%scegliamo adesso in quale dei due punti fare la manovra di cambio di
%anomalia del pericentro; il discriminante sar� il tempo di manovra che
%intercorre tra i punti 2 e 4 in quanto il deltav non � influenzato dalla
%scelta del punto 3
if deltat24_p(1)<deltat24_p(2)
    theta3_p=vect_theta3(1); %scegliamo come anomalia vera il primo elemento del vettore contenente i due punti di manovra
    deltat_p=[deltat12,deltat23(1),deltat34_p(1),delta4tf_p]; %vettore che conitene i tempi di manovra
else
    theta3_p=vect_theta3(2); %scegliamo come anomalia vera il secondo elemento del vettore contenente i due punti di manovra
    deltat_p=[deltat12,deltat23(2),deltat34_p(2),deltat4f_p];
end
 
%% cambio forma partendo da apocentro --> manovra biellittica (due impulsi)
%gli elementi e la procedura sono gli stessi del punto precedente; il
%pedice _a sta ad indicare che il primo impulso del cambio forma � fatto
%nell'apogeo
[deltav3_a,deltav4_a,deltat34_a,theta4_a,ah_a,eh_a,wh_a] = changeShape (ai,ei,w3,a_f,e_f,w_f,vect_theta3,1);
deltav_a=[deltav1,deltav2,deltav3_a,deltav4_a];
deltat24_a=deltat23+deltat34_a;
deltat4f_a=timeOfFlight(a_f,e_f,theta4_a,theta_f);
if deltat24_a(2)<deltat24_a(2)
    theta3_a=vect_theta3(1);
    deltat_a=[deltat12,deltat23(1),deltat34_a(1),delta4f_a];
else
    theta3_a=vect_theta3(1);
    deltat_a=[deltat12,deltat23(2),deltat34_a(2),deltat4f_a];
end

deltavtot_p=sum(abs(deltav_p)) % deltav totale con cambio di forma che inizia nel perigeo
deltavtot_a=sum(abs(deltav_a)) % deltav totale con cambio di forma che inizia nell'apogeo
deltattot_p=sum(deltat_p) %deltat totale con cambio di forma che inizia nel perigeo
deltattot_a=sum(deltat_a) %deltat totale con cambio di forma che inizia nell'apogeo

%% plot manovre con cambio di forma al pericentro
figure (2)
plot_orbit(ai,ei,ii,omegai,wi,thetai)
hold on
%plot_orbit(a_f,e_f,i_f,omega_f,w_f,theta_f)
plot_orbit(ai,ei,i_f,omega_f,w2,theta2,theta2,theta3_p)
plot_orbit(ai,ei,i_f,omega_f,w3,theta3_p,theta3_p,0)
%plot_orbit(ah_p,eh_p,i_f,omega_f,w3,0,0,theta4_p)
%plot_orbit(a_f,e_f,i_f,omega_f,w_f,theta4_p,theta4_p,theta_f)


%% plot manovra con cambio di forma all'apocentro
%figure (3)
%plot_orbit(ai,ei,ii,omegai,wi,thetai)
%hold on
%plot_orbit(a_f,e_f,i_f,omega_f,w_f,theta_f)
%plot_orbit(ai,ei,i_f,omega_f,w2,theta2,theta2,theta3_a)
%plot_orbit(ai,ei,i_f,omega_f,w3,theta3_a,theta3_a,pi)
%plot_orbit(ah_a,eh_a,i_f,omega_f,w3,pi,pi,0)
%plot_orbit(a_f,e_f,i_f,omega_f,w_f,theta4_a,theta4_a,theta_f)

