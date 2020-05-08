%% MANOVRA ORBITALE DI UNO SPACECRAFT DA UN ORBITA INIZIALE AD UN ORBITA FINALE
clc
clear
% Dell'orbita iniziale (1) conosciamo vettore posizione e velocità nel
% sistema equatoriale celeste; dobbiamo ricavare i parametri orbitali per
% caratterizzare l'orbita.
% Dell'orbita finale (2) conosciamo i parametri orbitali; vogliamo ricavare
% i vettori posizione e velocità nel sistema equatoriale celeste.

%% nomenclatura
% vector_e: vettore eccentricità
% e: eccentricità
% a: semiasse maggiore [km]
% omega: ascensione retta del nodo ascendente [rad]
% i: inclinazione [rad]
% w: anomalia pericentro [rad]
% teta: anomalia reale [rad]
% vector_h: vettore qt. moto [km^2/s]
% vector_n: versore linea dei nodi
% vector_r0: vettore posizione in teta [km]
% vector_v0: vettore velocità in teta [km/s]
% mu: cost. gravitazione specifica di un oggetto celeste [km^3/s^2]
% l'indice 1 o 2 indica l'appartenenza rispettamente all'orbita 1 e 2

%% orbita 1
vector_r1=[-5183.4184 6189.4459 4384.1737];     
vector_v1=[-5.3130 -4.3350 0.2136];            

%% orbita 2

a_2=12610,0;         
e_2=0,2656;          
i_2=1,0430;          
omega_2=1,8790;      
w_2=2,4080;
teta_2=2,3880;

%% altri dati
% Rt: raggio terrestre [km]
% mu: costante gravitazione specifica di un oggetto celeste [km^3/s^2]
Rt=6378;
mu=398600;
vector_teta=linspace(0,2*pi,360);

%% caratterizzazione orbita 1
[vector_e1,e_1,a_1,omega_1,i_1,w_1,teta_1,vector_h1,vector_n1,R1] = obital_paraparameters(vector_r1,vector_v1);
r_1=a_1*(1-e_1^2)./(1+e_1.*cos(vector_teta));
x_1=r_1.*cos(vector_teta);
y_1=r_1.*sin(vector_teta);

%% caratterizzazione orbita 2
[vector_r2, vector_v2,R2,vector_h2,vector_n2,vector_e2] = rotazione(e_2,a_2,omega_2,i_2,w_2,teta_2);
r_2=a_2*(1-e_2^2)./(1+e_2.*cos(vector_teta));
x_2=r_2.*cos(vector_teta);
y_2=r_2.*sin(vector_teta);

%% plottiamo le orbite nel SR celeste
X_1=zeros(1,360);
Y_1=zeros(1,360);
Z_1=zeros(1,360);
X_2=zeros(1,360);
Y_2=zeros(1,360);
Z_2=zeros(1,360);
for j=1:360
    vector_X1=R1'*[x_1(j); y_1(j); 0]; % coordinate di ciascun punto dell'orbita 1 nel SR celeste
    X_1(j)=vector_X1(1);
    Y_1(j)=vector_X1(2);
    Z_1(j)=vector_X1(3);
    vector_X2=R2'*[x_2(j); y_2(j); 0]; % coordinate di ciascuno punto dell'orbita 2 nel SR celeste
    X_2(j)=vector_X2(1);
    Y_2(j)=vector_X2(2);
    Z_2(j)=vector_X2(3);
end
figure (1)
hold on
plot3(X_1,Y_1,Z_1);
plot3(X_2,Y_2,Z_2);
[x,y,z] = sphere(50); %crea tre matrici N+1 * N+1
s = surf(Rt*x,Rt*y,Rt*z); % crea sfera con R=Rt
axis equal





