close all
clear all
Re = 6.37e6;
figure(1);
[x,y,z] = sphere(50);
s = surf(Re*x/1e3,Re*y/1e3,Re*z/1e3); % create a sphere
axis equal
