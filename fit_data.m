function [ saccade_duration,latency,A,vp]=fit_data

%This is my modified version from 
%W. Dai, I. Selesnick, J.-R. Rizzo, J. Rucker and T. Hudson.
%'A parametric model for saccadic eye movement.'
%IEEE Signal Processing in Medicine and Biology Symposium (SPMB), December 2016.
%DOI: 10.1109/SPMB.2016.7846860.





% Example_5.m
%
% Fitting the parametric saccade model to real saccade waveform data.

    Fs = 500;                   % sampling rate (samples/sec)
    t = (0:1/Fs:0.1)';          % time axis (sec)



% Load 14.4-degree saccade waveforms
    pos_sacc3 = load('data/data3pos.txt');
    

% Parametric saccade model
    p3 = [426.5; 2.9; 14.393; 0.0331; -0.025];
    model_pos3 = saccade_model(t, p3(1), p3(2), p3(3), p3(4), p3(5));
    model_vel3 = calculateV(model_pos3);

    f = figure("Name","Model fitting", "NumberTitle","off");

    subplot(1,2,1)
    h1 = plot(1000*t, pos_sacc3, 'k');
    hold on
    h2 = plot(1000*t, model_pos3, 'r', 'LineWidth', 1.5);
    
    ylim([-3 19])
    xlabel('Time (ms)')
    ylabel('Angle (deg)')
    %axnote('14.4^o saccades')
    legend([h1(1) h2], 'data', 'model', 'location', 'SE')
    subplot(1,2,2)
    h1 = plot(1000*t, model_vel3, 'r', 'LineWidth', 1.5);
    
    ylim([-100 600])
    xlabel('Time (ms)')
    ylabel('Velocity (deg/s)')
    
    
    

    orient tall
    
    %Calculate peak velocity 
    vp = p3(1)*(1-exp(-p3(3)/p3(2)));    
    %Calculate latency
    latency = (p3(4)-t(1))*1000; %in ms           
    %Amplitude 
    A = p3(3);
    
    %Acceleration
    acce = calculateV(model_vel3);
    figure("Name","Acceleration","NumberTitle","off"); 
    plot(1000*t, acce, 'r', 'LineWidth', 1.5);
    legend('velocity', 'acceleration')
    
    %Find local minima
    TF = islocalmin(acce);
    local_minima = acce(TF);    
    %Find end_time
    end_index = find(acce==local_minima);
    end_time = t(end_index);    
    %Duration 
    saccade_duration = (end_time - p3(4))*1000; %ms
    



end