clc
clear all

% path of the folder
folderPath = 'C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data';

Result = strcat(folderPath,'\Phase1');
Combined = strcat(folderPath,'\Combine\Phase1');
%Path to Myo Data
myoData = strcat(folderPath,'\MyoData');

% Path max files
MaxData = strcat(folderPath,'\Phase2\Max');
phase3DataPathEat = strcat(folderPath,'\Phase_3_Data\Eat');
phase3DataPathNotEat = strcat(folderPath,'\Phase_3_Data\Not_Eat');
outputPath = strcat(folderPath,'\Phase_2_Data\Graphs\Max');
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
MaxEat= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Max\user21_userEatMax_data.mat');
MaxNotEat= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Max\user21_userNotEatMax_data.mat');

x = 1:100:4000;

plot(MaxEat.userEatMax_data(x));
title('MAX feature Plot for user 21')

hold on
plot(MaxNotEat.userNotEatMax_data(x));
legend('Eating', 'Not Eating')
xlabel('Sample numbers')
ylabel('Max Values')
xticklabels(x-1)
subplot(2,1,2)
MaxEat1= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Max\user10_userEatMax_data.mat');
MaxNotEat2= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Max\user10_userNotEatMax_data.mat');

x = 1:100:4000;

plot(MaxEat1.userEatMax_data(x));
title('MAX feature Plot for user 10')

hold on
plot(MaxNotEat2.userNotEatMax_data(x));
legend('Eating', 'Not Eating')
xlabel('Sample numbers')
ylabel('Max Values')
xticklabels(x-1)
