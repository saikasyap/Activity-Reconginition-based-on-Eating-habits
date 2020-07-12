clc
clear all

% path of the folder
folderPath = 'C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data';

Result = strcat(folderPath,'\Phase1');
Combined = strcat(folderPath,'\Combine\Phase1');
%Path to Myo Data
myoData = strcat(folderPath,'\MyoData');

% Path Min files
MinData = strcat(folderPath,'\Phase2\Min');
phase3DataPathEat = strcat(folderPath,'\Phase_3_Data\Eat');
phase3DataPathNotEat = strcat(folderPath,'\Phase_3_Data\Not_Eat');
outputPath = strcat(folderPath,'\Phase_2_Data\Graphs\Min');
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
MinEat= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Min\user25_userEatMin_data.mat');
MinNotEat= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Min\user25_userNotEatMin_data.mat');

x = 1:50:2000;

plot(MinEat.userEatMin_data(x));
title('Min feature Plot for user 25')

hold on
plot(MinNotEat.userNotEatMin_data(x));
legend('Eating', 'Not Eating')
xlabel('Sample numbers')
ylabel('Min Values')
xticklabels(x-1)
subplot(2,1,2)
MinEat1= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Min\user16_userEatMin_data.mat');
MinNotEat2= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Min\user16_userNotEatMin_data.mat');

x = 1:50:2000;

plot(MinEat1.userEatMin_data(x));
title('Min feature Plot for user 16')

hold on
plot(MinNotEat2.userNotEatMin_data(x));
legend('Eating', 'Not Eating')
xlabel('Sample numbers')
ylabel('Min Values')
xticklabels(x-1)