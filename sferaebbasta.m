close all
clear all
a=12610,0;
e=0,2656;
i=1,0430;
omega=1,8790;
w=2,4080;
Re = 6.37e6; %raggio della terra
figure(1);
[x,y,z] = sphere(50); %crea tre matrici N+1 * N+1
s = surf(Re*x/1e3,Re*y/1e3,Re*z/1e3); % create a sphere
axis equal
hold on
p=a(1-e^2); 

R= [   cos(omega)*cos(w) - sin(omega)*cos(i)*sin(w), sin(omega)*cos(w) + cos(omega)*cos(i)*sin(w), sin(i)*sin(w);
    - cos(omega)*sin(w) - sin(omega)*cos(i)*cos(w), cos(omega)*cos(i)*cos(w) - sin(omega)*sin(w), cos(w)*sin(i);
                      sin(omega)*sin(i),                                 -cos(omega)*sin(i),            cos(i)] %rotazione per passare da ijk a perifocale

X=zeros(360,1);
Y=zeros(360,1);
Z=zeros(360,1);
teta=0:1:359;
for i=1:360
   x=zeros(3,1);
   r= p/(1+e*cos(teta(i)));
   rvect=zeros(3,1);
   rvect(1)=r*cos(teta(i));
   revect(2)=r*sin(teta(i)); 
   x=R'*rvect;
   X(i)=x(1);
   Y(i)=x(2);
   Z(i)=x(3);
end
hold on
plot3(X,Y,Z)
