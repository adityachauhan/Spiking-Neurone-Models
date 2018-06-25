%implementation of the simples spiking neuron model: Poisson neuron
close all;
clc;
clear;
N=20;% number of neurons
dt=1;% discretization step (ms)
T=8000; %simulation time (in ms)

fs=18;

%initialize instantaneous firing rate; this corresponds to a gaussian
%profile
m0=N/2;
sigma=2;
x=(1:N);
r=exp(-(x-m0).^2/(2*sigma^2))/(sigma*sqrt(2*pi)); % instantaneous firing rate, units: 1/ms

figure(1)
bar(r)
axis tight
hold on
set(gca,'fontsize',fs);
xlabel('Neuron index','fontsize',fs);
ylabel('Firing rate','fontsize',fs);

time=dt:dt:T;
iterations=size(time,2);
Y=zeros(N,iterations);


for t=1:iterations
    Y(:,t)=rand(1,N)<r*dt;
end

figure(2)
imagesc(time,(1:N),Y);
xlabel('Time (ms)','fontsize',fs);
ylabel('Spikes','fontsize',fs);
set(gca,'fontsize',fs);

figure(1)
totalSpikes=sum(Y,2);
meanFiringRate=totalSpikes/T; %spikes/ time unit: mean firing rate
plot(meanFiringRate,'--rs','LineWidth',2,'Color','r','MarkerSize',6); 
axis tight    
legend('"true"','reconstruction');