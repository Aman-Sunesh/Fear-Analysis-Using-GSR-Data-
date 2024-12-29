%% nthOrderMedianFilter function to apply median filtering to GSR data
function filteredGSRData = nthOrderMedianFilter(N, GSRData)

    % Initialize filteredGSRData with the input GSRData
    filteredGSRData = GSRData;

    % Loop through each GSR data point
    for i = 1:length(GSRData{2})

        % Create a subset for median filtering
        subset = zeros(1,N);

        k = 1;

        % Iterate through the neighborhood of the current data point
        for j = -floor((N-1)/2):ceil((N-1)/2)
            index = i+j;
            index = max(1,min(index, length(GSRData{2})));
            subset(k) = GSRData{2}(index);
            k = k+1;
        end

        % Apply median filtering to the subset and update filteredGSRData
        filteredGSRData{2}(i) = median(subset);

    end
    

    % Plot the original and filtered GSR data

    figure;
    subplot(2,1,1);
    plot(GSRData{1},GSRData{2});
    title('Time vs GSR Values Before nth Order Median Filtration');
    xlabel('Time (s)');
    ylabel('GSR Values (uS)');

    subplot(2,1,2);
    plot(filteredGSRData{1},filteredGSRData{2}, 'r');
    title('Time vs Filtered GSR Values After nth Order Median Filtration');
    xlabel('Time (s)');
    ylabel('Filtered GSR Values (in uS)');

    % Save the figure as a jpg file
    saveas(gcf, 'nthOrderMedianFilter', 'jpg');

end





        
