function [time,data] = processMirCatData(timestamps,rawData,fmircat,dCycle,fSample,nSamples,fCut)
    
    pulseWidth=1/fmircat/100*dCycle; %pulse width in seconds
    pulseFreq=1/(2*pulseWidth); %frequency of a pulse train (incl dead time)
    samplesToStore=uint32(floor(2*pulseWidth*fSample)); %number of samples to store for a pulse
    interVal=uint32(1/fmircat*fSample); %number of Samples in one pulse cycle
    totalPulses = uint32(floor(max(size(rawData))/interVal)); %total pulses in rawData
    NoSamplesHighF = double(totalPulses*samplesToStore);
    dataHighF=zeros(1,NoSamplesHighF); %make empty array for truncated rawData
    %size(dataHighF); %line added for debugging purposes
    timeStampInterval = round(nSamples/interVal); %number of pulses in one set of nSamples acquired
    j=1;
    k=1;
    %truncate data (i.e. remove all the dead time between pulses
    for i = 1:totalPulses
        dataHighF(j:j+samplesToStore-1)=rawData(k:k+samplesToStore-1);
        j=j+samplesToStore;
        k=k+interVal;
    end
    %create sine / cosine for the lockin algorithm
    
    t=linspace(0,double(totalPulses*samplesToStore/fSample),NoSamplesHighF);
    s_inPhase=sin(2*pi*pulseFreq*t);
    s_quad=cos(2*pi*pulseFreq*t);
    dI=dataHighF.*s_inPhase; %to speed things up, I commented out the in-phase part. It seems this triggered protocol always generates data in phase with the cosine
    dQ=dataHighF.*s_quad;
    %dMag=dataHighF.*s_quad;
    %calculate magnitude of signal, using pythagoras
    dMag=sqrt(dI.^2+dQ.^2);
    
    %calculate factor to decimate down to fmircat speed
    finalNoSamples = max(size(timestamps))*double(timeStampInterval);
    fact = NoSamplesHighF / finalNoSamples;
    %fact=fSample/fmircat/(4*dCycle); %the factor 10 doesnt make sense. Maybe it is duty cycle dependent since we truncate the 'dead time' out?
    if(fact<10)
        fprintf('Warning: fmircat too close to fSample\n');
    end
    data=decimate(dMag,fact,6); %this will bring the signal back to a freq of 1E5, using a 6th order chebyshev.
     %%%% DEBUGGING %%%%%%%%%
     subplot(3,1,1);
     plot(dMag);
     subplot(3,1,2);
     plot(data);
     subplot(3,1,3);
     plot(dataHighF);
%     %%%% DEBUGGING %%%%%%%%%
    
    if(exist('fCut','var'))
        if(fCut>fmircat/10)
            fprintf('Warning, Cut off frequency too high\n');
        end
        %apply a lowpass filter to the decimated data, to obtain only "DC"
        %component.
        %lpFilt = designfilt('lowpassfir','PassbandFrequency',fCut/(fmircat/2),...
        %     'StopbandFrequency',2*fCut/(fmircat/2),'PassbandRipple',0.5, ...
        %     'StopbandAttenuation',65,'DesignMethod','kaiserwin');
        Wp=fCut/(pulseFreq/fact/2);
        [b,a] = cheby1(6,0.05,Wp);
        %data=filter(lpFilt,d_Dec);
        %zi=ones(1,max(length(a),length(b))-1)*mean(d_Dec);
        data=filter(b,a,data);
    end
    
    %acquire timestamps, and interpolate times
    tstart=timestamps(1);
    time = zeros(1,finalNoSamples);
    n=1;
    for i=1:max(size(timestamps))
        for j=0:double(timeStampInterval)-1
            time(n)=timestamps(i)-tstart+j/fmircat;
            n=n+1;
        end
    end
    %size(time)
    %size(data)
end