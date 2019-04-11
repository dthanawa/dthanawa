# Importing the libraries
import pandas as pd
import numpy as np

# Importing the dataset

#dataset = pd.read_excel('German_Credit_Data.xlsx')
#dataset.drop(["Acc","Telephone","Gender"],axis = 1, inplace = True)
dataset = pd.read_excel('Australian_Credit_Data.xlsx')

# Data Pre-Processing(Splitting data, Categorical data, Feature Scaling)
from Functions import data_preprocessing
X_train,X_test,y_train,y_test = data_preprocessing(dataset)

for i in range(len(y_train)):
    if y_train[i] > 1:
        y_train[i] = int(0)

for i in range(len(y_test)):
    if y_test[i] > 1:
        y_test[i] = int(0)
    
X_train_new = np.array(pd.DataFrame(np.ones([len(X_train),1]),columns = ["bias"]).join(pd.DataFrame(X_train)))
X_test_new  = np.array(pd.DataFrame(np.ones([len(X_test),1]),columns = ["bias"]).join(pd.DataFrame(X_test)))

w_lr = np.squeeze(np.empty([np.shape(X_test)[1]+1,1]))
w_lr_new = np.squeeze(np.ones([np.shape(X_test)[1]+1,1]))
    


while np.sum(np.abs(w_lr - w_lr_new)) > 0.0001:
    w_lr_new = w_lr
    w_lr.shape
    p = np.matrix(np.squeeze(np.array(np.exp(np.matmul(np.array(X_train_new),np.transpose(np.matrix(w_lr)))
              )/(1+ np.exp(np.matmul(np.array(X_train_new),np.transpose(np.matrix(w_lr))))))))
    s = np.matmul(p,np.transpose(1-p))
    z = np.matmul(X_train_new,np.transpose(np.matrix(w_lr))) + (y_train-p).T/s[0,0]
    S = s[0,0]*np.identity(len(y_train))
    w_lr = np.linalg.inv(np.transpose(np.matrix(X_train_new))*
                             np.transpose(np.matrix(S))*X_train_new)*np.transpose(np.matrix(
            X_train_new))*np.transpose(np.matrix(S))*z
    w_lr = np.transpose(np.matrix(w_lr))


pro = np.exp(np.matmul(np.array(X_test_new),np.transpose(np.matrix(w_lr)))
              )/(1+ np.exp(np.matmul(np.array(X_test_new),np.transpose(np.matrix(w_lr)))))
pro = np.array(pro)
y_est_lr = np.empty([len(y_test),1])

for i in range(len(y_test)):
    if pro[i,0] > 0.5:
        y_est_lr[i,0] = int(1)
    else:
        y_est_lr[i,0] = int(0)

Accuracy_lr = (len(y_test) - np.count_nonzero(y_test - np.squeeze(y_est_lr)))*1.0/len(y_test)*100.

print("Learned weights = ")
print(w_lr)
print("Accuracy = ")
print(Accuracy_lr)


# Plot Mis-Classification
from Functions import  plot_classification
plot_classification(X_train,X_test,y_train,y_test,y_est_lr)