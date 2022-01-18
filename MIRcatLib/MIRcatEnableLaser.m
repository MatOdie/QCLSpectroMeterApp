function MIRcatEnableLaser()
    global MIRcatSDK_RET_SUCCESS;
    if ~libisloaded('MIRcatSDK') error('MIRcatSDK not loaded!'); end
    % Enable Laser Emission
    fprintf('========================================================\n');
    isEmitting = false;
    isEmittingPtr = libpointer('bool', isEmitting);
    calllib('MIRcatSDK','MIRcatSDK_IsEmissionOn', isEmittingPtr);
    isEmitting = isEmittingPtr.value;
    if ~isEmitting
        fprintf('Enable Laser Emission... ');
        ret = calllib('MIRcatSDK','MIRcatSDK_TurnEmissionOn');
        if MIRcatSDK_RET_SUCCESS == ret
            fprintf(' Successful\n' );
        else
            % If the operation fails, unload the library and raise an error.
            fprintf('Failure\n' );
            %calllib('MIRcatSDK','MIRcatSDK_DeInitialize');
            %unloadlibrary MIRcatSDK;
            %error('Error! Code: %d', ret);
        end
    end
    % Check for Laser Emission
    fprintf('========================================================\n');
    fprintf('Is Laser Emitting? ... ');
    calllib('MIRcatSDK','MIRcatSDK_IsEmissionOn', isEmittingPtr);
    isEmitting = isEmittingPtr.value;
    if isEmitting
        fprintf(' True\n');
    end
    fprintf('\n');
    while ~isEmitting
        calllib('MIRcatSDK','MIRcatSDK_IsEmissionOn', isEmittingPtr);
        isEmitting = isEmittingPtr.value;
        if isEmitting
            fprintf('\tTrue\n');
        else
            fprintf('\tFalse\n');
        end
        pause(0.5);
    end
end