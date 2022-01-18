function MIRcatClose()
    global MIRcatSDK_RET_SUCCESS;
    % Disconnect from MIRcat
    fprintf('========================================================\n');
    fprintf('De-Initialize MIRcatSDK ... ');
    ret = calllib('MIRcatSDK','MIRcatSDK_DeInitialize');
    if MIRcatSDK_RET_SUCCESS == ret
        fprintf('Successful\n' );
        unloadlibrary MIRcatSDK;
    else
        % If the operation fails, unload the library and raise an error.
         fprintf('Failed\n' );
        unloadlibrary MIRcatSDK;
        %error('Error! Code: %d', ret);
    end
end