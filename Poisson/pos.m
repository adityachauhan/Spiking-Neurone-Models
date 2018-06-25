
function poisson
timeStepS = 0.001;                  
spikesPerS = 50;                    
durationS = 1.000;                  
spikes = makeSpikes(timeStepS, spikesPerS, durationS, 25);
rasterPlot(spikes, timeStepS);
end
function rasterPlot(spikes, ~)
figure(1);
axes('position', [0.1, 0.1, 0.8, 0.8]);
axis([0, length(spikes) - 1, 0, 1]);
trains = size(spikes, 1); 
ticMargin = 0.01;                                      
ticHeight = (1.0 - (trains + 1) * ticMargin) / trains;
for train = 1:trains
    spikeTimes = find(spikes(train, :) == 1);
    yOffset = ticMargin + (train - 1) * (ticMargin + ticHeight);
    for i = 1:length(spikeTimes)
        line([spikeTimes(i), spikeTimes(i)], [yOffset, yOffset + ticHeight]);
    end
end
xlabel('Time (s)')
title('Raster plot of spikes');
end
function spikes = makeSpikes(timeStepS, spikesPerS, durationS, numTrains)
if (nargin < 4)
    numTrains = 1;
end
times = [0:timeStepS:durationS];
spikes = zeros(numTrains, length(times));
for train = 1:numTrains
    vt = rand(size(times));
    spikes(train, :) = (spikesPerS*timeStepS) > vt;
end
end