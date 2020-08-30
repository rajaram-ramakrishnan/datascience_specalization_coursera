mtcars <- mtcars
str(mtcars)
unique(mtcars$carb)

mtcars$cyl <- as.factor(mtcars$cyl)
mtcars$vs <- as.factor(mtcars$vs)
mtcars$am <- as.factor(mtcars$am)
mtcars$gear <- as.factor(mtcars$gear)
mtcars$carb <- as.factor(mtcars$carb)
levels(mtcars$am) <- c("Auto","Manual")

head(mtcars)

## EDA 
library(ggplot2)
transtyp <- ggplot(mtcars, aes(x=am, y=mpg)) + geom_boxplot(aes(fill=am))
transtyp <- transtyp + labs(title ="Auto/Manual transmission vs mpg boxplot")
transtyp <- transtyp + theme(plot.title=element_text(hjust = 0.5))
transtyp <- transtyp + xlab("Transmission Type") + ylab("Miles Per Gallon")

## boxplot clearly shows that manual transmission cars provides better mpg than 
## automatic cars

## T tests

autoTrans <- mtcars[mtcars$am=="Auto",]
manualTrans <- mtcars[mtcars$am=="Manual",]
t.test(autoTrans$mpg, manualTrans$mpg)
## p-value is 0.001 and we reject null hypothesis of there is no difference between
## mpg of Auto vs manual transmission
## transmission type is infact significantly correlated to gas mileage. 

## Linear Regression with single variable

lrModel <- lm(mpg ~ am, data = mtcars)
summary(lrModel)

## Identify other variables
t_var <- aov(mpg ~ ., data=mtcars)
summary(t_var)

## Linear Regression with other variables
mrModel <- lm (mpg ~ cyl+disp+wt+am, data=mtcars)
summary(mrModel)

## Analysis
fullModelFit <- lm(mpg ~ ., data = mtcars)
summary(fullModelFit)  # results hidden
summary(fullModelFit)$coeff  # results hidden

stepFit <- step(fullModelFit)
summary(stepFit) # results hidden
summary(stepFit)$coeff # results hidden

## Check Residulas
par(mfrow = c(2,2))
plot(stepFit)
