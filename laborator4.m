% the following program simulates the growth and decay of an island due to
% underwater volcano activity.
% (c) M. Patrascu

%---------------------------
% controls:
%---------------------------
% define the plot button
plotbutton = uicontrol('style', 'pushbutton', ...
    'string', 'Play.', ...
    'fontsize', 12, ...
    'position', [100, 400, 50, 20], ...
    'callback', 'run = 1;');

% define the stop button
erasebutton = uicontrol('style', 'pushbutton', ...
    'string', 'Stop.', ...
    'fontsize', 12, ...
    'position', [200, 400, 50, 20], ...
    'callback', 'freeze = 1;');

% define the quit button
quitbutton = uicontrol('style', 'pushbutton', ...
    'string', 'Quit.', ...
    'fontsize', 12, ...
    'position', [300, 400, 50, 20], ...
    'callback', 'stop = 1;close;');

number = uicontrol('style', 'text', ...
    'string', '1', ...
    'fontsize', 12, ...
    'position', [20, 400, 50, 20]);

%---------------------------
load('init.mat');
a = init;
var = a;
b = a;
lava = zeros(100);
i = 0;

im = image(a);
colormap jet

%Main loop
stop = 0;     % Wait for a quit button push
run = 0;      % Wait for play 
freeze = 0;   % Wait for freeze

while (stop == 0) 
    if (run == 1)
        i = i + 1; % As time passes...
        if (i <= 250)
            for j = 2 : 99
                for k = 2 : 99
                    %whenever a vulcano erupts
                    ics = (a(j, k + 1) >= a(j, k)) + (a(j, k - 1) >= a(j, k)) + ...
                          (a(j - 1, k) >= a(j, k)) + (a(j + 1, k) >= a(j, k)) + ...
                          (a(j + 1, k + 1) >= a(j, k)) + (a(j - 1, k - 1) >= a(j, k)) + ...
                          (a(j - 1, k + 1) >= a(j, k)) + (a(j + 1, k - 1) >= a(j, k));
                    ics = ics >= 8;
                    
                    % first see if there's any lava
                    lava = max([a(j, k + 1); a(j, k - 1); a(j - 1, k); a(j + 1, k);
                                a(j + 1, k + 1); a(j - 1, k - 1); a(j - 1, k + 1);
                                a(j + 1, k - 1)]);
                    
                    % the lava will now create mountains
                    var(j, k) = ics* (lava - a(j, k)) + a(j, k);
                end
            end
            
            % humans may interact, or mother nature, or some other forces
            % unkown to this application
            var = var + randn(100)/100;
            
        elseif (i <= 600)         % after a while
            for j = 2 : 99
                for k = 2 : 99
                    % vulcano dies and the mountains start to corrode
                    % decay rules
                    ics = (a(j, k + 1) >= a(j, k)) + (a(j, k - 1) >= a(j, k)) + ...
                          (a(j - 1, k) >= a(j, k)) + (a(j + 1, k) >= a(j, k)) + ...
                          (a(j + 1, k + 1) >= a(j, k)) + (a(j - 1, k - 1) >= a(j, k)) + ...
                          (a(j - 1, k + 1) >= a(j, k)) + (a(j + 1, k - 1) >= a(j, k));
                      
                    ics = (ics >= 8) & (a(j, k) >= 15);
                      
                    lavaMax = max([a(j, k + 1); a(j, k - 1); a(j - 1, k); 
                                   a(j + 1, k); a(j + 1, k + 1); a(j - 1, k - 1);
                                   a(j - 1, k + 1); a(j + 1, k - 1)]);
                            
                    lavaMin = min([a(j, k + 1); a(j, k - 1); a(j - 1, k); 
                                   a(j + 1, k); a(j + 1, k + 1); a(j - 1, k - 1);
                                   a(j - 1, k + 1); a(j + 1, k - 1)]);
                               
                    media = (lavaMax + lavaMin) / 2;
                    
                    if (lavaMax > 60)
                        var(j, k) = ics* (media - a(j, k)) + a(j, k)* 0.955;
                    end                        
                end
            end
            
            % humans may interact, or mother nature, or some other forces
            % unkown to this application
            var = var - randn(100)/100;
        else
            var = var;
            freeze = 1;
        end
        
        a = var;
        set(im, 'cdata', a)
        % use this if simulation runs too fast on your system
        % change pause length accordingly
        % pause(.01)
        
        % update the step number for display
        stepnumber = 1 + str2num(get(number, 'string'));
        set(number, 'string', num2str(stepnumber))
    end
    if (freeze == 1)
        run = 0;
        freeze = 0;
    end
    drawnow
end

                
                

                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                


















