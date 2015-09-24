library(XML)
library(data.table)

train <- fread("train.csv")
files_all <-list.files(" /Truly Native/0")
files_vector <-head(files_all,1000)

html_test <-data.frame(c.html_file=1,c.title=1,c.text=1,c.links=1)

#create a dataframe called html_test
for(file in files_vector){
  
  doc.html <- htmlTreeParse(file,useInternalNodes =TRUE)
  
  text<- length(unlist(xpathApply(doc.html, '//p', xmlValue)))
  
  title <-length(xpathApply(doc.html,'//title',xmlValue))
  
  href_l <- xpathSApply(doc.html,"//link",xmlGetAttr,"href")
  href_a <- xpathSApply(doc.html,"//a",xmlGetAttr,"href")
  links <-length(c(href_l,href_a))
  
  
  d <-c(file,title,text,links)
  html_test <- rbind(html_test,d)
  
}
colnames(html_test)[1] <- "file"
merged <- merge(x=html_test,y=train,by="file")
