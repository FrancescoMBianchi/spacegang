function [dv1,dv2,dt] = trasferimento_ellittico_bitangente (a_i,e_i,w_i,a_f,e_f,w_f,tipo_manovra)
% effettua un trasferimento ellittico bitangente per due orbite coplanari
%INPUT:
%a_i: semiasse maggiore orbita iniziale
%e_i: eccentricità orbita iniziale
%w_i: anomalia pericentro orbita iniziale
%a_f: semiasse maggiore orbita finale
%e_f: eccentricità orbita finale
%w_f: anomalia pericentro finale
%tipo_manovra: valore numerico che indica che tipo di manovra fare; se 0
%parto da pericentro dell'orbita iniziale, se 1 parto da apocentro
%dell'orbita iniziale
%OUTPUT
%dv1: delta v prima manovra [km/s]
%dv2: delta v seconda manovra  [km/s]
%dt: delta t manovra
%% calcolo raggio pericentro e apocentro delle due orbite
ra_i=a_i*(1+e_i);
rp_i=a_i*(1-e_i);
ra_f=a_f*(1+e_f);
rp_f=a_f*(1-e_f);
mu=398600; %[km^3/s^2]
%% calcolo delta v
if tipo_manovra==0
    if w_i==w_f
        %prima manovra pericentro orbita iniziale, seconda manovra
        %apocentro orbita finale
        ah=0.5*(rp_i+ra_f); %semiasse maggiore orbita di manovra
        dv1=sqrt(2*mu*(1/rp_i-1/(2*ah)))-sqrt(2*mu*(1/rp_i-1/(2*a_i)));
        dv2=sqrt(2*mu*(1/ra_f-1/(2*a_f)))-sqrt(2*mu*(1/ra_f-1/(2*ah)));
        dt=pi*sqrt((ah^3)/mu);
    else
        %prima manovra pericentro orbita iniziale, seconda manovra
        %pericentro orbita iniziale
        ah=0.5(rp_i+rp_f);
        dv1=sqrt(2*mu*(1/rp_i-1/(2*ah)))-sqrt(2*mu*(1/rp_i-1/(2*a_i)));
        dv2=sqrt(2*mu*(1/rp_f-1/(2*a_f)))-sqrt(2*mu*(1/rp_f-1/(2*ah)));
        dt=pi*sqrt((ah^3)/mu);
    end
else
    if w_i==w_f
        %prima manovra apocentro orbita iniziale, seconda manovra
        %pericentro orbita finale
        ah=0.5*(ra_i+rp_f);
        dv1=sqrt(2*mu*(1/ra_i-1/(2*ah)))-sqrt(2*mu*(1/ra_i-1/(2*a_i)));
        dv2=sqrt(2*mu*(1/rp_f-1/(2*a_f)))-sqrt(2*mu*(1/rp_f-1/(2*ah)));
        dt=pi*sqrt((ah^3)/mu);
    else
        %prima mannovra apocentro orbita iniziale, seconda manovra
        %apocentro orbita finale
        ah=0.5*(ra_i+ra_f);
        dv1=sqrt(2*mu*(1/ra_i-1/(2*ah)))-sqrt(2*mu*(1/ra_i-1/(2*a_i)));
        dv2=sqrt(2*mu*(1/ra_f-1/(2*a_f)))-sqrt(2*mu*(1/ra_f-1/(2*ah)));
        dt=pi*sqrt((ah^3)/mu);  
    end
end

