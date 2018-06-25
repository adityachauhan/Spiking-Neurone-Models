%IF neuron
clc;
clear;

fs=16;% font size

V0=0.6;%mV
T=500;%msec
dt=0.1; %msec
taum=10;%ms Time constant

Vrest=0;

maxsteps=round(T/dt);

V=zeros(1,round(T/dt));
V(1,1)=Vrest;

beta=dt/taum;
alpha=1-beta;


for timestep=2:1:maxsteps
    V(1,timestep)=alpha*V(1,timestep-1)+beta*V0;    
end

time=0:dt:T-dt;

plot(time,V,'LineWidth',2)
xlabel('Time (ms)','fontsize',fs);
ylabel('Membrane potential','fontsize',fs);
set(gca,'fontsize',fs);




