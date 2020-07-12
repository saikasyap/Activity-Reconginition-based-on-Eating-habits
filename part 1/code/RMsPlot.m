clc
clear all

% path of the folder
folderPath = 'C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data';

Result = strcat(folderPath,'\Phase1');
Combined = strcat(folderPath,'\Combine\Phase1');
%Path to Myo Data
myoData = strcat(folderPath,'\MyoData');

% Path Rms files
RmsData = strcat(folderPath,'\Phase2\RMS');
phase3DataPathEat = strcat(folderPath,'\Phase_3_Data\Eat');
phase3DataPathNotEat = strcat(folderPath,'\Phase_3_Data\Not_Eat');
outputPath = strcat(folderPath,'\Phase_2_Data\Graphs\Rms');
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
RmsEat= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Rms\user28_userEatRms_data.mat');
RmsNotEat= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Rms\user28_userNotEatRms_data.mat');

x = 1:50:3000;

plot(RmsEat.userEatRms_data(x));
title('Rms feature Plot for user 28')

hold on
plot(RmsNotEat.userNotEatRms_data(x));
legend('Eating', 'Not Eating')
xlabel('Sample numbers')
ylabel('Rms Values')
xticklabels(x-1)
subplot(2,1,2)
RmsEat1= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Rms\user36_userEatRms_data.mat');
RmsNotEat2= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Rms\user36_userNotEatRms_data.mat');

x = 1:50:3000;

plot(RmsEat1.userEatRms_data(x));
title('Rms feature Plot for user 36')

hold on
plot(RmsNotEat2.userNotEatRms_data(x));
legend('Eating', 'Not Eating')
xlabel('Sample numbers')
ylabel('Rms Values')
xticklabels(x-1)