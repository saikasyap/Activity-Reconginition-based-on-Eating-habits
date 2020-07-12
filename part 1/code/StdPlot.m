clc
clear all

% path of the folder
folderPath = 'C:\Users\saika\Desktop\EatingProject\Data_Stding_Assign1Data';

Result = strcat(folderPath,'\Phase1');
Combined = strcat(folderPath,'\Combine\Phase1');
%Path to Myo Data
myoData = strcat(folderPath,'\MyoData');

% Path Std files
StdData = strcat(folderPath,'\Phase2\Std');
phase3DataPathEat = strcat(folderPath,'\Phase_3_Data\Eat');
phase3DataPathNotEat = strcat(folderPath,'\Phase_3_Data\Not_Eat');
outputPath = strcat(folderPath,'\Phase_2_Data\Graphs\Std');
mkdir(outputPath);
mkdir(phase3DataPathEat);
mkdir(phase3DataPathNotEat);

userList = ls(Result);

userList = userList(3:end,:);

%Converts it character vectors
userList = cellstr(userList);
userNums = ls(myoData);
userNums = userNums(3:end,:);

subplot(2,1,1)
StdEat= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Std\user30_userEatStd_data.mat');
StdNotEat= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Std\user30_userNotEatStd_data.mat');

x = 1:50:2000;

plot(StdEat.userEatStd_data(x));
title('Std feature Plot for user 30')

hold on
plot(StdNotEat.userNotEatStd_data(x));
legend('Eating', 'Not Eating')
xlabel('Sample numbers')
ylabel('Std Values')
xticklabels(x-1)
subplot(2,1,2)
StdEat1= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Std\user40_userEatStd_data.mat');
StdNotEat2= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Std\user40_userNotEatStd_data.mat');

x = 1:50:2000;

plot(StdEat1.userEatStd_data(x));
title('Std feature Plot for user 40')

hold on
plot(StdNotEat2.userNotEatStd_data(x));
legend('Eating', 'Not Eating')
xlabel('Sample numbers')
ylabel('Std Values')
xticklabels(x-1)