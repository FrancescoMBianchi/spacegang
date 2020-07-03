%% orbita 1
% vector_r0: vettore posizione iniziale [km]
% vector_v0: vettore velocità iniziale [km/s]

vector_r0=[-5183.4184 6189.4459 4384.1737];
vector_v0=[-5.3130 -4.3350 0.2136];

%parametri
a=10037.6540;
e=0.08866;
i=0.4979;
omega=0.7417;
theta=5.9583;
vettore eccentricità=[  -0.0259    0.0750    0.0396];
vettore_h=[ 2.0327   -2.2186    5.5355] *10^4;
vettore_linea_nodi=[0.7373    0.6756         0];
w= 1.2068;


%% orbita 2
% vector_e: vettore eccentricità
% e: eccentricità
% a: semiasse maggiore [km]
% omega: ascensione retta del nodo ascendente [rad]
% i: inclinazione [rad]
% w: anomalia pericentro [rad]
% teta: anomalia reale [rad]

a=12610.0;
e=0.2656;
i=1.0430;
omega=1.8790;
w=2.4080;
teta=2.3880;
