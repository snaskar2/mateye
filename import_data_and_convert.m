function [time_conv,voltage_conv]=import_data_and_convert(time,voltage)

%time is in numeric matrix without header 
% voltage is in string array format without header

%outputs numeric voltage and datetime time

    

    time_without_empty = time(~strcmp(time,"")); %remove blank rows
    voltage_conv = rmmissing(voltage);
    
    
    time_conv=datetime(time_without_empty, 'InputFormat',"HH:mm:ss.SSS");
    
    %time_conv = datetime(time_without_empty, 'InputFormat', 'HH:mm:ss.SSS');
    %test_start_time_5 = datetime(datestr(test_start_time, 'HH:MM:SS.FFF'),'InputFormat',"HH:mm:ss.SSS");

end