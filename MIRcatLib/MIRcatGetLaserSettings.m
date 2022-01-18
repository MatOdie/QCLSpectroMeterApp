function [pulseRate,pulseWidth,Current,setTemp] = MIRcatGetLaserSettings(QCL_id)
    if ~libisloaded('MIRcatSDK') error('MIRcatSDK not loaded!'); end
    QCL = uint8(QCL_id);
    pulseRate = single(1);
    pulseRatePtr = libpointer('singlePtr', pulseRate);
    ret = calllib('MIRcatSDK','MIRcatSDK_GetQCLPulseRate', QCL, pulseRatePtr);
    pulseRate = pulseRatePtr.value;
    
    pulseWidth = single(1);
    pulseWidthPtr = libpointer('singlePtr', pulseWidth);
    ret = calllib('MIRcatSDK','MIRcatSDK_GetQCLPulseWidth', QCL, pulseWidthPtr);
    pulseWidth = pulseWidthPtr.value;
    
    Current = single(1);
    QCLcurrentPtr = libpointer('singlePtr', Current);
    ret = calllib('MIRcatSDK','MIRcatSDK_GetQCLCurrent', QCL, QCLcurrentPtr);
    Current = QCLcurrentPtr.value;
    
    setTemp = single(1);
    setTempPtr = libpointer('singlePtr', setTemp);
    ret = calllib('MIRcatSDK','MIRcatSDK_GetQclSetTemperature', QCL, setTempPtr);
    setTemp = setTempPtr.value;

end