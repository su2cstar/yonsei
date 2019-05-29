import pandas as pd
import numpy as np
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import f1_score
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split

dummy_total = pd.read_csv(r'C:\Users\ahn92\Documents\dev\Sources\20_Project\02_PJ_Embrain\data\dummy_total.csv')
is_churn = pd.read_csv(r'C:\Users\ahn92\Documents\dev\Sources\20_Project\02_PJ_Embrain\data\churn_label.csv')
tfoffline = pd.read_csv(r'C:\Users\ahn92\Documents\dev\Sources\20_Project\02_PJ_Embrain\data\tfoffline.csv')
tfonline = pd.read_csv(r'C:\Users\ahn92\Documents\dev\Sources\20_Project\02_PJ_Embrain\data\tfonline.csv')

dummy_total.shape
dummy_total['is_churn'] = is_churn['is_churn']
yzero = np.zeros(7667)
X,y1,y2,y3 = dummy_total, is_churn['is_churn'], tfoffline['tfoffline'] , tfonline['tfonline']
clf1 = LogisticRegression(random_state=0, penalty='l1',solver = 'liblinear', multi_class='ovr').fit(X, y1)
clf2 = LogisticRegression(random_state=0, penalty='l1',solver = 'liblinear', multi_class='ovr').fit(X, y2)
clf3 = LogisticRegression(random_state=0, penalty='l1',solver = 'liblinear', multi_class='ovr').fit(X, y3)

yhat_prob = clf.predict_proba(X)[:,1]

threshold = sorted(yhat_prob, key = lambda x : -x)[709]
yhat = pd.Series(yhat_prob >= threshold).map(lambda x : int(x))
f1_score(y,yhat)
accuracy_score(y,yhat)
clf.coef_
X1_train, X1_test, y1_train, y1_test = train_test_split(X, y1, test_size=0.33, random_state=0)
X2_train, X2_test, y2_train, y2_test = train_test_split(X, y2, test_size=0.33, random_state=0)
X3_train, X3_test, y3_train, y3_test = train_test_split(X, y3, test_size=0.33, random_state=0)

set = [[X1_train, X1_test, y1_train, y1_test],[X2_train, X2_test, y2_train, y2_test],[X3_train, X3_test, y3_train, y3_test]]

def lasso_my(lst):
    X_train, X_test, y_train, y_test = lst[0],lst[1],lst[2],lst[3]
    clf = LogisticRegression(random_state=0, penalty='l1',solver = 'liblinear', multi_class='ovr').fit(X_train,y_train)
    yhat_prob = clf.predict_proba(X_test)[:,1]
    thresorder = int((sum(y_train)/len(y_train))*len(y_test)) -1
    threshold = sorted(yhat_prob, key = lambda x : -x)[thresorder]
    yhat = pd.Series(yhat_prob >= threshold).map(lambda x : int(x))
    coef = np.array(X.columns)[(clf.coef_!=0)[0]]
    return (f1_score(y_test,yhat) ,accuracy_score(y_test,yhat),coef)
X.columns.shape
lasso_my(set[0])[0],lasso_my(set[1])[0],lasso_my(set[2])[0]
lasso_my(set[0])[1],lasso_my(set[1])[1],lasso_my(set[2])[1]
lasso_my(set[0])[2].shape ,lasso_my(set[1])[2].shape ,lasso_my(set[2])[2].shape
