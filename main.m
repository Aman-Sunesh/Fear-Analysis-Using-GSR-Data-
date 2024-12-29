%% Main function to process GSR data and calculate Fear Index
function main
    % Declare and Initialize input parameters
    filename = input("Enter the name of the file: ", 's');
    medianOrder = input("Enter the value of order for median filter: ");
    N_Order = input("Enter the order for nth order median filter: ");
    Fp = input ("Enter the value of passband frequency for low-pass filter: ");

    
    % Load GSR data from file
    GSRData = loadGSRData(filename);

    % Apply filters to the GSR data
    filteredGSRData = NPointMovingAvgFilter(N_Order, lowPassFilter(Fp, nthOrderMedianFilter(medianOrder, GSRData)));
    
    % Normalize the filtered GSR data
    normalizedGSRData = normalizeGSRSignal(filteredGSRData);
    
    % Determine features about the GSR signal
    F = GSRFeatures(normalizedGSRData);
    
    % Calculate Fear Index based on the extracted features
    FearIndex = calcFearIndex(F);
    
    % Calculate Fear Index based on the extracted features
    fprintf('The fear index is: %.2f \n', FearIndex)
end
