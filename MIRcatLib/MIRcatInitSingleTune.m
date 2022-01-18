function actualWW = MIRcatInitSingleTune(wavelength_um)
    global MIRcatSDK_RET_SUCCESS;
    global MIRcatSDK_UNITS_MICRONS;
    actualWW = single(0);
    % single (manual) tune scan
    % Important: - You MUST cancel Manual Tune Mode before performing 
    % another type of scan or else an error will be returned.
    if ~libisloaded('MIRcatSDK') error('MIRcatSDK not loaded!'); end
    fprintf('========================================================\n');
    fprintf('Starting Single Tune Test\n\n');
    fprintf('========================================================\n');
    fprintf(['Test: Tune to WW ',num2str(wavelength_um,2),' Microns ... ']);
    ret = calllib('MIRcatSDK','MIRcatSDK_TuneToWW', ...
    single(wavelength_um), MIRcatSDK_UNITS_MICRONS, 1);
    if MIRcatSDK_RET_SUCCESS == ret
        fprintf(' Successful\n' );
    else
        % If the operation fails, unload the library and raise an error.
        fprintf(' Failure\n' );
        %calllib('MIRcatSDK','MIRcatSDK_DeInitialize');
        %unloadlibrary MIRcatSDK;
        %error('Error! Code: %d', ret);
        return;
    end
    % Check the laser tuning
    isTuned = false;
    isTunedPtr = libpointer('bool', isTuned);
    
    actualWWPtr = libpointer('singlePtr', actualWW);
    units = uint8(0);
    unitsPtr = libpointer('uint8Ptr', units);
    lightValid = false;
    lightValidPtr = libpointer('bool', lightValid);
    fprintf('Test: Is Tuned? ... \n');
    calllib('MIRcatSDK','MIRcatSDK_IsTuned', isTunedPtr);
    isTuned = isTunedPtr.value;
    if isTuned
        fprintf('\t True\n');
    end
    while ~isTuned
        % Check Tuning Status
        calllib('MIRcatSDK','MIRcatSDK_IsTuned', isTunedPtr);
        isTuned = isTunedPtr.value;
        if logical(isTuned)
            fprintf('\tTrue');
        else
            fprintf('\tFalse');
        end
        pause(0.1);
    end
    % Check Actual Wavelength
    calllib('MIRcatSDK','MIRcatSDK_GetActualWW', actualWWPtr, unitsPtr, lightValidPtr);
    actualWW = actualWWPtr.value
    units = unitsPtr.value;
    fprintf('\tActual WW: %.3f \tunits: %u\n', actualWW, units);
end