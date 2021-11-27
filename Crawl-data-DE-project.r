library(odbc)
library(jsonlite)
library(writexl)
library(taskscheduleR)
#craw json data 
json_file <- ("https://tygia.com/json.php?fbclid=IwAR2Q-UAOr7y5-U9E3_SNOoEMxjVeuqkMTEe6SUiaEUCaQmAUo8uHbD0ls2s")
data <- fromJSON(json_file)
#rate 
for  (i in 1:4)
{
  df_rate <-
    data.frame(
      bank = as.character(),
      date = as.character(),
      buy = as.character(),
      order = as.character(),
      name = as.character(),
      sell = as.character(),
      transfer = as.character(),
      id = as.character(),
      day = as.character(),
      code = as.character()
    )
  bank<-as.data.frame(rep(data$rates$bank[i],nrow(as.data.frame(data$rates$value[i]))))
  colnames(bank)<-"bank"
  date<-as.data.frame(rep(data$rates$date[i],nrow(as.data.frame(data$rates$value[i]))))
  colnames(date)<-"date"
  value<-as.data.frame(data$rates$value[i])
  df_rate<-rbind(df_rate,cbind(bank,date,value))
}  
#gold
for (i in 1:4)
{
  df_gold<-data.frame( date=as.character(),
                       buy=as.character(),
                       sell=as.character(),
                       company=as.character(),
                       brand=as.character(),
                       updated=as.character(),
                       brand1=as.character(),
                       day=as.character(),
                       id=as.character(),     
                       type=as.character(),
                       code=as.character() )
  date<-as.data.frame(data$golds$updated[i])
  colnames(date)<-"date"
  value<-as.data.frame(data$golds$value[i])
  df_gold<-rbind(df_gold,cbind(date,value))
}
#export data 
write_xlsx(df_gold,"gold.xlsx")
write_xlsx(df_rate,"rate.xlsx")
#write table into sql server 
dgb_connection <- dbConnect(
  odbc(),
  Driver = "sql server",
  Database = "xxx", #insert database name  
  Server = ".",
  Port = 1433
)
dbWriteTable(dgb_connection,"df_rate",df_rate)
dbWriteTable(dgb_connection,"df_gold",df_gold)

