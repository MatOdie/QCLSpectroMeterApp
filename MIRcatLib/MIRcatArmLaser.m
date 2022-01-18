function [isArmed,atTemp] = MIRcatArmLaser()
    global MIRcatSDK_RET_SUCCESS;
    if ~libisloaded('MIRcatSDK') error('MIRcatSDK not loaded!'); end
     % Step 4: Arm the laser
    fprintf('========================================================\n');
    fprintf('Test: Arm Laser ... ');
    isArmed = false;
    isArmedPtr = libpointer('bool', isArmed);
    calllib('MIRcatSDK','MIRcatSDK_IsLaserArmed', isArmedPtr);
    isArmed = isArmedPtr.value;
    if ~isArmed
        ret = calllib('MIRcatSDK','MIRcatSDK_ArmDisarmLaser');
        if MIRcatSDK_RET_SUCCESS == ret
            fprintf(' Successful\n' );
            fprintf('========================================================\n');
            fprintf('Test: Is Laser Armed?\n');
        else
            % If the operation fails, unload the library and raise an error.
            fprintf(' Failure in arm laser!\n');
            return;
            %unloadlibrary MIRcatSDK;
            %error('Error! Code: %d', ret);
        end
    else
        fprintf(' Already Armed\n ');
    end
    while ~isArmed
        calllib('MIRcatSDK','MIRcatSDK_IsLaserArmed', isArmedPtr);
        isArmed = isArmedPtr.value;
        if logical(isArmed)
            fprintf('\tTrue\n' );
        else
            fprintf('\tFalse\n');
        end
        pause(1.0);
    end
    % Step 5: Wait for TECs to arrive at safe operating temperature
    fprintf('========================================================\n');
    fprintf('Are TECs at Safe Operating Temp? ... \n');
    atTemp = false;
    atTempPtr = libpointer('bool', atTemp);
    calllib('MIRcatSDK','MIRcatSDK_AreTECsAtSetTemperature', atTempPtr);
    atTemp = atTempPtr.value;
    if logical(atTemp)
        fprintf('\tTrue\n' );
    end
    while ~atTemp
        calllib('MIRcatSDK','MIRcatSDK_AreTECsAtSetTemperature', atTempPtr);
        atTemp = atTempPtr.value;
        if logical(atTemp)
            fprintf('\tTrue\n' );
        else
            fprintf('\tFalse\n');
        end
        pause(1);
    end
end