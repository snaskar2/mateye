function [voltage_calibrated,red_ball_time, target_path, time_conv_fil,voltage_conv_fil, start_index,end_index,test_time]=post_processing(demo,demo1,test_start_time,horizontal_test_ending_time,time_red_h_test,m,c)
    
    %Convert input time and voltage into proper fotmat - input demo as time
    %and demo1 as voltage
    [time_conv,voltage_conv]=import_data_and_convert(demo,demo1);
    
    
    %Find start and end index
    start_index = find_out_start_index_from_long_data(time_conv,test_start_time);

    end_time = test_start_time + seconds(horizontal_test_ending_time);
    end_index = find_out_start_index_from_long_data(time_conv,end_time);
    
    %filter time and voltage data to include data during test
    time_conv_fil = time_conv(start_index:end_index);
    voltage_conv_fil = voltage_conv(start_index:end_index);
    
    %Calculate test time in milliseconds
    test_time = (second(time_conv_fil) - second(test_start_time)).*1000;
   
    %Calculate the path of the test
    figure('Name','Horizontal saccade test','NumberTitle','off');
    theta = atand(13.5/(2*25));
    z = theta + 45;
    z_neg = -theta + 45;
    target_path = [-theta -theta theta theta -theta -theta theta theta -theta -theta theta theta -theta -theta theta theta];
    time_red_h_test = time_red_h_test(:,1);
    red_ball_time = time_red_h_test.*1000;
    target_path_plotting = [z_neg z_neg z z  z_neg z_neg z z  z_neg z_neg z z  z_neg z_neg z z  ];
    plot(red_ball_time,target_path_plotting)
    hold on
    
    %Calibrate
    voltage_calibrated = (voltage_conv_fil.*m)+c;
    
    
    %Plot 
    
    plot(test_time, voltage_calibrated)
    xlabel("Time in ms");
    ylabel("Displacement in degrees");
    hold off
    %ylim = ([-20, 70]);
end