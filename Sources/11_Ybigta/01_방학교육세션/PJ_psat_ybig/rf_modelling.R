
##set working directory and install package
setwd('C:\\Users\\SUIC_STAR\\Dropbox\\Sources\\Ybigta\\PJ_psat_ybig')
#install.packages('h2o')
#train = read.csv('train.csv')

##call library
library(data.table)
library(h2o)

##read data files
train <- fread("train_train.csv",stringsAsFactors = T)
test  <- fread("train_test.csv",stringsAsFactors = T)

store <- fread("Drugstore_data\\store.csv",stringsAsFactors = T)

ans <- fread('Drugstore_data\\test_ans.csv',stringsAsFactors = T)


##use train data whose sales is not zero
train <- train[Sales > 0,]  

##merge the data table inner join with 'Store' Key
train <- merge(train,store,by="Store")
test <- merge(test,store,by="Store")
test_ans <- merge(ans,store,by="Store")
##change the data type of Date column to 'Date' Type
train[,Date:=as.Date(Date)]
test[,Date:=as.Date(Date)]

##set the data type of each data
train[,month:=as.integer(format(Date, "%m"))]
train[,year:=as.integer(format(Date, "%y"))]
train[,Store:=as.factor(as.numeric(Store))]

test[,month:=as.integer(format(Date, "%m"))]
test[,year:=as.integer(format(Date, "%y"))]
test[,Store:=as.factor(as.numeric(Store))]

test[,StateHoliday:=as.factor(StateHoliday)]

## log transformation to not be as sensitive to high sales
train[,logSales:=log1p(Sales)]


## Use H2O's random forest
## Start cluster with all available threads
h2o.init(nthreads=-1,max_mem_size='16G')
## Load data into cluster from R
trainHex<-as.h2o(train)
## Set up variable to use all features other than those specified here
features<-colnames(train)[!(colnames(train) %in% c("Id","Date","Sales","logSales","Customers"))]

## Load test data into cluster from R
testHex<-as.h2o(test)
## make rmspe function
my_rmspe=function(test,pred){
  rmspe = 0
  for (i in 1:length(test$Sales)) {
    if (test$Sales[i]!=0) {
      rmspe = rmspe + ((test$Sales[i]-pred[i])/test$Sales[i])^2
    }
    else{
      rmspe = rmspe + ((test$Sales[i]-pred[i])/(test$Sales[i]+0.001))^2
    }
  }
  return(sqrt(rmspe/length(test$Sales)))
}

## Train a random forest using all default parameters
rfHex <- h2o.randomForest(x=features,
                          y="logSales", 
                          ntrees = 500,
                          max_depth = 20,
                          nbins_cats = 1115, ## allow it to fit store ID
                          training_frame=trainHex)

summary(rfHex)

## Get predictions out; predicts in H2O, as.data.frame gets them into R
predictions<-as.data.frame(h2o.predict(rfHex,testHex))
## Return the predictions to the original scale of the Sales data
pred <- expm1(predictions[,1])

##change the values of pred whose open is 0
pred[test$Open==0] = 0

#calculate rmspe as 
my_rmspe(test,pred)


#############################GBM#########################
gbmHex <- h2o.gbm(x=features,
                          y="logSales", 
                          ntrees = 50,
                          max_depth = 30,
                          nbins_cats = 1115, ## allow it to fit store ID
                          training_frame=trainHex)
summary(gbmHex)

## Get predictions out; predicts in H2O, as.data.frame gets them into R
predictions_gbm<-as.data.frame(h2o.predict(gbmHex,testHex))
## Return the predictions to the original scale of the Sales data
pred_gbm <- expm1(predictions_gbm[,1])

##change the values of pred whose open is 0
pred_gbm[test$Open==0] = 0

#calculate rmspe as 

my_rmspe(test_ans,pred_gbm)