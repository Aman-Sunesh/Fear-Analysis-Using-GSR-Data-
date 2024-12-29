%% GSRFeatures function to extract features from GSR data
function F = GSRFeatures(GSRData)

    % Feature 1: Mean of GSR values
    F(1) = mean(GSRData{2});

    % Feature 2: Variance of GSR values
    F(2) = var(GSRData{2});

    % Identify local maxima and minima in GSR data
    max_peak = islocalmax(GSRData{2});
    min_peak = islocalmin(GSRData{2});

    % Extract maxima and minima values along with corresponding times
    maxima = GSRData{2}(max_peak);
    minima = GSRData{2}(min_peak);
    maxTime = GSRData{1}(max_peak);
    minTime = GSRData{1}(min_peak);

    % Trough-Peak seperation threshold calculated using GSR_FEAR.csv data
    %trough-peak seperation values at 90% percentile
    tr_pk_sep_prctl = 16.305;

    % Initialize variables for amplitude, rise time, and cumulative features
    size = length(maxima);
    amplitude = zeros(1,size);
    riseTime = zeros(1,size);
    F(3) = 0;
    F(5) = 0;


    % Initialize variables for amplitude, rise time, and cumulative features
    for i = 1:size
        index = find(minTime < maxTime(i), 1, 'last');
        
        if ~isempty(index)

            % Initialize variables for amplitude, rise time, and cumulative features
            if ((maxima(i) - minima(index)) > tr_pk_sep_prctl)

                amplitude(i) = maxima(i);

                riseTime(i) = maxTime(i) - minTime(index);

                % Feature 3: GSR Peak Rise Time Sum
                F(3) = F(3) + riseTime(i);

                % Feature 5: GSR Peak Energy Sum
                F(5) = F(5) + (0.5 * amplitude(i) * riseTime(i));
            end
        end
    end


    % Feature 4: GSR Peak Amplitude Sum
    F(4) = sum(amplitude);
    
    % Feature 6: Amplitude of the highest skin conductance response
    [F(6), index] = max(amplitude);

    % Feature 7: Rise time of the highest skin conductance response
    F(7) = riseTime(index);

    % Feature 8: Number of non-zero amplitudes
    F(8) = nnz(amplitude);
    
    % Feature 9: Mean power of GSR signal
    F(9) = mean(GSRData{2}.^2);

    % Calculate differences and bandwidth for Feature 10
    D_GSR = diff(GSRData{2});

    D_GSR_2 = sum(D_GSR.^2);

    sumGSR2 = sum(GSRData{2}.^2);

    GSR_Bandwith = (1/(2*pi)) * sqrt(D_GSR_2/sumGSR2);

    % Feature 10: GSR Bandwidth
    F(10) = GSR_Bandwith;

end