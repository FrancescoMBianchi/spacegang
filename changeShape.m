function [dv1,dv2,dt_t,theta_f,ah,eh,wh] = changeShape (a_i,e_i,w_i,a_f,e_f,w_f,theta_i,tipo_manovra)
% effettua un trasferimento ellittico bitangente per due orbite coplanari
%INPUT:
%a_i: semiasse maggiore orbita iniziale
%e_i: eccentricità orbita iniziale
%w_i: anomalia pericentro orbita iniziale
%theta_i: angolo di inzio manovra
%a_f: semiasse maggiore orbita finale
%e_f: eccentricità orbita finale
%w_f: anomalia pericentro finale
%tipo_manovra: valore numerico che indica che tipo di manovra fare; se 0
%parto da pericentro dell'orbita iniziale, se 1 parto da apocentro
%dell'orbita iniziale
%OUTPUT
%dv1: delta v prima manovra [km/s]
%dv2: delta v seconda manovra  [km/s]
%dt_t: delta t manovra
%% calcolo raggio pericentro e apocentro delle due orbite
ra_i=a_i*(1+e_i);
rp_i=a_i*(1-e_i);
ra_f=a_f*(1+e_f);
rp_f=a_f*(1-e_f);
mu=398600; %[km^3/s^2]
%% calcolo delta v
if tipo_manovra==0
    if abs(w_i-w_f)<0.1
        %prima manovra pericentro orbita iniziale, seconda manovra
        %apocentro orbita finale
        ah=0.5*(rp_i+ra_f); %semiasse maggiore orbita di manovra
        dv1=sqrt(2*mu*(1/rp_i-1/(2*ah)))-sqrt(2*mu*(1/rp_i-1/(2*a_i)));
        dv2=sqrt(2*mu*(1/ra_f-1/(2*a_f)))-sqrt(2*mu*(1/ra_f-1/(2*ah)));
        dtm=pi*sqrt((ah^3)/mu); %dt di manovra
        dt=timeOfFlight(a_i,e_i,theta_i,0); %dt per arrivare da anomalia data in ingresso e anomalia pericentro(0), punto di manovra
        theta_f=pi;
        eh=(ra_f-rp_i)/(ra_f+rp_i);
        wh=w_i;
        
    elseif abs(w_i-w_f)<(pi+0.1) && abs(w_i-w_f)>(pi-0.1)
        %prima manovra pericentro orbita iniziale, seconda manovra
        %pericentro orbita finale
        ah=0.5*(rp_i+rp_f);
        dv1=sqrt(2*mu*(1/rp_i-1/(2*ah)))-sqrt(2*mu*(1/rp_i-1/(2*a_i)));
        dv2=sqrt(2*mu*(1/rp_f-1/(2*a_f)))-sqrt(2*mu*(1/rp_f-1/(2*ah)));
        dtm=pi*sqrt((ah^3)/mu);
        dt=timeOfFlight(a_i,e_i,theta_i,0)
        theta_f=0;
        eh=(rp_f-rp_i)/(rp_f+rp_i);
        wh=w_i;
    else
        error('anomalia pericentro sbagliata')
        
    end
else
    if abs(w_i-w_f)<0.1
        %prima manovra apocentro orbita iniziale, seconda manovra
        %pericentro orbita finale
        ah=0.5*(ra_i+rp_f);
        dv1=sqrt(2*mu*(1/ra_i-1/(2*ah)))-sqrt(2*mu*(1/ra_i-1/(2*a_i)));
        dv2=sqrt(2*mu*(1/rp_f-1/(2*a_f)))-sqrt(2*mu*(1/rp_f-1/(2*ah)));
        dtm=pi*sqrt((ah^3)/mu);
        dt=timeOfFlight(a_i,e_i,theta_i,pi);
        theta_f=0;
        eh=(ra_i-rp_f)/(ra_i+rp_f);
        wh=w_i;
    elseif abs(w_i-w_f)<(pi+0.1) && abs(w_i-w_f)>(pi-0.1)
        %prima mannovra apocentro orbita iniziale, seconda manovra
        %apocentro orbita finale
        ah=0.5*(ra_i+ra_f);
        dv1=sqrt(2*mu*(1/ra_i-1/(2*ah)))-sqrt(2*mu*(1/ra_i-1/(2*a_i)));
        dv2=sqrt(2*mu*(1/ra_f-1/(2*a_f)))-sqrt(2*mu*(1/ra_f-1/(2*ah)));
        dt=pi*sqrt((ah^3)/mu);  
        dtm=timeOfFlight(a_i,e_i,theta_i,pi);
        theta_f=pi;
        eh=abs(ra_i-ra_f)/(ra_i+ra_f);
        wh=w_f+pi;
    else
        error('anomalia pericentro sbagliata')
    end
end
dt_t=dtm+dt;    
end
