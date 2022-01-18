function isKeySwitchSet = MIRcatCheckKey()
    if ~libisloaded('MIRcatSDK') error('MIRcatSDK not loaded!'); end
    % Step 3: Check for Key Switch Status
    fprintf('========================================================\n');
    fprintf('Test: Is Key Switch Set ... ');
    isKeySwitchSet = false;
    isKeySwitchSetPtr = libpointer('bool', isKeySwitchSet);
    ret = calllib('MIRcatSDK','MIRcatSDK_IsKeySwitchStatusSet',isKeySwitchSetPtr);
    isKeySwitchSet = isKeySwitchSetPtr.value;
    if logical(isKeySwitchSet)
    fprintf(' Key switch = Yes\n' );
    else
        % If the operation fails, unload the library and raise an error.
        fprintf('Key switch = NO\n' );
        %calllib('MIRcatSDK','MIRcatSDK_DeInitialize');
        %unloadlibrary MIRcatSDK;
        %error('Error! KeySwitch is not set. Code: %d', ret);
    end
end