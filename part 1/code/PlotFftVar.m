clc
clear all

% path of the folder
folderPath = 'C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data';

Result = strcat(folderPath,'\Phase1');
Combined = strcat(folderPath,'\Combine\Phase1');
%Path to Myo Data
myoData = strcat(folderPath,'\MyoData');

% Path Fft files
FftData = strcat(folderPath,'\Phase2\Fft');
phase3DataPathEat = strcat(folderPath,'\Phase_3_Data\Eat');
phase3DataPathNotEat = strcat(folderPath,'\Phase_3_Data\Not_Eat');
outputPath = strcat(folderPath,'\Phase_2_Data\Graphs\Fft');
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
FftEat= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Fft\user32_userEatFft_data.mat');
FftNotEat= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Fft\user32_userNotEatFft_data.mat');

x = 1:50:3000;

plot(FftEat.userEatFft_data(x));
title('Fft feature Plot for user 21')

hold on
plot(FftNotEat.userNotEatFft_data(x));
legend('Eating', 'Not Eating')
xlabel('Sample numbers')
ylabel('Fft Values')
xticklabels(x-1)
subplot(2,1,2)
FftEat1= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Fft\user33_userEatFft_data.mat');
FftNotEat2= load ('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Phase2\Fft\user33_userNotEatFft_data.mat');

x = 1:50:3000;

plot(FftEat1.userEatFft_data(x));
title('Fft feature Plot for user 33')

hold on
plot(FftNotEat2.userNotEatFft_data(x));
legend('Eating', 'Not Eating')
xlabel('Sample numbers')
ylabel('Fft Values')
xticklabels(x-1)