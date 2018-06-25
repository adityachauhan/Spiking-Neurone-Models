# Spiking-Neurone-Models

## Adaptive Exponential neurone model

This model is coded in the AdEx.m and can be run in MatLab console with following thre different input sets.

### This is input for tonic bursting.
t = 0:0.0005:2; I = zeros([length(t) 1]); I(400:3601)=0.65;
[V w] = aEIF(t,I,0.45,25,-70.6,-50.4,20,-47.4,2,144,4,0.0805,-70.6,0,1);

### This is input for post-inhibitory reboundg.
t = 0:0.0005:2; I = zeros([length(t) 1]); I(200:1000)=-0.8;
[V w] = aEIF(t,I,0.45,25,-60,-50.4,20,-60,2,720,80,0.0805,-70.6,0,1);

### This is input for subthreshold oscillations and resonant firing.
t = 0:0.0005:2; I = zeros([length(t) 1]); I([500:540 2200:2240 2400:2440])=1;
[V w] = aEIF(t,I,0.576,6,-70.6,-50.4,20,-70.6,2,96,55,0.0805,-70.6,0,1);


## Poisson neurone model

This model is coded in two different formats both in Poisson folder.

## Integrate and Fire model

This is coded for steady state and spikes at constant firing rate.
