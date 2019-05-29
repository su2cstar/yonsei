#original data
c1 = c(237,15,16,7,24,3,6,5)
c2 = c(10,4,2,3,3,2,2,11)
c3 = c(118,8,11,6,7,3,4,4)
c4 = c(6,2,1,4,3,1,2,7)
df = data.frame(cbind(c1,c2,c3,c4))
df

#previous1 data
no = c(283,30,140,21,274,26,134,18,266,32,134,14)
yes = c(17,20,12,14,24,26,14,21,28,24,12,17)
previous = c(0,1,0,1,0,1,0,1,0,1,0,1)
s = c(0,0,1,1,0,0,1,1,0,0,1,1)
t = c(10,10,10,10,9,9,9,9,8,8,8,8)
dat = data.frame(cbind(no,yes,previous,s,t))
dat
fit1 = glm(cbind(yes,no)~previous+s+t,family=binomial,data=dat)
summary(fit1)
########################################

no = c(237,15,16,7,24,3,6,5,118,8,11,6,7,3,4,4)
yes = c(10,4,2,3,3,2,2,11,6,2,1,4,3,1,2,7)
previous = c(0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1)
s = c(0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1)
t = c(10,10,10,10,9,9,9,9,8,8,8,8)

dat = data.frame(cbind(no,yes,previous,s,t))
dat
fit1 = glm(cbind(yes,no)~previous+s+t,family=binomial,data=dat)
summary(fit1)
