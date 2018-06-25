%IF neuron
clc;
clear;

fs=16;% font size

V0= 30;%mV
T=100;%msec
dt=0.1; %msec
taum=10;%ms Time constant

Vrest=-75;
Vthres=-50;

maxsteps=round(T/dt);

V=zeros(1,round(T/dt));
V(1,1)=Vrest;

beta=dt/taum;
alpha=1-beta;


for timestep=2:1:maxsteps
    V(1,timestep)=alpha*V(1,timestep-1)+beta*Vrest+beta*V0;
    if V(1,timestep)>Vthres
       V(1,timestep)=Vrest;
       V(1,timestep-1)=1; %trick to make spikes look good
    end
    
end

time=0:dt:T-dt;

plot(time,V,'LineWidth',2)
xlabel('Time (ms)','fontsize',fs);
ylabel('Membrane potential','fontsize',fs);
set(gca,'fontsize',fs);
