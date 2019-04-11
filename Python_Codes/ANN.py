# Problem Description
# ANN.py
# Description:
# Predict whether the customer is creditable or not.

# Two datasets: 1) German Credit dataset 2) Australian Credit dataset
# Artificial Neural Network 


# Special requirements or dependencies:
# None; Tested in Mac OS X with Python 2.7
# Compilation and execution:
# Compilation not necessary
# Execution takes approx 8-10 minutes on most modern hardware.
 
# For the execution in terminal 
# python ANN.py

# Import the library
import pandas as pd
import numpy as np
# Import the dataset

dataset = pd.read_excel('German_Credit_Data.xlsx')
dataset.drop(["Acc","Telephone","Gender"],axis = 1, inplace = True)
#dataset = pd.read_excel('Australian_Credit_Data.xlsx')

# Part 1 - Data Pre-Processing(Splitting data, Categorical data, Feature Scaling)
from Functions import data_preprocessing
X_train,X_test,y_train,y_test = data_preprocessing(dataset)


# Part 2 - Make the ANN!

# Importing the Keras libraries and packages

import keras
from keras.models import Sequential
from keras.layers import Dense
from keras.wrappers.scikit_learn import KerasClassifier

def ann_model():

    # Initialising the ANN
    classifier = Sequential()

    # Adding the input layer and the first hidden layer
    classifier.add(Dense(output_dim = 10, kernel_initializer = 'uniform', activation = 'relu', input_dim = np.shape(X_test)[1]))
    
    # Adding the second hidden layer
    classifier.add(Dense(output_dim = 10, kernel_initializer = 'uniform', activation = 'relu'))

    # Adding the output layer
    classifier.add(Dense(output_dim = 1, kernel_initializer = 'uniform', activation = 'sigmoid'))
    
    # Compiling the ANN
    classifier.compile(optimizer = 'rmsprop', loss = 'binary_crossentropy', metrics = ['accuracy'])
    
    return classifier
    
# Fitting the ANN to the Training set
classifier = KerasClassifier(build_fn = ann_model, batch_size = 25, epochs = 100)

# Cross validation 
from sklearn.model_selection import StratifiedKFold
from sklearn.model_selection import cross_val_score

kfold = StratifiedKFold(n_splits=10, shuffle=True, random_state = 2)
results = cross_val_score(classifier, X_test, y_test, cv=kfold)
print(results.mean())  

  
# Part 3 - Making predictions and evaluating the model
classifier.fit(X_train, y_train)

# Predicting the Test set results
y_pred = classifier.predict(X_test)
y_pred = (y_pred > 0.5)

from Functions import  con_mat_plot
con_mat_plot(y_test,y_pred)


# Plot Mis-Classification
from Functions import  plot_classification
plot_classification(X_train,X_test,y_train,y_test,y_pred)  

# Tuning the ANN
import keras
from keras.wrappers.scikit_learn import KerasClassifier
from sklearn.model_selection import GridSearchCV
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import Dropout
def build_classifier(optimizer):
    classifier = Sequential()
    classifier.add(Dense(units = 10, kernel_initializer = 'uniform', activation = 'relu', input_dim = np.shape(X_test)[1]))
    classifier.add(Dropout(p = 0.1))
    classifier.add(Dense(units = 10, kernel_initializer = 'uniform', activation = 'relu'))
    classifier.add(Dropout(p = 0.1))
    classifier.add(Dense(units = 1, kernel_initializer = 'uniform', activation = 'sigmoid'))
    classifier.compile(optimizer = optimizer, loss = 'binary_crossentropy', metrics = ['accuracy'])
    return classifier


classifier = KerasClassifier(build_fn = build_classifier)
parameters = {'batch_size' : [25, 50],
              'epochs' : [100, 200],
              'optimizer' : ['adam' , 'rmsprop']}

grid_search = GridSearchCV(estimator = classifier,
                           param_grid = parameters,
                           scoring = 'accuracy',
                           cv = 10)
grid_search = grid_search.fit(X_train, y_train)
best_parameters = grid_search.best_params_
best_accuracy = grid_search.best_score_
print('Best Accuracy = ',best_accuracy)