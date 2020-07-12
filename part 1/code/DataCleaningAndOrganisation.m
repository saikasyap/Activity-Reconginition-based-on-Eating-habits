clc
clear all
% MyoData folder path
MyoData = 'C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\MyoData';
%  groundTruth folder path
groundTruth = 'C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\groundTruth';

Result = 'C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase1';
Combined = 'C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Combine\Phase1';
mkdir(Combined)
list = ls(groundTruth);
mkdir(Result);
Spoon_Eat_Data = [];
Spoon_NotEat_Data = [];
Fork_Eat_Data = [];
Fork_NotEat_Data = [];

% Removes the '.' and '..' directories from list
for i = 3 : size(list, 1)
    User_Eat_Data = [];
    
    User_NotEat_Data = [];

    % list the folder content
    % Fork Path
    path_fork = groundTruth + "\" + list(i, :) + "\" + "fork";
    folder_list = ls(path_fork);
    
    StartEnd_Fork = dlmread(path_fork + "\" + strtrim(folder_list(3, :)));
    
    % Spoon Path
    path_spoon = groundTruth + "\" + list(i, :) + "\" + "spoon";
    folder_list = ls(path_spoon);
    StartEnd_Spoon = dlmread(path_spoon + "\" + strtrim(folder_list(3, :)));
    
    list = ls(MyoData);
    % Fork Path
    path_fork = MyoData + "\" + list(i, :) + "\" + "fork";
    
    % Spoon Path
    path_spoon = MyoData + "\" + list(i, :) + "\" + "spoon";
    
    
    %%%%%%%% FORK%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % list the content of fork folder
    folder_list = ls(path_fork);
    
    for j = 3 : size(folder_list, 1)  % for all the files in fork folder, ...
        if contains(folder_list(j, :), "EMG") % find the file that contents EMG substring
            EMG = dlmread(path_fork + "\" + strtrim(folder_list(j, :))); % save the content of EMG file in a matrix
        end
    end 
    Fork_Eat = [];
    %  emg data
    for j = 1 : size(StartEnd_Fork, 1)
 
        start_frame = StartEnd_Fork(j, 1);
        end_frame = StartEnd_Fork(j, 2);
        start_time_row = floor(start_frame/30)*100; %  as advised
        end_time_row = floor(end_frame/30)*100;
        
        % find the rows in between start and end point time
        for k = 1 : size(EMG, 1)
            if (k >=start_time_row && k<= end_time_row)
                ind_Eat_EMG = start_time_row:end_time_row;
            end
        end
        Fork_Eat = [Fork_Eat; EMG(ind_Eat_EMG, :)];
        

    end
    Fork_Eat = Fork_Eat(1:2:end, 2:end);
    
    disp(size(Fork_Eat))

    % others as non-eat data
    Fork_NotEat = setdiff(EMG(:, 2:end), Fork_Eat, 'rows'); 
    Fork_NotEat = Fork_NotEat(1:2:end, 1:end);
    %Saving files for individual users
   % save(fullfile(Result,list(i, :)+"_"+'Fork_Eat.mat'), 'Fork_Eat');
    %save(fullfile(Result,list(i, :)+"_"+'Fork_NotEat.mat'), 'Fork_NotEat');
    %%%%%%%SPOON%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % as same as Fork:
    % list the content of spoon folder
    folder_list = ls(path_spoon);


    for j = 3 : size(folder_list, 1)  % for all the files in spoon folder 
        if contains(folder_list(j, :), "EMG") %  the file that has EMG substring
            EMG = dlmread(path_spoon + "\" + strtrim(folder_list(j, :))); % save the EMG file
        end     
    end 
    Spoon_Eat = [];
    for j = 1 : size(StartEnd_Spoon, 1)
        start_frame = StartEnd_Spoon(j, 1);
        end_frame = StartEnd_Spoon(j, 2);
        start_time_row = floor(start_frame/30)*100;
        end_time_row = floor(end_frame/30)*100;
        for k = 1 : size(EMG, 1)
            if (k >=start_time_row && k<= end_time_row)
                ind_Eat_EMG = start_time_row:end_time_row;
            end
            
        end
        Spoon_Eat = [Spoon_Eat; EMG(ind_Eat_EMG, :)];

    end
    Spoon_Eat = Spoon_Eat(1:2:end, 2:end);
    disp(size(Spoon_Eat))
    Spoon_NotEat = setdiff(EMG(:, 2:end), Spoon_Eat, 'rows');
    Spoon_NotEat = Spoon_NotEat(1:2:end, 1:end);
    disp(size(Spoon_NotEat))

    % Saving files for individual users
   % save(fullfile(Result, list(i, :)+"_"+'Spoon_Eat.mat'), 'Spoon_Eat');
   % save(fullfile(Result, list(i, :)+"_"+'Spoon_NotEat.mat'), 'Spoon_NotEat');
    Spoon_Eat_Data = [Spoon_Eat_Data; Spoon_Eat];
    Spoon_NotEat_Data = [Spoon_NotEat_Data; Spoon_NotEat];
    Fork_Eat_Data = [Fork_Eat_Data; Fork_Eat];
    Fork_NotEat_Data = [Fork_NotEat_Data; Fork_NotEat];
    
    % For Each User : Two Files 
    User_Eat_Data = [Spoon_Eat; Fork_Eat];
    User_NotEat_Data = [Spoon_NotEat; Fork_NotEat];
    save(fullfile(Result, list(i, :)+"_"+'EachUser_Eat.mat'), 'User_Eat_Data');
    save(fullfile(Result, list(i, :)+"_"+'EachUser_NotEat.mat'), 'User_NotEat_Data');
    
    
    
    
end
% Combined Data for Fork EAt/ Noteat and spoon EAt/Not Eat
save(fullfile(Combined,+'All_Spoon_Eat_Data.mat'), 'Spoon_Eat_Data');
save(fullfile(Combined,+'All_Fork_Eat_Data.mat'), 'Fork_Eat_Data');
save(fullfile(Combined,+'All_Spoon_NotEat_Data.mat'), 'Spoon_NotEat_Data');
save(fullfile(Combined,+'All_Fork_NotEat_Data.mat'), 'Fork_NotEat_Data');


