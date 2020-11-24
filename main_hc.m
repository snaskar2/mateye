function [m,c]=main_hc(ds)
%This function returns does the entire horizontal calibration

%output - 
%   1. m : slope
%   2. c - intercept - required for calibration

    clear;
    close all;
    arduinoObj = serialport("COM3",115200);
    distance_to_screen = ds; %cm 
    
    [~,~,~,calib_data]= horizontal_calibration(arduinoObj); %This does the horizontal calibration
    [~,m,c,~] = volt_to_ang_d(distance_to_screen,calib_data); %This fits data to linear regression model and outputs slope and intercept

    clear arduinoObj;
end