%% normalizeGSRSignal function to normalize GSR data
function normalizedData = normalizeGSRSignal(GSRData)

    % normalizeGSRSignal function to normalize GSR data
    normalizedData = GSRData;

    % Iterate through each data point in GSRData
    for i = 1:length(GSRData{2})
        minGSR = min(GSRData{2});
        maxGSR = max(GSRData{2});

        % Normalize the GSR value using the min-max normalization formula
        normalizedGSR = ((GSRData{2}(i) - minGSR) / (maxGSR - minGSR))* 100;

        % Update the normalized GSR value in the normalizedData array
        normalizedData{2}(i) = normalizedGSR;
    end
 
    % Plot the original and normalized GSR data

    figure;
    subplot(2,1,1);
    plot(GSRData{1},GSRData{2});
    title('Time vs GSR Values Before Normalization');
    xlabel('Time (s)');
    ylabel('GSR Values (uS)');

    subplot(2,1,2);
    plot(normalizedData{1},normalizedData{2}, 'r');
    title('Time vs Filtered GSR Values After Normalization');
    xlabel('Time (s)');
    ylabel('Filtered GSR Values (in uS)');

    % Save the figure as a jpg file
    saveas(gcf, 'Normalised', 'jpg');

end

