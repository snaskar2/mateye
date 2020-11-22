function [t_start,t_red,t_blue,calib_data]= horizontal_calibration(arduinoObj)

     
    
    %Connect with arduino
    %arduinoObj = serialport("COM3",115200); - u need to run this in line
    %separately in the terminal first
    %configureTerminator(arduinoObj,"CR/LF");
    %flush(arduinoObj);
    %arduinoObj = serialport("COM3", 115200);
    
    %Prepare userdata property to store arduino data
    arduinoObj.UserData = zeros(15);
    
    t_red = zeros(15); 
    t_start = datetime("now");
    %Set the window properties
    f = figure("Name", "Calibration"); % horizontal calibration
    f.Position = [1 300 1366 350]; % left bottom width height
    
    %Plot the stationary blue dot    
    t_1 = 0:14; % setting time for 1 axis        
    z = NaN;
    y_1 = [z z z z z z z 1 z z z z z z z ]; 
    plot(t_1,y_1,"o",'MarkerSize',10,'MarkerEdgeColor','blue', 'MarkerFaceColor',[0 0 1]) % Keep the blue one constant 
    t_blue = datetime("now");   
    set(gca,'XColor', 'none','YColor','none'); % Remove ticks and axes
    xlim([0,14]);
    pause(1)
    hold on
    
    %Plot the moving red dot   - going left  
    y_2 = [z z z z z z z z z z z z z z z ];
    for i = 7:-1:1
        y_2(i)=1;
        y_2(i+1)=z;
        plot_1 = plot(t_1,y_2,"o",'MarkerSize',10,'MarkerEdgeColor','red', 'MarkerFaceColor',[1 0 0]); % remove the semicolon to see the values changing 
        % Convert the string data to numeric type and save it in the UserData property of the serialport object.
        arduinoObj.UserData(i) = str2double(readline(arduinoObj));       
        t_red(i) = seconds(datetime("now")-t_start  );
        pause(1) 
        set(plot_1,'Visible','off')  
    end  
    
    %Plot the moving red dot   - going right 
    plot(t_1,y_1,"o",'MarkerSize',10,'MarkerEdgeColor','blue', 'MarkerFaceColor',[0 0 1]) % Keep the blue one constant 
    pause(1);
    y_3 = [z z z z z z z z z z z z z z z ];
    for i = 8:1:15
        y_3(i)=1;
        y_3(i-1)=z;
        plot_1 = plot(t_1,y_3,"o",'MarkerSize',10,'MarkerEdgeColor','red', 'MarkerFaceColor',[1 0 0]); % remove the semicolon to see the values changing 
        % Convert the string data to numeric type and save it in the UserData property of the serialport object.
        arduinoObj.UserData(i) = str2double(readline(arduinoObj));   
        t_red(i) = seconds(datetime("now") - t_start  );
        pause(1) 
        set(plot_1,'Visible','off')
        
    end  
        
    hold off
    close;
    t_red = t_red(:,1);
    t_red = t_red.';
    calib_data = (arduinoObj.UserData(:,1)).';
end