%% NPointMovingAvgFilter function to apply N-Point Moving Average filtering to GSR data
function filteredGSRData = NPointMovingAvgFilter(N, GSRData)

    % Initialize filteredGSRData with the input GSRData
    filteredGSRData = GSRData;

    % Iterate through each data point in GSRData
    for i = 1:length(GSRData{2})
        
        % Initialize a subset array to store N data points for averaging
        subset = zeros(1,N);

        % Initialize index variables for creating the subset
        k = 1;

        % Create the subset based on the specified window size N
        for j = -floor((N-1)/2):ceil((N-1)/2)
            index = i+j;
            index = max(1,min(index, length(GSRData{2})));
            subset(k) = GSRData{2}(index);
            k = k+1;
        end

        % Replace the current data point with the mean of the subset
        filteredGSRData{2}(i) = mean(subset);
    end

    % Plot the original and filtered GSR data

    figure;
    subplot(2,1,1);
    plot(GSRData{1},GSRData{2});
    title('Time vs GSR Values Before Applying N-Point Moving Average Filtration');
    xlabel('Time (s)');
    ylabel('GSR Values (uS)');

    subplot(2,1,2);
    plot(filteredGSRData{1},filteredGSRData{2}, 'r');
    title('Time vs Filtered GSR Values After Applying N-Point Moving Average Filtration');
    xlabel('Time (s)');
    ylabel('Filtered GSR Values (in uS)');

    % Save the figure as a jpg file
    saveas(gcf, 'NPointMovingAvgFilter', 'jpg');
end


    