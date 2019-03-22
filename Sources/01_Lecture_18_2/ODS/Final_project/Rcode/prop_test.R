

setwd('C:/Users/ahn92/Dropbox/Sources/ODS/Final_project/Rcode')
df <- read_csv("prop_test.csv")


df['p-value'] =rep(0,nrow(df))
df['p-value'][1,] = NA

for (i in 2:nrow(df)) {
  n = c(df[1,]$n,df[i,]$n)
  
  x = c(df[1,]$p * df[1,]$n,df[i,]$p * df[i,]$n)
  
  a = prop.test(x = x, n = n,  alternative = c("two.sided"), conf.level = 0.95)
  df['p-value'][i,] = round(a$p.value,3)
}

write.csv(df,file ='prop_test_result.csv')
df
