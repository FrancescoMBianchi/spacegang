function [vector_r0, vector_v0,R,vector_h,vector_n,vector_e] = rotazione(e,a,omega,i,w,teta)
% dati i parametri orbitali calcolo posizione iniziale e velocità nel
% sistema di riferimento celeste.
% e: eccentricità
% a: semiasse maggiore [km]
% omega: ascensione retta del nodo ascendente [rad]
% i: inclinazione [rad]
% w: anomalia pericentro [rad]
% teta: anomalia reale [rad]
% vector_r0: vettore posizione in teta SR celeste [km]
% vector_v0: vettore velocità in teta SR celeste [km/s]
% mu: cost. gravitazione specifica di un oggetto celeste [km^3/s^2]
% R_teta: raggio relativo all'angolo teta nel piano perifocale [km]
% R: matrice di rotazione da SR perifocale a SR celeste
% vector_h: vettore qt. moto [km^2/s]
% vector_n: versore linea dei nodi
% vector_e: vettore eccentricità
% tutti i vettori sono vettori riga

mu=398600;
R_teta=a*(1-e^2)/(1+e*cos(teta));
x_teta=R_teta*cos(teta); % componente della posizione nel piano perifocale diretta come il perigeo
y_teta=R_teta*sin(teta); % componente della posizione nel piano perifocale diretta come il semilato retto
u=-(mu/(a*(1-e^2)))^0.5*sin(teta) % componente della velocità nel piano perifocale diretta come il perigeo
v=(mu/(a*(1-e^2)))^0.5*cos(teta)  % componente della velocità nel piano perifocale diretta come il semilato retto
% def matrice di rotazione
R=[cos(w) sin(w) 0; -sin(w) cos(w) 0; 0 0 1]*[1 0 0; 0 cos(i) sin(i); 0 -sin(i) cos(i)]*[cos(omega) sin(omega) 0; -sin(omega) cos(omega) 0; 0 0 1];
vector_r0=(R'*[x_teta; y_teta; 0])';
vector_v0=(R'*[u; v; 0])';
% calcolo vettore qtà moto, linea nodi, eccentricità
vector_h=cross(vector_r0,vector_v0);
vector_n=cross([0 0 1],vector_h)/norm(cross([0 0 1],vector_h));
vector_e=cross(vector_v0,vector_h)/mu - vector_r0/norm(vector_r0);
end




