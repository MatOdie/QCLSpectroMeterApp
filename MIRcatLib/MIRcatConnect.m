function success = MIRcatConnect()
    global MIRcatSDK_RET_SUCCESS;
    global MIRcatSDK_RET_INITIALIZATION_FAILURE;
    if ~libisloaded('MIRcatSDK') error('MIRcatSDK not loaded!'); end
    success = true;    
    fprintf('========================================================\n');
    fprintf('Initializing MIRcat ... ');
    % Call your function
    ret = calllib('MIRcatSDK','MIRcatSDK_Initialize');
    % Check to see if function call was Successful
    if MIRcatSDK_RET_SUCCESS == ret
        fprintf('Successful\n' );
    elseif MIRcatSDK_RET_INITIALIZATION_FAILURE == ret
        cprintf('*green','Lib returned initialization failure. Check your Mircat connections.\n');
        success = false;
    else
        % If the operation fails, unload the library and raise an error.
        unloadlibrary MIRcatSDK;
        error('Error! Code: %d', ret);
        success = false;
    end
end