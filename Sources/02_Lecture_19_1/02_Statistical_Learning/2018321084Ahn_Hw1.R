
##data input
rm(list=ls())
dat <- read.table("http://statweb.stanford.edu/~tibs/ElemStatLearn/datasets/prostate.data") # prostate cancer data
lasso <- function(glambda = 0.05) {
  
  ##hyper parameter setting
  max_iter = 100
  set.seed(0)
  beta_init = rnorm(8)
  
  
  ##normalize columns function
  normalize = function(vec){
    (vec-mean(vec))/sqrt((1/length(vec)) * sum((vec-mean(vec))^2) )
  }
  
  ##soft threshold function
  soft_threshold <- function(a, lambda) {
    if ( -a > lambda) {
      out = a + lambda    
    }  
    else if(a > lambda){
      out = a - lambda
    }
    else{
      out = 0
    }
    return(out)
  }
  # select beta
  min_beta =function(x,y,beta,j){
    n = length(y)
    selector = seq(1,dim(x)[2])[-j]
    norm_x_j = sqrt(x[,j]%*%x[,j])#sqrt(sum(abs(x[,j])^2))
    a = as.matrix(t(x[,j]))%*%(as.matrix(y) - as.matrix(x[,selector])%*%beta[selector])
    res = soft_threshold(a,glambda/2)
    return(res/(norm_x_j^2))
  }
  
  ##main function
  cylcic = function(x,y,beta_init){
    beta = beta_init
    beta_vals = beta
    #print(beta)
    d =dim(x)[2]
    iter = 0
    while (iter < max_iter) {
      for (j in 1:d) {
        min_beta_j = min_beta(x,y,beta,j)
        beta[j] = min_beta_j
        #print(beta)
      }
      beta_vals = cbind(beta_vals,beta)
      iter = iter + 1
    }
    out = t(beta_vals)
    row.names(out) = NULL
    colnames(out) = colnames(x)
    return(out)
  }
  
  
  train = dat[dat$train,]
  test = dat[!dat$train,]
  
  
  nor_train = apply(X = train,FUN = normalize ,MARGIN = 2)
  nor_train = data.frame(nor_train)
  
  x = nor_train[,-9:-10]
  y = train[,9]
  
  out = cylcic(x = x,y = y,beta_init = beta_init)
  outlast = tail(out,1)
  rownames(outlast)=NULL
  return(outlast)
}

## grid search for lasso and make dataframe with lambda and coefficient
ldf = lasso(0)
for (i in seq(from=1,to=118,by=1)) {
  ldf = rbind(ldf,lasso(i))
}
row.names(ldf) = seq(from=0,to=118,by=1)
ldf = data.frame(ldf)





## ploting with shrinkage Factor s
ldf$shrinkage = apply(X = ldf,FUN = function(x) sum(abs(x))/sum(abs(ldf[1,])),MARGIN = 1)
plotlasso <- function() {
  coldic = c('red','orange','purple','blue','gray','black','darkblue','violet')
  plot(x=ldf$shrinkage,y=ldf[,1],type= 'l',lty = 1 ,col='red',xlim=c(0,1),ylim=c(-0.3,1),ylab="Coefficients", xlab="Shringate Factor s")
  lines(x=ldf$shrinkage,y=ldf[,2],lty = 1, col = 'orange')
  lines(x=ldf$shrinkage,y=ldf[,3],lty = 1, col = 'purple')
  lines(x=ldf$shrinkage,y=ldf[,4],lty = 1, col = 'blue')
  lines(x=ldf$shrinkage,y=ldf[,5],lty = 1, col = 'gray')
  lines(x=ldf$shrinkage,y=ldf[,6],lty = 1, col = 'black')
  lines(x=ldf$shrinkage,y=ldf[,7],lty = 1, col = 'darkblue')
  lines(x=ldf$shrinkage,y=ldf[,8],lty = 1, col = 'violet')
  abline(h = 0 , lty=2)
  legend(0, 1, legend=colnames(ldf)[1:8],lty = rep(1,8), col=coldic, cex = 0.6)
}


plotlasso()

## use test data and find the minimun mse point

## test data input
test = dat[!dat$train,]
normalize = function(vec){
  (vec-mean(vec))/sqrt((1/length(vec)) * sum((vec-mean(vec))^2) )
}
nor_test = apply(X = test,FUN = normalize ,MARGIN = 2)
nor_te1st = data.frame(nor_test)

test_x = nor_test[,-9:-10]
test_y = test[,9]

## make the mse function and add test mse column
return_mse = function(beta){
  yhat = as.matrix(test_x)%*%as.matrix(beta)
  return(sum((yhat-test_y)^2))
}

ldf$test_mse = apply(X = ldf[,-9],FUN = return_mse ,MARGIN = 1)


## plot with minimum mse point
plotlasso_withmse <- function() {
  coldic = c('red','orange','purple','blue','gray','black','darkblue','violet')
  plot(x=ldf$shrinkage,y=ldf[,1],type= 'l',lty = 1 ,col='red',xlim=c(0,1),ylim=c(-0.3,1),ylab="Coefficients", xlab="Shringate Factor s")
  lines(x=ldf$shrinkage,y=ldf[,2],lty = 1, col = 'orange')
  lines(x=ldf$shrinkage,y=ldf[,3],lty = 1, col = 'purple')
  lines(x=ldf$shrinkage,y=ldf[,4],lty = 1, col = 'blue')
  lines(x=ldf$shrinkage,y=ldf[,5],lty = 1, col = 'gray')
  lines(x=ldf$shrinkage,y=ldf[,6],lty = 1, col = 'black')
  lines(x=ldf$shrinkage,y=ldf[,7],lty = 1, col = 'darkblue')
  lines(x=ldf$shrinkage,y=ldf[,8],lty = 1, col = 'violet')
  abline(h = 0 , lty=2)
  abline(v=ldf[ldf$test_mse==min(ldf$test_mse),]$shrinkage, lty=2 , col='red')
  legend(0, 1, legend=colnames(ldf)[1:8],lty = rep(1,8), col=coldic, cex = 0.6)
}

plotlasso_withmse()

## coefficient when test mse is minimum
ldf[ldf$test_mse==min(ldf$test_mse),]

## minimum lambda when all coefiicients are zero
print(rownames(head(ldf[ldf$lcavol==0,],1)))
head(ldf[ldf$lcavol==0,],1)
