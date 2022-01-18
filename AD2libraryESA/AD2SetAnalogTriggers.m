function AD2SetAnalogTriggers(hdwf,source,type,channel,level,trigCond)

%   unsigned char TRIGSRC;
%         trigsrcNone 0 The trigger pin is high impedance, input. This is the default setting.
%         trigsrcPC 1 Trigger from PC, this can be used to synchronously start multiple
%         instruments.
%         trigsrcDetectorAnalogIn 2 Trigger detector on analog in channels.
%         trigsrcDetectorDigitalIn 3 Trigger on digital input channels.
%         trigsrcAnalogIn 4 Trigger on device instruments, these output high when running.
%         trigsrcDigitalIn 5 Trigger on device instruments, these output high when running.
%         trigsrcDigitalOut 6 Trigger on device instruments, these output high when running.
%         trigsrcAnalogOut1 7 Trigger on device instruments, these output high when running.
%         trigsrcAnalogOut2 8 Trigger on device instruments, these output high when running.
%         trigsrcAnalogOut3 9 Trigger on device instruments, these output high when running.
%         trigsrcAnalogOut4 10 Trigger on device instruments, these output high when running.
%         trigsrcExternal1 11 External trigger signal.
%         trigsrcExternal2 12 External trigger signal.
%         trigsrcExternal3 13 External trigger signal.
%         trigsrcExternal4 14 External trigger signal.
%
%   typedef int TRIGTYPE;
%         const TRIGTYPE trigtypeEdge         = 0;
%         const TRIGTYPE trigtypePulse        = 1;
%         const TRIGTYPE trigtypeTransition   = 2;
%
%   typedef int TRIGCOND;
%         const TRIGCOND trigcondRisingPositive   = 0;
%         const TRIGCOND trigcondFallingNegative  = 1;

%// disable auto trigger
    calllib('dwf','FDwfAnalogInTriggerAutoTimeoutSet',hdwf, 0);
    
    calllib('dwf','FDwfAnalogInTriggerSourceSet',hdwf, source); % # trigsrcDetectorAnalogIn

    if exist('type','var')
        calllib('dwf','FDwfAnalogInTriggerTypeSet',hdwf, type); % # trigtypeEdge = = 0
    end
    if exist('channel','var')
        calllib('dwf','FDwfAnalogInTriggerChannelSet',hdwf, channel); %# channel 1
    end
    if exist('level','var')
        calllib('dwf','FDwfAnalogInTriggerLevelSet',hdwf, level); %# 0V
    end
    if exist('trigCond','var')
        calllib('dwf','FDwfAnalogInTriggerConditionSet',hdwf, trigCond);
    end


end
