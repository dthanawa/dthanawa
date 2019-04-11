# Problem Description
# Machine_Learning.py
# Description:
# Predict whether the customer is creditable or not.

# Two datasets: 1) German Credit dataset 2) Australian Credit dataset
# Six Machine Learning Classification Methods: 
# 1) Logistic Regression - lr
# 2) K - Nearest Neighbors Classification - knn
# 3) Support Vector Machine Classification - svc
# 4) Decision Tree Classification - dt
# 5) Random Forest Classification - rf
# 6) Naive Bayes Classification - nb

# Special requirements or dependencies:
# None; Tested in Mac OS X with Python 2.7
# Compilation and execution:
# Compilation not necessary
# Execution takes approx 100-120 seconds on most modern hardware.
 
# For the execution in terminal 
# python Machine_Learning.py



# Import the library
import pandas as pd

# Import the dataset

dataset = pd.read_excel('German_Credit_Data.xlsx')
dataset.drop(["Acc","Telephone","Gender"],axis = 1, inplace = True)
#dataset = pd.read_excel('Australian_Credit_Data.xlsx')

# Data Pre-Processing(Splitting data, Categorical data, Feature Scaling)
from Functions import data_preprocessing
X_train,X_test,y_train,y_test = data_preprocessing(dataset)

# Fitting Logistic Regression to the Training set
from sklearn.linear_model import LogisticRegression
classifier_lr = LogisticRegression()
classifier_lr.fit(X_train, y_train)

# Fitting K-NN to the Training set
from sklearn.neighbors import KNeighborsClassifier
classifier_knn = KNeighborsClassifier(n_neighbors = 5, metric = 'euclidean', p = 2)
classifier_knn.fit(X_train, y_train)

# Fitting Kernel SVM to the Training set
from sklearn.svm import SVC
classifier_svc = SVC(kernel = 'poly', degree = 2)
classifier_svc.fit(X_train, y_train)

# Fitting Decision Tree Classification to the Training set
from sklearn.tree import DecisionTreeClassifier
classifier_dt = DecisionTreeClassifier(criterion = 'gini', min_samples_split = 10)
classifier_dt.fit(X_train, y_train)

# Fitting Random Forest Classification to the Training set
from sklearn.ensemble import RandomForestClassifier
classifier_rf = RandomForestClassifier(n_estimators = 10, criterion = 'entropy', min_samples_split = 2)
classifier_rf.fit(X_train, y_train)

# Fitting Naive Bayes Classification to the Training set
from sklearn.naive_bayes import BernoulliNB
classifier_nb = BernoulliNB(alpha = 1, binarize = 0.0 )
classifier_nb.fit(X_train, y_train)

# Predicting the Test set results
y_pred_lr  = classifier_lr.predict(X_test)
y_pred_knn = classifier_knn.predict(X_test)
y_pred_svc = classifier_svc.predict(X_test)
y_pred_dt  = classifier_dt.predict(X_test)
y_pred_rf  = classifier_rf.predict(X_test)
y_pred_nb  = classifier_nb.predict(X_test)

# Plot Confusion Matrix before tuning
from Functions import  con_mat_plot
print('Confusion Matrix for Logistic Regression')
con_mat_plot(y_test,y_pred_lr)
print('Confusion Matrix for KNN')
con_mat_plot(y_test,y_pred_knn)
print('Confusion Matrix for SVM')
con_mat_plot(y_test,y_pred_svc)
print('Confusion Matrix for Decision Tree')
con_mat_plot(y_test,y_pred_dt)
print('Confusion Matrix for Random Forest')
con_mat_plot(y_test,y_pred_rf)
print('Confusion Matrix for Naive Bayes')
con_mat_plot(y_test,y_pred_nb)


# Applying K-Fold Cross Validation
from Functions import  k_fold_cross
accuracies_lr  = k_fold_cross(classifier_lr, X_train, y_train)
accuracies_knn = k_fold_cross(classifier_knn, X_train, y_train)
accuracies_svc = k_fold_cross(classifier_svc, X_train, y_train)
accuracies_dt  = k_fold_cross(classifier_dt, X_train, y_train)
accuracies_rf  = k_fold_cross(classifier_rf, X_train, y_train)
accuracies_nb  = k_fold_cross(classifier_nb, X_train, y_train)

print('LR: Mean Accuracy before tuning',accuracies_lr.mean()*100.)
print('KNN :Mean Accuracy before tuning',accuracies_knn.mean()*100.)
print('SVC :Mean Accuracy before tuning',accuracies_svc.mean()*100.)
print('Decision Tree :Mean Accuracy before tuning',accuracies_dt.mean()*100.)
print('Random Forest :Mean Accuracy before tuning',accuracies_rf.mean()*100.)
print('Naive Bayes :Mean Accuracy before tuning',accuracies_nb.mean()*100.)

# Applying Grid Search to find the best model and the best parameters
from Functions import  choosing_parameters


# Best parameters for Logistic Regression

parameters_lr = [{'C': [1, 5, 10], 'tol': [1e-4,1e-5,1e-6,1e-10]}]
best_para_lr  = choosing_parameters(parameters_lr,classifier_lr,X_train,y_train)
C_lr          = best_para_lr[0]
tole_lr       = best_para_lr[1]

# Best parameters for KNN
parameters_knn = [{'n_neighbors': [5, 7, 3, 9, 11, 13], 'metric': ['minkowski', 'euclidean'], 'p': [1,2,3,4,5]}]
best_para_knn  = choosing_parameters(parameters_knn,classifier_knn,X_train,y_train)
N_knn          = best_para_knn[0]
metric_knn     = best_para_knn[1]
p_knn          = best_para_knn[2]

