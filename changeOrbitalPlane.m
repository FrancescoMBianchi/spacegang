function[deltav1,w_f,teta_f] = changeOrbitalPlane(ai,ei,ii,omegai,wi,i_f,omegaf)
delta_omega=omegaf-omegai; %var delta inizializzate
delta_i=i_f-ii;
mu=398600; %cost, andrebbe messa come var globale (!)
p=ai*(1-ei^2);

alpha=acos(cos(ii)*cos(i_f)+sin(ii)*sin(i_f)*cos(delta_omega)) %def angolo alpha

%Troviamo  u1 e u2, calcolando i seni e coseni in modo da definirlo con il
%segno corretto (infatti uso atan2)
sinu1=sin(delta_omega)*sin(i_f)/sin(alpha); %Queste formule sono uguali per ogni possibile caso di delta_i e delta_omega (così come alpha)
sinu2=sin(delta_omega)*sin(ii)/sin(alpha);

if delta_i>0 %formule del cos(u) dipendono da segno di delta_i
    cosu1=(-cos(i_f)+cos(alpha)*cos(ii))/(sin(alpha)*sin(ii));
    cosu2=(cos(ii)-cos(alpha)*cos(i_f))/(sin(alpha)*sin(i_f));  %formule formule formule
elseif delta_i<0
    cosu1=(cos(i_f)-cos(alpha)*cos(ii))/(sin(alpha)*sin(ii));
    cosu2=(-cos(ii)+cos(alpha)*cos(i_f))/(sin(alpha)*sin(i_f));
elseif delta_i==0 &&delta_omega>0 %solo cambio ascensione retta del nodo ascendente, deltai=0
    cosu2=(cos(ii)-cos(alpha)*cos(ii))/(sin(alpha)*sin(ii));
    cosu1=(-cos(ii)+cos(alpha)*cos(ii))/(sin(alpha)*sin(ii));
elseif delta_i==0 && delta_omega<0 %delta i=0 versione 2
    cosu1=(cos(ii)-cos(alpha)*cos(ii))/(sin(alpha)*sin(ii));
    cosu2=(-cos(ii)+cos(alpha)*cos(ii))/(sin(alpha)*sin(ii));
end

u1=atan2(sinu1,cosu1)  %funz atan2 distingue il segno del seno e del coseno oltre a farne il rapporto
u2=atan2(sinu2,cosu2)
%trovati u1 e u2 dobbiamo torvare teta finale e wf
if (delta_i*delta_omega)>0 || (delta_i==0 &&delta_omega>0) %se sono concordi o deltai=0 & deltaomega>0
    teta_f=u1-wi  %anomalia della manovra
    w_f=u2-teta_f  %arg periapsis nuovo
else %se sono discordi o deltai=0 & deltaomega<0
    teta_f=2*pi-u1-wi
    w_f=2*pi-u2-teta_f
end

vteta=((mu/p)^0.5) *(1+ei*cos(teta_f)); %vel trasversale
deltav1=2*vteta*sin(alpha/2) %calcolo deltav

end


