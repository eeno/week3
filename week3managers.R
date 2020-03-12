# Enter data into vectors before constructing the data frame
date_col <- c("2018-15-10", "2018-01-11", "2018-21-10", "2018-28-10", "2018-01-05")
#date_col <- as.Date(date_col,"%y %m %d")
date_col

country_col <- c("US", "US", "IRL", "IRL", "IRL")
gender_col <- c("M", "F", "F", "M", "F")
age_col <- c(32, 45, 25, 39, 99) # 99 is one of the values in the age attribute - will require recoding
q1_col <- c(5, 3, 3, 3, 2)
q2_col <- c(4, 5, 5, 3, 2)
q3_col <- c(5, 2, 5, 4, 1)
q4_col <- c(5, 5, 5, NA, 2) # NA is inserted in place of the missing data for this attribute
q5_col <- c(5, 5, 2, NA, 1)

column_names <- c("Date", "Country", "Gender", "Age", "Q1", "Q2", "Q3", "Q4", "Q5")

managers <- data.frame(date_col, 
                       country_col, 
                       gender_col, 
                       age_col, 
                       q1_col, 
                       q2_col, 
                       q3_col,
                       q4_col,
                       q5_col)

colnames(managers) <- column_names

str(managers)

managers$Age[managers$Age == 99] <- NA
managers


managers$AgeCat[managers$Age >= 45 ] <- "Elder"
managers$AgeCat[managers$Age >= 26 & managers$Age <=44 ] <-"Middle aged"
managers$AgeCat[managers$Age >= 25 ] <- "Young"

managers

managers$AgeCat[is.na(managers$Age)] <- "Elder"


AgeCat <- factor(managers$AgeCat,ordered = TRUE,levels = c( "Young", "Middle aged","Elder"))

managers$AgeCat <- AgeCat



summary_col <- managers$Q1 + managers$Q2 + managers$Q3 + managers$Q4 + managers$Q5

managers$Summary_col <- summary_col

managers


new_data <- subset(managers, Age >= 35 | Age < 24, select = c(Q1, Q2, Q3, Q4) )
new_data
str(managers)


#calculate the mean for each row

mean_valuw <- rowMeans(managers[5:9])

mean_valuw

managers$Mean_Value <- mean_valuw

managers

#add column names to new rows
names(managers)[11] <- "Answer Total"
names(managers)[12] <- "Mean Value"


str(managers)

#change date structurefrom factor to date
#we cant convert a factor to date without converting to a character vector first

date_field <- as.character(managers$Date)
date_field
str(date_field)

new_date <- as.Date(date_field, "%Y-%d-%m")
managers$Date <- new_date
str(managers)

#working with missig values-------------------------

new_data <- na.omit(managers)
new_data

complete_data <- complete.cases(managers)
complete_data

#list all rows that do not have missing values
complete_data <- managers[complete.cases(managers),]

complete_data


#find the sum of all missong values in age categorey
sum(!is.na(managers$Age))

install.packages("mice")
library("mice")
md.pattern(managers)

install.packages("VIM")
library("VIM")
missong_values <- aggr(managers,prop = FALSE, numbers = TRUE)
