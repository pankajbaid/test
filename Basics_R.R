#' Day 1
#' #' Set Working Directory
getwd()
# data types in R
X=3
is.integer(X)
class(X)
"numeric"
Z <- TRUE #<- is assignment operator, as is ->
class(Z)
typeof(Z)
str(Z)
W <- "Hello"
class(W)
# Data Structures in R
## Vector
# All these x,y,z,w we created as actually vectors
Y =3
xx=c(X,Y)
class(xx)
xx <- c(xx,Z)  
xx  
xx <- c(xx,W)
xx
class(xx)

# R coerces data types
### Why vector ?

## R Recycles vector of multiple lengths
x <- c(2,3)
y <-c(3,5)
x+y
x <-c(2,3,4)
x+y

### Vector generating Functions
1:10 #seq of integers
seq(from=1,to=10,by=1)
# repeat function
rep(y,times=2)
rep(y,each=2)
## Random Numbers == random sample from uniform[0,1] distribution
runif(n=10)
# Random numbers from normal distribution
rnorm(n=10) #default mean=0,sd=1
plot(x=rnorm(n=10))

# Random NUMBERS FOR BINARY DISTRIBUTION
rbinom(10,5,0.2)
## Extract a sample from seq of first n natural numbers
sample.int(n=100,size=10,replace=FALSE)

## VECTOR OPERATIONS
x <-1:20
x = c(3,5)
# Get even numbered elements of x
x[seq(from=2,by=2,length.out = length(x)/2)]
x <-c(1:10)*2 #sequence generation is first operation , multi is second
x <- 1:20
x[c(FALSE,TRUE)]

# THE LOGICAL SUBSETTING OPENS UP THE '[' TO BEING USED AS "WHERE" CLAUSE OF SQL
x[x>5]

#Arithmetic Operators
x+2
x*2
x/2
x %/% 2 #Quotient
x %%2 #Remainder

# Elements of x divisible by 3
x[x%%3 == 0]
# Elements of x divisible by 3 and x >15
x[x%%3 == 0 & x>15]
x <-40:60
z <-1:9
x[z>6]
set.seed(0) #basic reproducible research"
# Heights of males, given vectors height & sex
ht <-rnorm(n=50,mean=160,sd=5) #logical choice of sd
ht<-round(ht,0)
ht
set.seed(0)
sex <- sample(x=c('M','F'),size=50,replace=TRUE)
sex

mean(ht[sex=='M'])
mean(ht[sex=='F'])

rm(list = ls()) #remove all objects in this R session
x <- NULL #YOU CAN ASSIGN X A NULL VALUE
x[2] <- NULL # cannot assign 0 length object to length 1 obj

x<-1:10
x[3]<-NA
x
mean(x) # will throw a NA
mean(x,na.rm=TRUE) #use only available data and get the mean

### Factor
class(sex)
str(sex)
sex = factor(sex)
str(sex)
# Factor is the data type for handling categorical data
mm = model.matrix(~sex-1)
mm

# Data frame

per <- data.frame(ht=ht,sex=sex)
per
row.names(per) <- paste0('p',1:nrow(per))
per
per["p9",] #data frame elements are subsetted by [<row subset>,<column subset>]
per[9,] #similar to p9 name
head(sort(ht))
# Sort the data frame by height and return the top 6 rows
head(per[order(per[,'ht']),],n=6)

# who has ht less than 155 ?
ht
per[per[,'ht']<155,]
#Just get the names of them

# We are subsetting a data frame and then extracting its row names
row.names(per[per[,'ht']<155,])
#Subsetting rownames directly
row.names(per)[per[,'ht']<155]

# Column is accessed as per [,'ht']
# Another way is per$ht.. this actually derives from underlying structure of data frame

# New Data set
mtcars
str(mtcars)

#how many unique values are there in cyl columns

length(unique(mtcars$cyl))

table(mtcars$cyl)

#How about counts of the combination cyl and am
table(mtcars$cyl,mtcars$am)
with(mtcars,table(cyl,am)) #setting context and giving names

