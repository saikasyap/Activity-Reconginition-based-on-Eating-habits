% Phase 2 Feature Extraction 
clc
clear all

% path of the folder
folderPath = 'C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data';

Result = strcat(folderPath,'\Phase1');
Combined = strcat(folderPath,'\Combine\Phase1');
%Path to Myo Data
myoData = strcat(folderPath,'\MyoData');

% Path where Max files will be saved
output1 = strcat(folderPath,'\Phase2\RMS');
mkdir(output1);

userList = ls(Result);

userList = userList(3:end,:);

%Converts it character vectors
userList = cellstr(userList);
userNums = ls(myoData);
userNums = userNums(3:end,:);

%User Loop 
for i = 1 : size(userNums, 1)
    userNotEatRms_data = [];
    userEatRms_data = [];
   %%% % eating data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    userData = userList(contains(userList,userNums(i,:))); 
    userEat = userData(contains(userData,'EachUser_Eat'));
    % Load  .mat files
    load(strcat(Result,'\',userEat{1}));

   for k = 1 : size(User_Eat_Data, 1)
       % Calculation along X - Axis
       userEatRms = rms(User_Eat_Data(k,1:8));
       userEatRms_data = [userEatRms_data;userEatRms];
   end
   
 
    % Save data
    save(fullfile(output1, strcat(userNums(i,:),'_','userEatRms_data.mat')),'userEatRms_data');

    % %%%%%%%%%%%%%%%%%%%%% non-eating data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    userNotEat = userData(contains(userData,'EachUser_NotEat'));
    % Load .mat files
    load(strcat(Result,'\',userNotEat{1}));
   for k = 1 : size(User_NotEat_Data, 1)
       userNotEatRms = rms(User_NotEat_Data(k,1:8));
       userNotEatRms_data = [userNotEatRms_data;userNotEatRms];

   end
    % Save
    save(fullfile(output1, strcat(userNums(i,:),'_','userNotEatRms_data.mat')),'userNotEatRms_data');
    
end
display('Computation Done')