% Phase 2 Feature Extraction 
clc
clear all

% path of the folder
folderPath = 'C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data';

Result = strcat(folderPath,'\Phase1');
%Path to Myo Data
myoData = strcat(folderPath,'\MyoData');
% where the Min files will be saved
output1 = strcat(folderPath,'\Phase2\Mean');
mkdir(output1);
userList = ls(Result);

userList = userList(3:end,:);

%Converts it character vectors
userList = cellstr(userList);
userNums = ls(myoData);
userNums = userNums(3:end,:);


%User Loop 
for i = 1 : size(userNums, 1)
    userNotEatMean_data = [];
    userEatMean_data = [];
   %%% % eating data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    userData = userList(contains(userList,userNums(i,:))); 
    userEat = userData(contains(userData,'EachUser_Eat'));
    % Load  .mat files
    load(strcat(Result,'\',userEat{1}));

   for k = 1 : size(User_Eat_Data, 1)
       % Calculation along X - Axis
       userEatMean = mean(User_Eat_Data(k,1:8));
       userEatMean_data = [userEatMean_data;userEatMean];
   end
   
 
    % Save data
    save(fullfile(output1, strcat(userNums(i,:),'_','userEatMean_data.mat')),'userEatMean_data');

    % %%%%%%%%%%%%%%%%%%%%% non-eating data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    userNotEat = userData(contains(userData,'EachUser_NotEat'));
    % Load .mat files
    load(strcat(Result,'\',userNotEat{1}));
   for k = 1 : size(User_NotEat_Data, 1)
       userNotEatMean = mean(User_NotEat_Data(k,1:8));
       userNotEatMean_data = [userNotEatMean_data;userNotEatMean];

   end
    % Save
    save(fullfile(output1, strcat(userNums(i,:),'_','userNotEatMean_data.mat')),'userNotEatMean_data');
    
end
display('Computation Done')