clc
clear all

% path of the folder
folderPath = 'C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data';

Result = strcat(folderPath,'\Phase1');
Combined = strcat(folderPath,'\Combine\Phase1');
%Path to Myo Data
myoData = strcat(folderPath,'\MyoData');

% Path Mean files
MeanData = strcat(folderPath,'\Phase2\Mean');
phase3DataPathEat = strcat(folderPath,'\Phase_3_Data\Eat');
phase3DataPathNotEat = strcat(folderPath,'\Phase_3_Data\Not_Eat');
outputPath = strcat(folderPath,'\Phase_2_Data\Graphs\Mean');
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
MeanEat= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Mean\user24_userEatMean_data.mat');
MeanNotEat= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Mean\user24_userNotEatMean_data.mat');

x = 1:50:3000;

plot(MeanEat.userEatMean_data(x));
title('Mean feature Plot for user 21')

hold on
plot(MeanNotEat.userNotEatMean_data(x));
legend('Eating', 'Not Eating')
xlabel('Sample numbers')
ylabel('Mean Values')
xticklabels(x-1)
subplot(2,1,2)
MeanEat1= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Mean\user17_userEatMean_data.mat');
MeanNotEat2= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Mean\user17_userNotEatMean_data.mat');

x = 1:50:3000;

plot(MeanEat1.userEatMean_data(x));
title('Mean feature Plot for user 17')

hold on
plot(MeanNotEat2.userNotEatMean_data(x));
legend('Eating', 'Not Eating')
xlabel('Sample numbers')
ylabel('Mean Values')
xticklabels(x-1)