# importing the libraries
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# Function for Plotting:

def plot_classification(X_train,X_test,y_train,y_test,y_pred):
    from sklearn.decomposition import PCA
    pca = PCA(n_components = 2)
    X_train = pca.fit_transform(X_train) 
    X_test = pca.transform(X_test)
    explained_variance = pca.explained_variance_ratio_


    comparision = pd.DataFrame.join(pd.DataFrame(y_test,columns=['y_test']),pd.DataFrame(y_pred,dtype=int,columns=['y_pred']))
    comparision['Comparision'] = comparision.apply(lambda x: 0 if x[0] == x[1] else 1, axis=1)

    plotdata = pd.DataFrame.join(pd.DataFrame(X_test,columns=['0','1']),comparision['Comparision'])


    # Plot misclassification
    fig3, ax3 = plt.subplots(figsize = (14,7))

    ax3.scatter(x = plotdata[plotdata.Comparision ==0]['0'],y = plotdata[plotdata.Comparision == 0]['1'], marker = 'o',color = 'red')
    ax3.scatter(x = plotdata[plotdata.Comparision ==1]['0'],y = plotdata[plotdata.Comparision == 1]['1'], marker = 'o',color = 'blue')

    ax3.legend(['Classified','Misclassified'])
    plt.xlabel('X1')
    plt.ylabel('X2')
    plt.title('Classification')
    plt.show()

# Function for Confusion Matrix:
    
def con_mat_plot(y_test,y_pred):
    from sklearn.metrics import confusion_matrix
    cm = confusion_matrix(y_test, y_pred)
    plt.clf()
    plt.imshow(cm, interpolation='nearest', cmap=plt.cm.Wistia)
    classNames = ['Negative','Positive']
    plt.title('Confusion Matrix - Test Data')
    plt.ylabel('True Result')
    plt.xlabel('Predicted Result')
    tick_marks = np.arange(len(classNames))
    plt.xticks(tick_marks, classNames, rotation=45)
    plt.yticks(tick_marks, classNames)
    s = [['TN','FP'], ['FN', 'TP']]
 
    for i in range(2):
        for j in range(2):
            plt.text(j,i, str(s[i][j])+" = "+str(cm[i][j]))
    plt.show()

# Function k-fold cross validation
def k_fold_cross(classifier, X_train, y_train):
    from sklearn.model_selection import cross_val_score
    accuracies = cross_val_score(estimator = classifier, X = X_train, y = y_train, cv = 10)
    return accuracies.mean()

# Data Preprocessing    
def data_preprocessing(dataset):
    listt = dataset.select_dtypes(include=['category', object]).columns
    X = dataset.iloc[:, :-1].values
    y = dataset.iloc[:, -1].values
    
    for i in range(0,len(y)):
        if y[i] == 2:
            y[i] = 0


    listn = np.empty((len(listt),1))
    for i in range(0,len(listt)):
        listn[i,0] = dataset.columns.get_loc(listt[i])
    
    # Categorial data
    from sklearn.preprocessing import LabelEncoder, OneHotEncoder
    labelencoder_X = LabelEncoder()

    for i in range(0,len(listn)):
        X[:,int(listn[i,0])] = labelencoder_X.fit_transform(X[:,int(listn[i,0])])
        onehotencoder        = OneHotEncoder(categorical_features = [int(listn[i,0])])

    # Splitting the dataset into the Training set and Test set
    from sklearn.model_selection import train_test_split
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2)


    # Feature Scaling
    from sklearn.preprocessing import StandardScaler
    sc      = StandardScaler()
    X_train = sc.fit_transform(X_train)
    X_test  = sc.transform(X_test)
    return X_train,X_test,y_train,y_test

# Function for selecting the best parameters:
    
def choosing_parameters(parameters,classifier,X_train,y_train):
    from sklearn.model_selection import GridSearchCV
    grid_search = GridSearchCV(estimator = classifier,
                               param_grid = parameters,
                               scoring = 'accuracy',
                               cv = 10,
                               n_jobs = -1)
    grid_search = grid_search.fit(X_train, y_train)
    best_accuracy = grid_search.best_score_
    best_parameters = grid_search.best_params_
    best_para = np.array(best_parameters.values())
    return best_para