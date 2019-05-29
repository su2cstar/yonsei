setwd('C:\\Users\\ahn92\\Documents\\dev\\Sources\\02_Lecture_19_1\\01_Intermediate_Statistics\\hw2\\Q5-Markov')
dat = read.csv('illness.csv', encoding = 'latin1')
head(dat)
colnames(dat)=c("no" ,"yes"   ,"t.1"   ,"t.2" ,  "s"     ,"t"   )

1-pchisq(3.12,df=8)

fit2  = glm(cbind(yes,no) ~ t.1 + t.2 + s+t ,family = binomial, data = dat)
summary(fit2)
1-pchisq(2.3424,df=11)
