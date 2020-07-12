%How to calculate PCA and plot PCA
data =  UsersEat_Data;
[coefficient,score_new,latency,square_T, description, new_variable] = pca(data);
plot(zscore(data))

new_Matrix = data * coefficient(:,1:5)
plot(new_Matrix)
plot(zscore(new_Matrix))

title('Principal Components after PCA on Eating data');



