function [isKeySwitchSet] =  MIRcatInitScan()
% Scan Initialization Procedure
%
% These are the basic steps to follow before beginning tuning the laser 
% or beginning a scan. These steps MUST be executed before tuning or 
% scanning or else the system will raise errors.
    global MIRcatSDK_RET_SUCCESS;
    if ~libisloaded('MIRcatSDK') error('MIRcatSDK not loaded!'); end
    %step 1 is moved to:
    %MIRcatGetNumQCL()
    %Step 2 is moved to:
    %MIRcatCheckInterlock()
    % Step 3: Check for Key Switch Status is moved to:
    %MIRcatCheckKey()
    % Step 4: Arm the laser moved together with step 5, to:
    % Step 5: Wait for TECs to arrive at safe operating temperature
    %MIRcatArmLaser()

end