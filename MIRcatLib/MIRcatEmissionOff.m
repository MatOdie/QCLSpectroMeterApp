function MIRcatEmissionOff()
    global MIRcatSDK_RET_SUCCESS;
    ret = calllib('MIRcatSDK','MIRcatSDK_TurnEmissionOff');
    if MIRcatSDK_RET_SUCCESS == ret
        fprintf('Successful\n' );
    else
        % If the operation fails, unload the library and raise an error.
        %calllib('MIRcatSDK','MIRcatSDK_DeInitialize');
        %unloadlibrary MIRcatSDK;
        error('Error! Code: %d', ret);
    end
    
end