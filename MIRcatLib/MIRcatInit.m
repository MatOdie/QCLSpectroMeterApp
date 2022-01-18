function success = MIRcatInit(hfolder)
    %hfolder='C:\Users\mathieu\work\people\Koen\mircat QCL laser\SDK\';
    hfile=[hfolder,'MIRcatSDK.h']; %ensure you are in the SDK folder
    hdll=[hfolder,'x64\MIRcatSDK'];
    success = true;

    if ~isfile(hfile)
        error('hfile not found!\n');
    else
        fprintf('hfile found!\n');
    end

    if ~libisloaded('MIRcatSDK')
        [notfound,warnings]=loadlibrary(hdll,hfile);
        if(~isempty(notfound))
            success = false;
            fprintf(warnings);
        end
        %loadlibrary x64\MIRcatSDK.dll MIRcatSDK.h
        %load('MIRcatSDKconstants.mat');% Load the constants from the SDK
    else
        fprintf('MirCat library seems already loaded.\n');
    end
end