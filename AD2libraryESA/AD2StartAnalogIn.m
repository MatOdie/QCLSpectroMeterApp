function AD2StartAnalogIn(hdwf,reconfig,waitTillDone)
% AD2StartAnalogIn - start data acquisition. Note this takes some time.
%
% AD2StartAnalogIn(hdwf)
%
%   Input arguments: 
%   hdwf - hardware device ID
%
%
%   See also AD2Init, AD2close, AD2initAnalogIn, AD2initAnalogOut.
%
%   Author(s):
% v1.0: Mathieu Odijk - Copyright 2020
%

if ~libisloaded('dwf')
    error('dwf library not loaded, make sure to run AD2Init first');
    return
end
if ~exist('reconfig','var')
    reconfig = 1;
end
if ~exist('waitTillDone','var')
    waitTillDone = 1;
end

%    printf("Starting acquisition\n");
calllib('dwf','FDwfAnalogInConfigure',hdwf, reconfig, 1); %reconfigure = 1, start = 1


if(waitTillDone)
    %display('Waiting to finish...');
    psts=libpointer('uint8Ptr',0);
    stopp=1;
    while(stopp)
    calllib('dwf','FDwfAnalogInStatus',hdwf, 1, psts);
         if(psts.Value == 2)
            stopp=0;
         end
    %     Wait(0.1);
    end
    %display('done!');
else
    psts=libpointer('uint8Ptr',0);
    calllib('dwf','FDwfAnalogInStatus',hdwf, 1, psts);
end
return