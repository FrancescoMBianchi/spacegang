function [deltavt,rah] = biellittic_transfer(ai,ei,wi,af,ef,c)
mu=398600;
rpi=ai*(1-ei);
rai=ai*(1+ei);
rpf=af*(1-ef);
raf=af*(1+ef);
rah=c*raf;
deltav1=sqrt(2*mu*((1/rai)-1/(rai+rah)))-sqrt(2*mu*((1/rai)-1/(2*ai)));
deltav2=sqrt(2*mu*((1/rah)-1/(rpf+rah)))-sqrt(2*mu*((1/rah)-1/(rai+rah)));
deltav3=sqrt(2*mu*((1/rpf)-1/(2*af)))-sqrt(2*mu*((1/rpf)-1/(rpf+rah)));
deltavt=abs(deltav1)+abs(deltav2)+abs(deltav3);
end

