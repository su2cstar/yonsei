
# coding: utf-8

# In[1]:


## import modules
import numpy as np
import pandas as pd


# In[2]:


## set your path where your data are saved
fpath = 'C:/Users/ahn92/Documents/Sources/BDP\/'


# In[5]:


def getSimFromTsv(fname = None , outfname = None):
    ## file input term
    if fname == None:
        fname = input('Input your input file name : ')
    inFile = pd.read_csv(fpath+fname, sep ='\t', header = None, encoding = 'UTF8')
    #inFile = pd.read_csv(fname, sep ='\t', header = None, encoding = 'UTF8')
    ## make the dictionary by using pivot
    usrName = set(inFile.iloc[:,0])
    catName = set(inFile.iloc[:,1])
    
    pdict = inFile.pivot(index = 0, columns = 1 , values= 2)
    pDict = pdict.to_dict()
    
    ## remove the nan term
    rmNandict = dict()
    for i in pDict.keys():
        my_dict = pDict[i]
        clean_dict = {k: my_dict[k] for k in my_dict if not np.isnan(my_dict[k])}
        rmNandict.update({i:clean_dict})
    
    ## we calculate the distance if data has same key
    ## get the same key fuction
    def getSameKey(key1,key2,dt):
        skey = []
        for i in dt[key1].keys():
            for j in dt[key2].keys():
                   if i==j:
                        skey.append(i)
        return(skey)
    
    ## calculate similarity function
    def calcSim(key1,key2,dt):
        tmpSum = 0
        if getSameKey(key1,key2,dt)==[]:
            return(np.nan)
        else:
            for i in getSameKey(key1,key2,dt):
                tmpSum = tmpSum + (dt[key1][i]-dt[key2][i])**2
            return(1/(1+np.sqrt(tmpSum)))
    
    ## output term
    outlst = []
    for i in rmNandict.keys():
        for j in rmNandict.keys():
            if i!=j and (not np.isnan(calcSim(i,j,rmNandict))):
                outlst.append([i,j,calcSim(i,j,rmNandict)])

    outdt = pd.DataFrame(outlst)  
    if outfname==None:
        outfname = input('input your output file name : ')
    outdt.to_csv(outfname, sep = '\t',index=False, header = False)
    return outdt


# In[6]:


getSimFromTsv('in.txt','out.txt')


# In[7]:
a = input('press any key')

#getSimFromTsv('user_book_score_test.txt','user_book_score_test_out.txt')

