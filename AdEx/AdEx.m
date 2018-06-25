function [V,w,St] = AdEx(t,I,C,gL,EL,Vt,Vp,Vr,Dt,tauw,a,b,initV,initw,pflag)
C     = C*1e-9;                                     %Membrane Capacitance
gL    = gL*1e-9;                                    %Leaky conductance
EL    = EL*1e-3;                                    %Leaky reversal potential
Vt    = Vt*1e-3;                                    %Threshold potential of spike
Vp    = Vp*1e-3;                                    %peak potential at spike
Vr    = Vr*1e-3;                                    %reset potential after spike
Dt    = Dt*1e-3;                                    %slope factor
a     = a*1e-9;                                     %adaptation coupling parameter
b     = b*1e-9;                                     %current increament parameter
tauw  = tauw*1e-3;                                  %adaptation time constant
I     = I*1e-9;                                     %Injected current
initV = initV*1e-3;                                 %initial membrane potential
initw = initw*1e-9;                                 %initial adaptation current
dt    = t(2)-t(1);                                  %time step
nNeurons = size(I,2);                               %number of neurons
[V,w,Sb] = deal(zeros([length(t) nNeurons]));
V(1,:)   = initV;                                   %membrane potential vector
w(1,:)   = initw;                                   %adaptation current vector

%loop over the time duration
for i = 1 : length(t)-1
    %updates membrane potential and adds to vector V
	V(i+1,:) = V(i,:) + dt/C*(-gL*(V(i,:)-EL) + gL*Dt*exp((V(i,:)-Vt)/Dt) - w(i,:) + I(i,:));
    %check for spikes
	spikes = V(i+1,:) > Vp;
    %update adaptation current
	w(i+1,:) = w(i,:) + dt/tauw*(a*(V(i,:)-EL) - w(i,:)) + spikes*b;
	V(i,spikes)   = Vp; %set spike potential
	V(i+1,spikes) = Vr; %reset membrane potential
	Sb(i,spikes)  = 1;  %set spike bits
end

%loop to check number of times spikes occured.
if nNeurons == 1
    St = find(Sb)*dt;
else
    St = cell([nNeurons 1]);
    for i = 1: nNeurons
        St{i} = find(Sb(:,i))*dt;
    end
end
V = V*1e3;
w = w*1e9;
I = I*1e9;

%plot the results
if pflag
	figure, set(gcf,'Color',[1 1 1])
	subplot(6,1,1:3)
	plot(t,V,'-r')
	title('AdEx LIF neuron model')
	ylabel('Voltage(V))')
	axis([t([1 end]) -100 30])
	subplot(6,1,4:5)
	plot(t,w,'-k')
	ylabel('w')
	axis([t([1 end]) min(w(:))-0.02 max(w(:))+0.02])
	subplot(6,1,6)
	plot(t,I,'-b')
	xlabel('time'); ylabel('I')
	axis([t([1 end]) min(I(:))-0.02 max(I(:))+0.02])
end

