% New Features obtained by multiplying 
clc
clear all

% path of the folder
folderPath = 'C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data';

Result = strcat(folderPath,'\Phase1');
Combined = strcat(folderPath,'\Combine\Phase1');
%Path to Myo Data
myoData = strcat(folderPath,'\MyoData');

% Path where Max files will be saved
output = strcat(folderPath,'\Assignment 2\Data\EachUser');
output1 = strcat(folderPath,'\Assignment 2\Data\pca');
output2 = strcat(folderPath,'\Assignment 2\Data\newFeatureSpace');

mkdir(output);
mkdir(output1);
mkdir(output2);
userList = ls(Result);

userList = userList(3:end,:);

%Converts it character vectors
userList = cellstr(userList);
userNums = ls(myoData);
userNums = userNums(3:end,:);


%User Loop 
for i = 1 : size(userNums, 1)
    UsersEat_Data = [];
    UsersNotEat_Data = [];
    UsersEat_Newmat = [];
    UsersNotEat_NewMat = [];
    userNotEatMax_data = [];
    userEatMax_data = [];
    userNotEatMean_data = [];
    userEatMean_data = [];
    userNotEatStd_data = [];
    userEatStd_data = [];
    userNotEatMin_data = [];
    userEatMin_data = [];
    userNotEatFft_data = [];
    userEatFft_data = [];
   %%% % eating data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    userData = userList(contains(userList,userNums(i,:))); 
    userEat = userData(contains(userData,'EachUser_Eat'));
    % Load  .mat files
    load(strcat(Result,'\',userEat{1}));

   for k = 1 : size(User_Eat_Data, 1)
       % Calculation along X - Axis
       userEatMax = max(User_Eat_Data(k,1:8));
       userEatMax_data = ([userEatMax_data;userEatMax]);
       userEatMean = mean(User_Eat_Data(k,1:8));
       userEatMean_data = ([userEatMean_data;userEatMean]);
       userEatMin = min(User_Eat_Data(k,1:8));
       userEatMin_data = ([userEatMin_data;userEatMin]);
       userEatStd = std(User_Eat_Data(k,1:8));
       userEatStd_data =([userEatStd_data;userEatStd]);
       userEatFft = var(abs(fft(User_Eat_Data(k,1:8))));
       userEatFft_data = [userEatFft_data;userEatFft];
       
       
   end
          UsersEat_Data = normalize([userEatMax_data,userEatMean_data,userEatMin_data,userEatStd_data, userEatFft_data]);

 
    % Save data
    save(fullfile(output, strcat(userNums(i,:),'_','UsersEat_data.mat')),'UsersEat_Data');

    % %%%%%%%%%%%%%%%%%%%%% non-eating data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    userNotEat = userData(contains(userData,'EachUser_NotEat'));
    % Load .mat files
    load(strcat(Result,'\',userNotEat{1}));
   for k = 1 : size(User_NotEat_Data, 1)
       userNotEatMax = max(User_NotEat_Data(k,1:8));
       userNotEatMax_data = [userNotEatMax_data;userNotEatMax];
       userNotEatMean = mean(User_NotEat_Data(k,1:8));
       userNotEatMean_data =[userNotEatMean_data;userNotEatMean];
       userNotEatMin = min(User_NotEat_Data(k,1:8));
       userNotEatMin_data = [userNotEatMin_data;userNotEatMin];
       userNotEatStd = std(User_NotEat_Data(k,1:8));
       userNotEatStd_data = [userNotEatStd_data;userNotEatStd];
       userNotEatFft = var(abs(fft((User_NotEat_Data(k,1:8)))));
       userNotEatFft_data = [userNotEatFft_data;userNotEatFft];
       
   end
          UsersNotEat_Data =normalize([userNotEatMax_data,userNotEatMean_data,userNotEatMin_data,userNotEatStd_data,userNotEatFft_data]);
   

    % Save
    save(fullfile(output, strcat(userNums(i,:),'_','UsersNotEat_Data.mat')),'UsersNotEat_Data');
    % Creating New Feature Matrix
    UsersEat_PCA = pca(UsersEat_Data);
    UsersNotEat_PCA = pca( UsersNotEat_Data);
    UsersEat_Newmat = UsersEat_Data * UsersEat_PCA(:,1:5);
    UsersNotEat_Newmat = UsersNotEat_Data * UsersNotEat_PCA(:,1:5);

    save(fullfile(output1, strcat(userNums(i,:),'_','UsersEat_PCA.mat')),'UsersEat_PCA');
    save(fullfile(output1, strcat(userNums(i,:),'_','UsersNotEat_PCA.mat')),'UsersNotEat_PCA');

    save(fullfile(output2, strcat(userNums(i,:),'_','UsersEat_Newmat.mat')),'UsersEat_Newmat');
    save(fullfile(output2, strcat(userNums(i,:),'_','UsersNotEat_Newmat.mat')),'UsersNotEat_Newmat');


end
display('Computation Done')