#HW2
rm(list=ls())
#########################################################################
#########################################################################
#question2
#########################################################################
#########################################################################

getwd()
setwd("D:/강재훈/연세대학교/석사/2019_1_석사_2학기/수업/중응통/HW/HW2/question_2")

df2 = read.table('seed.dat')
mat2 = as.matrix(df2)
mat2

#number of seeds that germinated
y_i = mat2[,1]
#number of planted seeds
n_i = mat2[,2]

#(a) 
seed_A = 1:11
seed_B = 12:21
extr_1 = c(1:5,12:16)
extr_2 = c(6:11,17:21)

seed_extr_A1 = 1:5
seed_extr_A2 = 6:11
seed_extr_B1 = 12:16
seed_extr_B2 = 17:21

#calculate y_i/n_i
avgs = y_i/n_i

#average of seed A
sum(y_i[seed_A])/sum(n_i[seed_A])
#average of seed B
sum(y_i[seed_B])/sum(n_i[seed_B])
#average of Extract1
sum(y_i[extr_1])/sum(n_i[extr_1])
#average of Extract2
sum(y_i[extr_2])/sum(n_i[extr_2])

#average of seed A & extract 1
sum(y_i[seed_extr_A1])/sum(n_i[seed_extr_A1])
#average of seed A & extract 2
sum(y_i[seed_extr_A2])/sum(n_i[seed_extr_A2])
#average of seed B & extract 1
sum(y_i[seed_extr_B1])/sum(n_i[seed_extr_B1])
#average of seed B & extract 2
sum(y_i[seed_extr_B2])/sum(n_i[seed_extr_B2])

#(b)
#Two way ANOVA
tr_A = c(rep(0,11),rep(1,10))
tr_B = c(rep(0,5),rep(1,6),rep(0,5),rep(1,5))

summary(aov(avgs ~ tr_A*tr_B))
summary(aov(avgs ~ tr_A+tr_B))

#Assumptions of ANOVA
###(1)Normality
#Anderson Darling test
  #install.packages('nortest')
library('nortest')
#H0 : y_i/n_i ~ Normal dist
result_AD_test = ad.test(avgs)
result_AD_test$p.value <= 0.05 #FALSE => do not reject H0

###(2)Homogeniety of Variance
#H0 : y_i/n_i's have Homogeniety of variance(Seed)
group_vec1 = c(1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2)
result_BL_test1 = bartlett.test(avgs~group_vec1)
result_BL_test1$p.value <= 0.05 #FALSE => do not reject H0 
#H0 : y_i/n_i's have Homogeniety of variance(Extract)
group_vec2 = c(1,1,1,1,1,2,2,2,2,2,2,1,1,1,1,1,2,2,2,2,2)
result_BL_test2 = bartlett.test(avgs~group_vec2)
result_BL_test2$p.value <= 0.05 #FALSE => do not reject H0 

###(3)Independence


#(c)
#Logistic Regression
input = cbind(y_i, n_i-y_i)
Logistic_model1 = glm(input~tr_A*tr_B,family=binomial)
summary(Logistic_model1)

Logistic_model2 = glm(input~tr_B,family=binomial)
summary(Logistic_model2)
