% User Independent Analysis
clc
clear all

% path of the folder
folderPath = 'C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data';
Combined = strcat(folderPath,'\Assignment 2\user independent');


columns = ["Decision Tree FScore", "Decision Tree Recall", "Decision Tree Precision", "SVM FScore", "SVM Recall", "SVM Precision", "NN F1Score", "NN Recall", "NN Precision"];
Overall_data = [];
Overall_data = [Overall_data; columns;];

% Loading data of all users before PCA
load('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Assignment 2\user independent\Eat_Data.mat');
load('C:\Users\saika\Desktop\EatingProject\Data_Mining_Assign1Data\Assignment 2\user independent\NotEat_Data.mat');
Eat_PCA = pca(UsersEat_total);
NotEat_PCA = pca( UsersNotEat_total);
Eat_Newmat = UsersEat_total * Eat_PCA(:,1:5);
NotEat_Newmat = UsersNotEat_total * NotEat_PCA(:,1:5);
 %%%%Creating Train and Test data%% for ML Algorithms
[Eat_Train, Eat_Test] = TrainTestSplit(Eat_Newmat);
[NotEat_Train, NotEat_Test] = TrainTestSplit(NotEat_Newmat(1:size(Eat_Newmat, 1), :));
 X_Train = [Eat_Train;NotEat_Train];
 X_Test = [Eat_Test; NotEat_Test];
 Y_Train = [ones(size(Eat_Train, 1), 1); zeros(size(NotEat_Train, 1), 1)];
 Y_Test = [ones(size(Eat_Test, 1), 1); zeros(size(NotEat_Test, 1), 1)];
 
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

   data = [dt_recall, dt_precision, dt_fscore, svm_recall, svm_precision, svm_fscore, nn_fscore, nn_recall, nn_precision];
   Overall_data = [Overall_data;data];

 writematrix(Overall_data, fullfile(Combined, "user_indep_data.csv"));
save(fullfile(Combined,'overall_data.mat'),'overall_data');

display('Computation Done')