# Best parameters for SVM
parameters_svc = [{'kernel': ['rbf','poly'], 'degree': [1, 2, 3, 4, 5, 6, 7]}]
best_para_svc  = choosing_parameters(parameters_svc,classifier_svc,X_train,y_train)
ker_svc        = best_para_svc[0]
deg_svc        = best_para_svc[1]

# Best parameters for Decision Tree
parameters_dt = [{'criterion': ['gini','entropy'], 'min_samples_split': [2,4,6,8,10,15]}]
best_para_dt  = choosing_parameters(parameters_dt,classifier_dt,X_train,y_train)
criteria_dt   = best_para_dt[1]
min_split_dt  = best_para_dt[0]


# Best parameters for Random Forest
parameters_rf   = [{'criterion': ['gini','entropy'],'min_samples_split': [2,5, 10, 15, 20],
                    'n_estimators': [10, 20, 30, 40, 50,100,150]}]
best_para_rf    = choosing_parameters(parameters_rf,classifier_rf,X_train,y_train)
min_samp_spl_rf = best_para_rf[0]
n_est_rf        = best_para_rf[1]
criterion_rf    = best_para_rf[2]

# Best parameters for Naive bayes
parameters_nb = [{'alpha': [1, 5, 7, 10, 20, 50, 60, 100], 
               'binarize': [0.0, 0.1, 0.2, 0.3, 0.4, 0.5]}]
best_para_nb  = choosing_parameters(parameters_nb,classifier_nb,X_train,y_train)
alfa_nb       = best_para_nb[1]
bi_nb         = best_para_nb[0]

#Selecting the best parameters and apply the classification methods

# Logistic Regression
classifier_lr = LogisticRegression(C = int(C_lr), tol = float(tole_lr) )
classifier_lr.fit(X_train, y_train)

# KNN
classifier_knn = KNeighborsClassifier(n_neighbors = int(N_knn), metric = str(metric_knn), p = int(p_knn))
classifier_knn.fit(X_train, y_train)

# SVM
classifier_svc = SVC(kernel = str(ker_svc), degree = int(deg_svc))
classifier_svc.fit(X_train, y_train)

# Decision Tree Classification
classifier_dt = DecisionTreeClassifier(criterion = str(criteria_dt), min_samples_split = int(min_split_dt))
classifier_dt.fit(X_train, y_train)

# Random Forest Classification
classifier_rf = RandomForestClassifier(n_estimators = int(n_est_rf), criterion = str(criterion_rf),
                                    min_samples_split = int(min_samp_spl_rf))
classifier_rf.fit(X_train, y_train)

# Naive Bayes Classification
classifier_nb = BernoulliNB(alpha = int(alfa_nb), binarize = float(bi_nb))
classifier_nb.fit(X_train, y_train)


# Predict the Test set results
y_pred_lr = classifier_lr.predict(X_test)
y_pred_knn = classifier_knn.predict(X_test)
y_pred_svc = classifier_svc.predict(X_test)
y_pred_dt = classifier_dt.predict(X_test)
y_pred_rf = classifier_rf.predict(X_test)
y_pred_nb = classifier_nb.predict(X_test)

# Create Confusion Matrix
from Functions import  con_mat_plot
print('Confusion Matrix for Logistic Regression')
con_mat_plot(y_test,y_pred_lr)
print('Confusion Matrix for KNN')
con_mat_plot(y_test,y_pred_knn)
print('Confusion Matrix for SVM')
con_mat_plot(y_test,y_pred_svc)
print('Confusion Matrix for Decision Tree')
con_mat_plot(y_test,y_pred_dt)
print('Confusion Matrix for Random Forest')
con_mat_plot(y_test,y_pred_rf)
print('Confusion Matrix for Naive Bayes')
con_mat_plot(y_test,y_pred_nb)

# Apply K-Fold Cross Validation
from Functions import  k_fold_cross
accuracies_lr  = k_fold_cross(classifier_lr, X_train, y_train)
accuracies_knn = k_fold_cross(classifier_knn, X_train, y_train)
accuracies_svc = k_fold_cross(classifier_svc, X_train, y_train)
accuracies_dt  = k_fold_cross(classifier_dt, X_train, y_train)
accuracies_rf  = k_fold_cross(classifier_rf, X_train, y_train)
accuracies_nb  = k_fold_cross(classifier_nb, X_train, y_train)
print('LR: Mean Accuracy after tuning',accuracies_lr.mean()*100.)
print('KNN :Mean Accuracy after tuning',accuracies_knn.mean()*100.)
print('SVM :Mean Accuracy after tuning',accuracies_svc.mean()*100.)
print('Decision Tree :Mean Accuracy after tuning',accuracies_dt.mean()*100.)
print('Random Forest :Mean Accuracy after tuning',accuracies_rf.mean()*100.)
print('Naive Bayes :Mean Accuracy after tuning',accuracies_nb.mean()*100.)

# Plot Mis-Classification
from Functions import  plot_classification
print('Plot for Logistic Regression')
plot_classification(X_train,X_test,y_train,y_test,y_pred_lr)  
print('Plot for K-NN Classification')
plot_classification(X_train,X_test,y_train,y_test,y_pred_knn)
print('Plot for SVM')
plot_classification(X_train,X_test,y_train,y_test,y_pred_svc)
print('Plot for Decision Tree Classification')
plot_classification(X_train,X_test,y_train,y_test,y_pred_dt)
print('Plot for Random Forest Classification')
plot_classification(X_train,X_test,y_train,y_test,y_pred_rf)
print('Plot for Naive Byaes Classification')
plot_classification(X_train,X_test,y_train,y_test,y_pred_nb)
