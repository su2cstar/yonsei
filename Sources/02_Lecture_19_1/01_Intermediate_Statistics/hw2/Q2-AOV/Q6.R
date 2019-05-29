data = read.csv('extract.csv',encoding = 'latin1')
colnames(data)=c('seed', 'extract',  'n' ,'yes')
data['no'] = data$n-data$yes
data['p'] = data$yes/data$n
##SeedA
mean(data[data$seed==0,]$p)
##SeedB
mean(data[data$seed==1,]$p)
##Extract1
mean(data[data$extract==0,]$p)
##Extract2
mean(data[data$extract==1,]$p)

##SeedA & Extract1
mean(data[data$seed==0 & data$extract==0,]$p)
##SeedA & Extract2
mean(data[data$seed==0 & data$extract==1,]$p)
##SeedB & Extract1
mean(data[data$seed==1 & data$extract==0,]$p)
##SeedB & Extract2
mean(data[data$seed==1 & data$extract==1,]$p)

summary(aov(p ~ seed + extract,data=data))
summary(aov(p ~ seed + extract + seed*extract,data=data))


summary(glm(cbind(yes,no)~seed+extract,family = binomial,data =data))
summary(glm(cbind(yes,no)~seed+extract +seed*extract,family = binomial,data =data))

data_matrix <- rbind(row_1, row_2)
dimnames(data_matrix) <- list("Seed" = c("A", "B"), "Extract" = c("1", "2"))
chisq.test(data_matrix)
