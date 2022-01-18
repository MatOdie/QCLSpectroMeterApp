function [mxPulseRate,mxPulseWidth,mxDutyCycle,mxCurrent] = MIRcatGetLaserMaxs(QCL_id)
    if ~libisloaded('MIRcatSDK') error('MIRcatSDK not loaded!'); end
    QCL = uint8(QCL_id);
    mxPulseRate = single(0);
    mxPulseRatePtr = libpointer('singlePtr', mxPulseRate);
    mxPulseWidth = single(0);
    mxPulseWidthPtr = libpointer('singlePtr', mxPulseWidth);
    mxDutyCycle = single(0);
    mxDutyCyclePtr = libpointer('singlePtr', mxDutyCycle);
    ret = calllib('MIRcatSDK','MIRcatSDK_GetQCLPulseLimits', QCL, mxPulseRatePtr, mxPulseWidthPtr, mxDutyCyclePtr);
    mxPulseRate = mxPulseRatePtr.value;
    mxPulseWidth = mxPulseWidthPtr.value;
    mxDutyCycle = mxDutyCyclePtr.value;
    
    mxCurrent = uint16(0);
    mxCurrentPtr = libpointer('uint16Ptr', mxCurrent);
    ret = calllib('MIRcatSDK','MIRcatSDK_GetQCLMaxPulsedCurrent', QCL, mxCurrentPtr);
    mxCurrent = mxCurrentPtr.value;
end
