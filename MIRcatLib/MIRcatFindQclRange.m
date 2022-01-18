function [minWL, maxWL, units] = MIRcatFindQclRange(q)
    global MIRcatSDK_RET_SUCCESS;
    %[uint32, singlePtr, singlePtr, uint8Ptr] MIRcatSDK_GetQclTuningRange(uint8, singlePtr, singlePtr, uint8Ptr)
    if ~libisloaded('MIRcatSDK') error('MIRcatSDK not loaded!'); end
    fprintf('========================================================\n');
    fprintf('Quering QCL range ... ');
    
    % Create your variables and Pointers if necessary.
    qcl = uint8(q) %in between 1-2 for our QCL
    minWL = single(1);
    minWLPtr = libpointer('singlePtr', minWL);
    maxWL = single(1);
    maxWLPtr = libpointer('singlePtr', maxWL);
    units = uint8(0);
    unitsPtr = libpointer('uint8Ptr', units);
    % Call the function
    ret = calllib('MIRcatSDK','MIRcatSDK_GetQclTuningRange', qcl, minWLPtr, maxWLPtr, unitsPtr);
    % Check to see if function call was Successful
    if MIRcatSDK_RET_SUCCESS == ret
        fprintf('Successful\n' );
    else
        fprintf('Failed\n' );
        % If the operation fails, unload the library and raise an error.
        %unloadlibrary MIRcatSDK;
        %error('Error! Code: %d', ret);
    end
    % Convert the pointer values to the original variables.
    units = unitsPtr.value;
    minWL = minWLPtr.value;
    maxWL = maxWLPtr.value;
    
end