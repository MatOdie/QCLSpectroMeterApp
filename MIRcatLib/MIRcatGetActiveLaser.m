function qcl = MIRcatGetActiveLaser()

    if ~libisloaded('MIRcatSDK') error('MIRcatSDK not loaded!'); end
    fprintf('========================================================\n');
    fprintf('Test: Which QCL is active? ... ');
    qcl = uint8(0);
    qclPtr = libpointer('uint8Ptr',qcl);
    calllib('MIRcatSDK','MIRcatSDK_GetActiveQcl', qclPtr);
    qcl = qclPtr.value;
    fprintf(' %d\n', qcl);
    
end