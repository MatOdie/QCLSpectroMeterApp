function isInterlockSet = MIRcatCheckInterlock()
    if ~libisloaded('MIRcatSDK') error('MIRcatSDK not loaded!'); end
    % Step 2: Check for Interlock Status
    fprintf('========================================================\n');
    fprintf('Test: Is Interlock Set ... ');
    isInterlockSet = false;
    isInterlockSetPtr = libpointer('bool', isInterlockSet);
    ret = calllib('MIRcatSDK','MIRcatSDK_IsInterlockedStatusSet', isInterlockSetPtr);
    isInterlockSet = isInterlockSetPtr.value;
    if logical(isInterlockSet)
        fprintf('Interlock set = Yes\n' );
    else
        % If the operation fails, unload the library and raise an error.
        fprintf('Interlock set = NO\n' );
        %calllib('MIRcatSDK','MIRcatSDK_DeInitialize');
        %unloadlibrary MIRcatSDK;
        %error('Error! Interlock is not set. Code: %d', ret);
    end
end