#within is just like with in vba, simplifying redundancies
mtcars <- within(mtcars,{
  cyl <-factor(cyl)
  am <- factor(am)
  vs <- factor(vs)
  gear <-factor(gear)
  carb <- factor(carb)
})

str(mtcars)
summary(mtcars)

# How do you identify numeric and categorical columns of a df
is.numeric(mtcars$mpg)
numc <- sapply(mtcars,is.numeric)

#sapply is a simplified output of lapply
#lapply returns a list, sapply makes it a vector if possible
#lapply takes list as the first argument (every column of mtcars is an element of a list)

numc <- sapply(X = mtcars,FUN = is.numeric)
numc
names(numc)
numc <- names(numc)[numc] 
cm.numc <- colMeans(mtcars[,numc])

#How do you subtract column means from columns of a df

sapply(X = numc,FUN = function(x){
  mtcars[,x] - cm.numc[x]
})

# Group by summaries
#Aggregate mpg with unique cyl using mpg ~ cyl
agg <- aggregate(formula = cbind(mpg,wt) ~ cyl+am,data = mtcars,FUN=mean)
names(agg)[3:4] <-paste(names(agg)[3:4],"m",sep=".")
agg
agg.sd <- aggregate(formula = cbind(mpg,wt) ~ cyl+am,data = mtcars,FUN=sd)
agg.sd
names(agg.sd)[3:4] <-paste(names(agg.sd)[3:4],"m",sep=".")
str(agg)

# Join/Merge data frames
aggms <- merge(x = agg,y=agg.sd, by = c('cyl','am'))

# Inner Join
x=data.frame(a=letters[1:4],b=rnorm(4))
y=data.frame(a=letters[3:5],c=rnorm(3))
#Inner Join
merge(x,y,by='a')
# Left Join
merge(x=x,y=y,by='a',all.x = TRUE)
# Right Join
merge(x=x,y=y,by='a',all.y = TRUE)
# Full outer join
merge(x=x,y=y,by='a',all = TRUE)

library(data.table) #extremely fast
library(dplyr)

# Importing data in R
df =read.table(file = "./Datasets/access.csv",header = TRUE,sep = ",",quote="",dec=".",as.is = TRUE)

# Write to Excel File
library(XLConnect)
xlf <-loadWorkbook(filename='./Datasets/access.xlsx',create = TRUE) #Loads a Java object
createSheet(xlf,name='Sheet1')
writeWorksheet(xlf,data=df,sheet='sheet1',startRow = 10,startCol = 2)
saveWorkbook(xlf) #Excel File gets created

#Reading Excel File
rm(xlf) #Remove the object from the workspace
xlf <-loadWorkbook(filename='./Datasets/access.xlsx')
df1 <- readWorksheet(xlf,sheet = 'sheet1',startRow = 10,startCol = 2)
head(df1)
head(df)

library(RSQLite)

#Writing to database

con <- dbConnect(RSQLite::SQLite(),"mydb.sql")
con
dbWriteTable(conn=con,name="tbl1",value = df)
dbWriteTable(conn=con,name="tbl2",value = df) #Creating a Copy
dbDisconnect(con)
con
dim(df)

# Reading from database
con <- dbConnect(RSQLite::SQLite(),"mydb.sql")
df2<-dbReadTable(con,name = "tbl1")
df2
str(df2)

df4 <- dbGetQuery(con,"select count(*) nrow from tbl1")
df4
dbListTables(con)

# Plots
par() # plot area
plot(mpg ~ wt , data= mtcars, pch=16, col ='red')
barplot(table(mtcars$cyl),main="Bars of Cyl")
barplot(table(mtcars[,c('cyl','am')]),main="Bars of Cyl & am",xlab="am",ylab="count",beside=TRUE)
hist(mtcars$mpg)

#Continuous Vs Categorical
boxplot(hp ~ cyl,mtcars)
dotchart(x=agg[,'mpg.m'],labels=paste(agg[,'cyl']),pch=16,col="red")

