function MIRcatMultiScan(WaveL_array_um)    
    % Multi-Spectral Scan
    global MIRcatSDK_RET_SUCCESS;
    global MIRcatSDK_UNITS_MICRONS;
    
    if ~libisloaded('MIRcatSDK') error('MIRcatSDK not loaded!'); end
    fprintf('========================================================\n');
    fprintf('Starting Multi-Spectral Scan ... ');
    fprintf('========================================================\n');
    fprintf('Test: Set Amount of Multi-Specral Elements ... ');
    ret = calllib('MIRcatSDK','MIRcatSDK_SetNumMultiSpectralElements', 10);
    if MIRcatSDK_RET_SUCCESS == ret
        fprintf(' Successful\n' );
    else
        % If the operation fails, unload the library and raise an error.
        fprintf(' Failure\n' );
        return;
        %unloadlibrary MIRcatSDK;
        %error('Error! Code: %d', ret);
    end
    fprintf('========================================================\n');
    fprintf('Test: Add Multi-Specral Elements ... ');
    %startWW = single(5.7);
    mx = max(size(WaveL_array_um));
    %startWW = single(WaveL_array_um(1));
    for i = 1:mx
        fprintf('\tTest: Add Multi-Specral Element ... ');
        ret = calllib('MIRcatSDK','MIRcatSDK_AddMultiSpectralElement', single(WaveL_array_um(i)), MIRcatSDK_UNITS_MICRONS, 1000, 1000);
        if MIRcatSDK_RET_SUCCESS == ret
            fprintf(' Successful\n' );
        else
            % If the operation fails, unload the library and raise an error.
            fprintf(' Failure\n' );
            %unloadlibrary MIRcatSDK;
            %error('Error! Code: %d', ret);
        end
    end
    fprintf('========================================================\n');
    fprintf('Test: Start Multi-Spectral Scan ... ');
    ret = calllib('MIRcatSDK','MIRcatSDK_StartMultiSpectralModeScan', 1);
    if MIRcatSDK_RET_SUCCESS == ret
        fprintf(' Successful\n' );
    else
        % If the operation fails, unload the library and raise an error.
        fprintf(' Failure\n' );
        return;
        %unloadlibrary MIRcatSDK;
        %error('Error! Code: %d', ret);
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