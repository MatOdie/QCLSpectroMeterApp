function MIRcatDisarmLaser()
    global MIRcatSDK_RET_SUCCESS;
    % Disarm Laser
    if ~libisloaded('MIRcatSDK') error('MIRcatSDK not loaded!'); end
    fprintf('========================================================\n');
    fprintf('Disarming Laser ... ');
    ret = calllib('MIRcatSDK','MIRcatSDK_DisarmLaser');
    if MIRcatSDK_RET_SUCCESS == ret
        fprintf('Successful\n' );
    else
        fprintf('Error in disarm laser!!\n' );
        % If the operation fails, unload the library and raise an error.
        %calllib('MIRcatSDK','MIRcatSDK_DeInitialize');
        %unloadlibrary MIRcatSDK;
        %error('Error! Code: %d', ret);
    end
end