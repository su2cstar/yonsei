
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd
from numpy.linalg import *


# In[6]:


def naivelm():
    #input term
    infname=input("Enter the data file name: ")
    sep=input("Select the data coding format(1 = 'a b c' or 2 = 'a,b,c'): ")
    if sep=='1':
        form=' '
    elif sep=='2':
        form=','
    else:
        return('You could select only 1 or 2')

    hd=input("Select the data header format(1 = with header or 2 = no header): ")
    if hd=='1':
        header='infer'
    elif hd=='2':
        header=None
    else:
        return('You could select only 1 or 2')

    cl=input("Select column# where your y vlaues exist: ")
    col = int(cl)-1

    data=pd.read_csv(infname,sep=form,header=header)

    #calculate term

    y=data.iloc[:,col]
    x=data.drop(col,1)
    n=data.shape[0]
    p=data.shape[1]
    one=pd.DataFrame(np.ones(n))
    x=pd.concat([one,x],axis=1)

    bhat=inv(x.transpose().dot(x)).dot(x.transpose()).dot(y)
    yhat= x.dot(bhat)

    estout=pd.concat([y,yhat],axis=1)

    j=np.ones((n,n))
    sse=y.transpose().dot(y)-bhat.transpose().dot(x.transpose()).dot(y)
    ssto=y.transpose().dot(y) - (1/n)*y.transpose().dot(j).dot(y)

    mse = sse /(n-p)
    rsquared= 1 - ((n-1)/(n-p))*(sse/ssto)
    mseout=pd.DataFrame([mse,rsquared])
    #output and naming term
    """
    outputm=input('Select your output 1:bhat 2:fittedvalue 3:mse&r-squared')
    if(outputm=='1'):
        bhat=pd.DataFrame(bhat)
        b=[]
        for i in bhat.index:
            b.append('Beta' + str(i))
        b[0]='Constant'
        bhat.index=b
        bhat.columns=['Coefficients']
        return(bhat)
    elif(outputm=='2'):
        estout.columns.name = 'ID'
        estout.columns = ['Actual values','Fitted values']
        return(estout)
    elif(outputm=='3'):
        mseout.index=['R-Squared = ','MSE = ']
        mseout.columns=['Model Summary']
        return(mseout)
    else:
        return('You could select only 1,2 or 3')
    """
    bhat=pd.DataFrame(bhat)
    b=[]
    for i in bhat.index:
        b.append('Beta' + str(i))
    b[0]='Constant'
    bhat.index=b
    bhat.columns=['Coefficients']
    estout.columns.name = 'ID'
    estout.columns = ['Actual values','Fitted values']
    mseout.index=['R-Squared = ','MSE = ']
    mseout.columns=['Model Summary']
    output = np.array([bhat,estout,mseout])

    fname=input('Select your output file name: ')
    bhat.to_csv(fname, mode='w',sep=' ' ,header=False)
    estout.to_csv(fname, mode='a', header=True)
    mseout.to_csv(fname, mode='a',sep=' ', header=False)
    return(output)
    #print(bhat,'\n', estout, '\n',mseout)


# In[7]:


naivelm()
