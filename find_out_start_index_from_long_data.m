function start_index = find_out_start_index_from_long_data(time_conv,test_start_time)
    j = "k";
    for i = 1: length(time_conv)
        s = time_conv(i);
        if (hour(test_start_time)==hour(s)) && (minute(test_start_time)==minute(s)) && (second(test_start_time)==second(s))
           j = i; 
           break 
        end
        
    end
    start_index = j;

end 