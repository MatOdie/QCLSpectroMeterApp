function [data,nSamples] = AD2GetAnalogDataContinuous(hdwf, channel)
% AD2GetAnalogDataContinuous - get the analog data from the AD2 buffer continuously.
%
% AD2GetAnalogData(hdwf, channel)
%
%   Input arguments: 
% hdwf - hardware device ID of AD2
% channel - analog input channel
%
%
%   See also AD2Init, AD2close, AD2initAnalogIn, AD2initAnalogOut.
%
%   Author(s):
% v1.0: Mathieu Odijk - Copyright 2021
%

% if ~libisloaded('dwf') %disabled for speed
%     error('dwf library not loaded, make sure to run AD2Init first');
% end


nSamplesPtr = libpointer('int32Ptr',0);
calllib('dwf', 'FDwfAnalogInStatusSamplesValid', hdwf, nSamplesPtr);
nSamples=nSamplesPtr.Value;
data=zeros(1,nSamples);
if(nSamples>0)
    pData = libpointer('doublePtr', zeros(1,nSamples)); %initialize variable to store data
    % % get the acquired samples for first channel (0)
    calllib('dwf', 'FDwfAnalogInStatusData', hdwf, channel, pData, nSamples);
    data = pData.Value;
end

return;