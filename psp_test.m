function [result_test_latency,result_test_sd] = psp_test
    
    [ saccade_duration,latency,~,~]=fit_data;
    
    %Normal saccade duration
    n_saccade_duration = 40;
    sd_diff = (abs(n_saccade_duration - saccade_duration)/n_saccade_duration)*100;
    
    if (sd_diff>=0)&&(sd_diff<=14)
       result_test_sd = "0 OR 1";
       
    elseif (sd_diff<50)&&(sd_diff>=15)
       result_test_sd = "2";
       
    elseif (sd_diff<85)&&(sd_diff>=50)
        result_test_sd = "3";
        
    else
        result_test_sd = "4";
        
    end
    
    
    %Normal latency
    n_latency = 50;
    latency_diff = ((abs(n_latency - latency)/n_latency)*100);
    
    if (latency_diff>=0)&&(latency_diff<=14)
       result_test_latency = "0 OR 1";
       
    elseif (latency_diff<50)&&(latency_diff>=15)
       result_test_latency = "2";
       
    elseif (latency_diff<85)&&(latency_diff>=50)
        result_test_latency = "3";
        
    else
        result_test_latency = "4";
        
    end
    

end