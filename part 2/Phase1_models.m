% USer Dependent Analysis
% New Features obtained by multiplying 
clc
clear all

% path of the folder
folderPath = 'C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data';

%Path to Myo Data
myoData = strcat(folderPath,'\MyoData');

% Path where Max files will be saved
output = strcat(folderPath,'\Assignment 2\Data\newFeatureSpace');
output1 = strcat(folderPath,'\Assignment 2\Data\Model');
mkdir(output1);

userList = ls(output);

userList = userList(3:end,:);

%Converts it character vectors
userList = cellstr(userList);
userNums = ls(myoData);
userNums = userNums(3:end,:);

columns = ["User", "Decision Tree FScore", "Decision Tree Recall", "Decision Tree Precision", "SVM FScore", "SVM Recall", "SVM Precision", "NN F1Score", "NN Recall", "NN Precision"];
User_data = [];
User_data = [User_data; columns;];
%User Loop 
for k = 1 : size(userNums, 1)
 
   %%% % eating data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    userData = userList(contains(userList,userNums(k,:))); 
    UsersEat_Newmat = userData(contains(userData,'UsersEat_Newmat'));
    UsersNotEat_Newmat = userData(contains(userData,'UsersNotEat_Newmat'));
      % Load  .mat files
    load(strcat(output,'\',UsersEat_Newmat{1}));
      % Load  .mat files
    
        % Load .mat files
    load(strcat(output,'\',UsersNotEat_Newmat{1}));

     %%%%Creating Train and Test data%% for ML Algorithms
    [userEat_Train, userEat_Test] = TrainTestSplit(UsersEat_Newmat);
    [userNotEat_Train, userNotEat_Test] = TrainTestSplit(UsersNotEat_Newmat(1:size(UsersEat_Newmat, 1), :));
    X_Train = [userEat_Train;userNotEat_Train];
    X_Test = [userEat_Test; userNotEat_Test];
    Y_Train = [ones(size(userEat_Train, 1), 1); zeros(size(userNotEat_Train, 1), 1)];
    Y_Test = [ones(size(userEat_Test, 1), 1); zeros(size(userNotEat_Test, 1), 1)];

    %X = [userEat; userNotEat(size(userEat, 1), :)];
   % Y = [ones(size(userEat, 1), 1); zeros(size(userEat, 1), 1)];
    %[X_Train, X_Test] = TrainTestSplit(X);
    %[Y_Train, Y_Test] = TrainTestSplit(Y);
    
        % %%%%% SVM %%%%%%%%%%%%%%%%%%%%%%%%%% 
    SVM = fitcsvm(X_Train,Y_Train,'Standardize',true,'KernelFunction','RBF',...
        'KernelScale','auto');
    label_SVM = predict(SVM,X_Test);

    svm_precision = 0;
    svm_recall = 0;
    svm_fscore = 0;
    
   [svm_confusion_matrix, order] = confusionmat(label_SVM, Y_Test);

    % calculate precision, recall and fscore
    for i=1:size(svm_confusion_matrix,1)
        precision(i) = svm_confusion_matrix(i,i) / sum(svm_confusion_matrix(i,:));
    end
    precision(isnan(precision)) = [];
    svm_precision = sum(precision) / size(svm_confusion_matrix, 1);

    % calculate recall
    for i=size(svm_confusion_matrix, 1)
        recall(i) = svm_confusion_matrix(i,i) / sum(svm_confusion_matrix(:, i));
    end

    svm_recall = sum(recall)/size(svm_confusion_matrix, 1);
    svm_fscore = 2 * svm_recall * svm_precision / (svm_precision + svm_recall);

  
    
    

    %%%Decision Tree%%%%%%
    dt_precision = 0;
    dt_recall = 0;
    dt_fscore = 0;
    
    tree = fitctree(X_Train,Y_Train);
    label_DT = predict(tree,X_Test);
    
    [dt_confusion_matrix, order] = confusionmat(label_DT, Y_Test);
    
    % calculate precision, recall and fscore    
    for i=1:size(dt_confusion_matrix,1)
        precision(i) = dt_confusion_matrix(i,i) / sum(dt_confusion_matrix(i,:));
    end
    precision(isnan(precision)) = [];
    dt_precision = sum(precision) / size(dt_confusion_matrix, 1);

    % calculate recall
    for i=size(dt_confusion_matrix, 1)
        recall(i) = dt_confusion_matrix(i,i) / sum(dt_confusion_matrix(:, i));
    end

    dt_recall = sum(recall)/size(dt_confusion_matrix, 1);
    dt_fscore = 2 * dt_recall * dt_precision / (dt_precision + dt_recall);
    
    
    

    % %%% Neural Network %%

    net = feedforwardnet(10);
    net = train(net, X_Train', Y_Train');
    label_NN = sim(net, X_Test');
    label_NN(label_NN>=0.5) = 1;
    label_NN(label_NN<0.5) = 0;
    [confMat, ~] = confusionmat(label_NN, Y_Test);
    for i =1:size(confMat,1)
        precision(i)=confMat(i,i)/sum(confMat(i,:)); 
    end
    precision(isnan(precision))=[];
    Precision_NN=sum(precision)/size(confMat,1);

    for i =1:size(confMat,1)
        recall(i)=confMat(i,i)/sum(confMat(:,i));  
    end

    Recall_NN=sum(recall)/size(confMat,1);
    F1_score_NN=2*Recall_NN*Precision_NN/(Precision_NN+Recall_NN);
    [nconfusion_matrix, ~] = confusionmat(label_NN, Y_Test');
    % calculate precision
    for i=1:size(nconfusion_matrix,1)
        nprecision(i) = nconfusion_matrix(i,i) / sum(nconfusion_matrix(i,:));
    end
    nprecision(isnan(nprecision)) = [];
    nn_precision = sum(nprecision) / size(nconfusion_matrix, 1);

    % calculate recall
    for i=size(nconfusion_matrix, 1)
        nrecall(i) = nconfusion_matrix(i,i) / sum(nconfusion_matrix(:, i));
    end

    nn_recall = sum(nrecall)/size(nconfusion_matrix, 1);
    nn_fscore = 2 * nn_recall * nn_precision / (nn_precision + nn_recall);

   data = ["User" + k, dt_recall, dt_precision, dt_fscore, svm_recall, svm_precision, svm_fscore, nn_fscore, nn_recall, nn_precision];

    
   
   User_data = [User_data;data];

    disp("end user" + k);


end
writematrix(User_data, fullfile(output1, "user_dep_data.csv"));
display('Computation Done')