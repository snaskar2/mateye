function [test_start_time,time_red_h_test ,horizontal_test_ending_time]=horizontal_saccade_test
    
%Set the window properties
    f = figure("Name", "Horizontal Saccade test"); % horizontal calibration
    f.Position = [0 300 1366 350]; % left bottom width height
       
        x = [1 2 3];
        z = NaN;
        y = [z z z];
        plot(x,y);
        set(gca,'XColor', 'none','YColor','none');
        xlim([1,3]);
        pause(1)
        hold on;
        
        test_start_time = datetime("now"); 
        i = 1;
        j = 1;
        time_red_h_test = zeros(16);  %time red horizontal test twice because we record when the dot appears and after 1 s it leaves 
        while i < 9;
            k = (-1)^i;
            if k<0
                y = [1 z z];
                plot_1=plot(x,y,"o",'MarkerSize',20,'MarkerEdgeColor','red', 'MarkerFaceColor',[1 0 0]);
                time_red_h_test(j) = seconds(datetime("now")  - test_start_time);
                set(gca,'XColor', 'none','YColor','none');
                pause(1);
                y = [z z z];
                i = i+1;
                set(plot_1,'Visible','off')
                time_red_h_test(j+1) = seconds(datetime("now")  - test_start_time);
                j = j+2;
          
            else
                y = [z z 1];
                plot_2=plot(x,y,"o",'MarkerSize',20,'MarkerEdgeColor','red', 'MarkerFaceColor',[1 0 0]);
                time_red_h_test(j) = seconds(datetime("now")  - test_start_time);
                set(gca,'XColor', 'none','YColor','none');
                pause(1);
                y = [z z z];
                i = i+1;
                set(plot_2,"visible","off");
                time_red_h_test(j+1) = seconds(datetime("now")  - test_start_time);
                j = j+2;
            end
       
        end
        hold off;
        horizontal_test_ending_time = seconds(datetime("now")  - test_start_time);;
        close;
    end
    
    
    
