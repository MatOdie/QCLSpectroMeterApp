function MIRcatEmissionOn()
    global MIRcatSDK_RET_SUCCESS;
    ret = calllib('MIRcatSDK','MIRcatSDK_TurnEmissionOn');
    if MIRcatSDK_RET_SUCCESS == ret
        fprintf('Emission on successful\n' );
    else
        fprintf('Failure in emission on\n' );
        % If the operation fails, unload the library and raise an error.
        %calllib('MIRcatSDK','MIRcatSDK_DeInitialize');
        %unloadlibrary MIRcatSDK;
        %error('Error! Code: %d', ret);
    end
   
end