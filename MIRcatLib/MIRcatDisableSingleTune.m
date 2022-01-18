function MIRcatDisableSingleTune()
    global MIRcatSDK_RET_SUCCESS;
    %After completing manually tuned scans, you must first disable manual tune
    % mode before you can move on to another scan mode.
    if ~libisloaded('MIRcatSDK') error('MIRcatSDK not loaded!'); end
    % IMPORTANT: Disable Manual Scan Tune before starting another scan
    fprintf('Test: Disable Manual Tune Mode ... ');
    ret = calllib('MIRcatSDK','MIRcatSDK_CancelManualTuneMode');
    if MIRcatSDK_RET_SUCCESS == ret
        fprintf(' Successful\n' );
    else
        % If the operation fails, unload the library and raise an error.
        fprintf(' Failure in disable single tune\n' );
        %calllib('MIRcatSDK','MIRcatSDK_DeInitialize');
        %unloadlibrary MIRcatSDK;
        %error('Error! Code: %d', ret);
    end
end