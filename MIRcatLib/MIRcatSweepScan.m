function MIRcatSweepScan(startWaveL_um, stopWaveL_um, waveL_speed)
    % Sweep Scan
    global MIRcatSDK_RET_SUCCESS;
    global MIRcatSDK_UNITS_MICRONS;
    if ~libisloaded('MIRcatSDK') error('MIRcatSDK not loaded!'); end
    fprintf('========================================================\n');
    fprintf(['Starting Sweep mode scan from ',num2str(startWaveL_um),' to ',num2str(stopWaveL_um),' um with a speed ',num2str(waveL_speed*1000),' microns\n']);
    ret = calllib('MIRcatSDK','MIRcatSDK_StartSweepScan', ...
    single(startWaveL_um), single(stopWaveL_um), single(waveL_speed), ...
    MIRcatSDK_UNITS_MICRONS, uint16(1), true, uint8(1));
    if MIRcatSDK_RET_SUCCESS == ret
        fprintf(' Successful\n' );
    else
        % If the operation fails, unload the library and raise an error.
        fprintf(' Failure\n' );
        %calllib('MIRcatSDK','MIRcatSDK_DeInitialize');
        %unloadlibrary MIRcatSDK;
        %error('Error! Code: %d', ret);
        return;
    end
    isScanInProgress = true;
    isScanInProgressPtr = libpointer('bool', isScanInProgress);
    isScanActive = false;
    isScanActivePtr = libpointer('bool', isScanActive);
    isScanPaused = false;
    isScanPausedPtr = libpointer('bool', isScanPaused);
    curScanNum = uint16(0);
    curScanNumPtr = libpointer('uint16Ptr', curScanNum);
    curScanPercent = uint16(0);
    curScanPercentPtr = libpointer ('uint16Ptr', curScanPercent);
    curWW = single(0);
    curWWPtr = libpointer('singlePtr', curWW);
    units = uint8(0);
    unitsPtr = libpointer('uint8Ptr', units);
    isTECinProgress = false;
    isTECinProgressPtr = libpointer('bool', isTECinProgress);
    isMotionInProgress = false;
    isMotionInProgressPtr = libpointer('bool', isMotionInProgress);
    fprintf('========================================================\n');
    fprintf('Test: Get Scan Status\n');
    while isScanInProgress
        calllib('MIRcatSDK','MIRcatSDK_GetScanStatus', ...
        isScanInProgressPtr, isScanActivePtr, isScanPausedPtr, ...
        curScanNumPtr, curScanPercentPtr, curWWPtr, unitsPtr, ...
        isTECinProgressPtr, isMotionInProgressPtr);

        isScanInProgress = isScanInProgressPtr.value;
        isScanActive = isScanActivePtr.value;
        isScanPaused = isScanPausedPtr.value;
        curScanNum = curScanNumPtr.value;
        curScanPercent = curScanPercentPtr.value;
        curWW = curWWPtr.value;
        units = unitsPtr.value;
        isTECinProgress = isTECinProgressPtr.value;
        isMotionInProgress = isMotionInProgressPtr.value;

        fprintf(['\tIsScanInProgress: %d \tIsScanActive: %d \tisScanPaused: %d', ...
        '\tcurScanNum: %d \tcurWW: %.3f \tunits: %u \tcurScanPercent: %.2f', ...
        '\tisTECinProgress: %d \tisMotionInProgress: %d\n'], ...
        isScanInProgress, isScanActive, isScanPaused, curScanNum, curWW, ...
        units, curScanPercent, isTECinProgress, isMotionInProgress);

        pause(0.3);
    end
end