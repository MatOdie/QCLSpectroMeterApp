function [isCWallowed, maxCWcurrent, cwFilters] = MIRcatGetCWsettings(QCL_id)
    if ~libisloaded('MIRcatSDK') error('MIRcatSDK not loaded!'); end
    QCL = uint8(QCL_id);
    isCWallowed = false;
    maxCWcurrent = uint16(0);
    cwFilters = false;
    CWallowedPtr = libpointer('boolPtr', isCWallowed);
    ret = calllib('MIRcatSDK','MIRcatSDK_isCwAllowed', QCL, CWallowedPtr);
    isCWallowed = CWallowedPtr.value;
    if(isCWallowed)
        maxCWcurrentPtr = libpointer('uint16Ptr',maxCWcurrent);
        ret = calllib('MIRcatSDK','MIRcatSDK_GetQCLMaxCwCurrent', QCL, maxCWcurrentPtr);
        maxCWcurrent = maxCWcurrentPtr.value;
        cwFiltersPtr = libpointer('boolPtr',cwFilters);
        ret = calllib('MIRcatSDK','MIRcatSDK_areCwFiltersInstalled', QCL, cwFiltersPtr);
        cwFilters = cwFiltersPtr.value;
    end
    

end