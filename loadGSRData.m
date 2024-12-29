%% loadGSRData function to read GSR data from a file and process it
function GSRData  = loadGSRData(filename)
    % Open the file for reading
    fid = fopen(filename,'r');
    
    % Check if the file open operation is successful
    if (fid == -1)
        error('Error! File open not successful');
    end

    %Reads the file header
    fscanf(fid, '%s', 2);
    
    % Read data from the file using textscan
    data = textscan(fid, '%{mm:ss:SSS}D %f', 'Delimiter',',');
    
    closeresult = fclose(fid);
    
    % Check if the file close operation is unsuccessful
    if closeresult ~= 0
        disp('File close not successful');
    end

    %Converting time to seconds by offsetting all values by the first time
    %reading
    time = seconds(data{1} - data{1}(1));

    % Organize the data into a cell array containing time and GSR values
    GSRData = {time,data{2}};
end