function[Data_Train,Data_Test]=TrainTestSplit(Data)
[m,n] = size(Data) ;
P = 0.60 ; %60 and 40 % split for train and Test
idx = randperm(m)  ;
Data_Train = Data(idx(1:round(P*m)),:) ; 
Data_Test = Data(idx(round(P*m)+1:end),:) ;
end
