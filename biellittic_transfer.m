function [deltavt,rah] = biellittic_transfer(ai,ei,wi,af,ef,c)
% c variabile del ciclo for che moltiplica raggio di apocentro iniziale per trovare il raggio di apocentro dell'orbita di trasferimento 
% trasferimento biellittico nel caso in cui il primo impulso è fatto nel pericentro dell'orbita iniziale e il cambio forma inverte l'anomalia del pericentro 
mu=398600;
rpi=ai*(1-ei); %raggio pericentro iniziale
rai=ai*(1+ei); %raggio apocentro iniziale
rpf=af*(1-ef); %raggio pericentro finale
raf=af*(1+ef); %raggio apocentro finale
rah=c*rai; %raggio apocentro orbita di trasferimento
deltav1=sqrt(2*mu*((1/rpi)-1/(rpi+rah)))-sqrt(2*mu*((1/rpi)-1/(2*ai)));
deltav2=sqrt(2*mu*((1/rah)-1/(raf+rah)))-sqrt(2*mu*((1/rah)-1/(rpi+rah)));
deltav3=sqrt(2*mu*((1/raf)-1/(2*af)))-sqrt(2*mu*((1/raf)-1/(raf+rah)));
deltavt=abs(deltav1)+abs(deltav2)+abs(deltav3);
end

