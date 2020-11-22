function [theta,m,c,mdl] = volt_to_ang_d(distance_to_screen,calib_data)
    
    theta = zeros(15); % this is the angular degrees 

    width = 27; %unit is cm
    di =  distance_to_screen;     % distance to screen unit in cm 
    wi_s = width/(2*7); %width of each segment in cm 
    %Theta is the angular degree (displacement)
    
    for i = 8:1:15
       theta(i) = atand((wi_s * (i-8))/di); 
    end
    
    for i = 1:7
       theta(i) = - theta(16-i); 
    end
    
    theta = theta(:,1);
    theta = theta.';
    
    
    %Now do linear regression - equation is Volatge = slope* theta +
    %intercept
    mdl = fitlm(theta,calib_data);
    table_of_coefficients = mdl.Coefficients;
    
    c = table2array(table_of_coefficients(1,1)); %Intercept
    m = table2array(table_of_coefficients(2,1)); %Slope
    
    estimated_voltage = (theta.*m) + c;
    f_2 = figure("Name", "Measured_vs_estimated_voltage");
    scatter(theta,calib_data);
    hold on;
    plot(theta,estimated_voltage);
    hold off;
    legend("Measured","Estimated");
    xlabel("Angular degrees ");
    ylabel("Voltage (mV)");
end