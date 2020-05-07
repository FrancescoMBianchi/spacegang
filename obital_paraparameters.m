function [vector_e,e,a,omega,i,w,teta,vector_h,vector_n] = obital_paraparameters(vector_r0,vector_v0)
% dati posizione e velocità iniziale calcolo parametri orbita
% vector_e: vettore eccentricità
% e: eccentricità
% a: semiasse maggiore
% omega: ascensione retta del nodo ascendente
% i: inclinazione
% w: anomalia pericentro
% teta: anomalia reale
% vector_h: vettore qt. moto
% vector_n: versore linea dei nodi
% vector_r0: vettore posizione iniziale
% vector_v0: vettore velocità iniziale
% mu: cost. gravitazione specifica di un oggetto celeste

mu=398600;

r0=norm(vector_r0);

v0=norm(vector_v0);

vector_h=cross(vector_r0,vector_v0);

i=acos(vector_h(3)/norm(vector_h));

vector_e=cross(vector_v0,vector_h)/mu - vector_r0/r0;

e=norm(vector_e);

a=0.5*mu*(mu/r0-(v0^2)*0.5)^(-1);

vector_n=cross([0 0 1],vector_h)/norm(cross([0 0 1],vector_h));

if vector_n(2)>0
    
    omega=acos(([1 0 0]*(vector_n)')/norm(vector_n));
    
else
    
    omega=2*pi-acos(([1 0 0]*(vector_n)')/norm(vector_n));
end
omega=omega*180/pi;

if vector_e(3)>0
    
    w=acos((vector_e*(vector_n)')/(e*norm(vector_n)));
    
else
    
    w=2*pi-acos((vector_e*(vector_n)')/(e*norm(vector_n)));
end
w=w*180/pi;
%prova
if vector_r0.*vector_v0>0
    
    teta=acos(vector_e*(vector_r0)'/(e*r0));
    
else
    
    teta=2*pi-acos(vector_e*(vector_r0)'/(e*r0));
end
teta=teta*180/pi;
end

