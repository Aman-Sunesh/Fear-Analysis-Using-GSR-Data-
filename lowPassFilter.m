%% lowPassFilter function to apply low-pass filtering to GSR data
function filteredGSRData = lowPassFilter(Fp, GSRData)

    % Initialize filteredGSRData with the input GSRData
    filteredGSRData = GSRData;

    % Calculate the time differences between consecutive data points
    timeDif = diff(GSRData{1});

    % Calculate the mean window size based on the specified passband frequency Fp
    mWS = 1/Fp; %where mWS represents the mean window size

    % Calculate the number of points for the moving mean window
    meanWindowPoints = round(mWS / median(timeDif));

    % Apply moving mean (low-pass) filtering to GSR data
    filteredGSRData{2} = smoothdata(GSRData{2}, 'movmean', meanWindowPoints);


    % Plot the original and filtered GSR data
    
    figure
    subplot(2,1,1);
    plot(GSRData{1},GSRData{2});
    title('Time vs GSR Values Before Low Pass Filtration');
    xlabel('Time (s)');
    ylabel('GSR Values (uS)');

    subplot(2,1,2);
    plot(filteredGSRData{1},filteredGSRData{2}, 'r');
    title('Time vs Filtered GSR Values After Low Pass Filtration');
    xlabel('Time (s)');
    ylabel('Filtered GSR Values (in uS)');

    % Save the figure as a jpg file
    saveas(gcf, 'LowpassFilter', 'jpg');

end

