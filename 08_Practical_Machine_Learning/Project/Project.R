train_in <- read.csv("pml-training.csv")
valid_in <- read.csv("pml-testing.csv")

dim(train_in)
dim(valid_in)

## remove variables that are mostly NA

NAvar <- sapply(train_in, function(x) { mean(is.na(x))}) > 0.90
train_in <- train_in[, NAvar==FALSE]
valid_in <- valid_in[, NAvar==FALSE]

dim(train_in)
dim(valid_in)

## remove first 7 variables 

train_in <- train_in[, -c(1:7)]
valid_in <- valid_in[, -c(1:7)]

## further cleaning of variables that are Near zero variance
library(caret)
NZV <- nearZeroVar(train_in)
train_in <- train_in[, -NZV]
valid_in <- valid_in[, -NZV]

## Prepare datasets for prediction

set.seed(1278)
inTrain <- createDataPartition(train_in$classe, p=0.7, list=FALSE)
training <- train_in[inTrain,]
testing <-  train_in[-inTrain,]

## correlations
classe_ind <- which(names(training)=="classe")
cor_mat <- cor(training[ , -classe_ind] , as.numeric(training$classe))
bestCorrelations <- subset(as.data.frame(as.table(cor_mat)), abs(Freq)>0.25)

## even the best correlations with classe are around 0.3
## Lets check visually if its hard to use these as simple linear predictors

library(Rmisc)
library(ggplot2)

p1 <- ggplot(training, aes(classe,pitch_forearm)) + 
  geom_boxplot(aes(fill=classe))

p2 <- ggplot(training, aes(classe, magnet_belt_y)) + 
  geom_boxplot(aes(fill=classe))

p3 <- ggplot(training, aes(classe,magnet_arm_x)) + 
  geom_boxplot(aes(fill=classe))

p4 <- ggplot(training, aes(classe,magnet_arm_y)) + 
  geom_boxplot(aes(fill=classe))

multiplot(p1,p2,p3,p4,cols=2)

## clearly there is no hard separation of classes is not possible using only these highly correlated
## features. We need to go for model building

## Decision Trees
set.seed(12345)
library(rpart)
DTModel <- rpart(classe ~ ., data=training, method="class")
library(rattle)
fancyRpartPlot(DTModel)

predictDT <- predict(DTModel,newdata = testing,type="class")
cmDT <- confusionMatrix(predictDT, testing$classe)
cmDT

plot(cmDT$table, col = cmDT$byClass, 
     main = paste("Decision Tree - Accuracy =", round(cmDT$overall['Accuracy'], 4)))
## we saw accuracy as 0.7127 and out-of-sample error as 0.2863, which is considerable

## Random Forest

controlRF <- trainControl(method="cv", number=3, verboseIter=FALSE)
RFModel <- train(classe ~ ., data=training, method="rf", trControl=controlRF)
RFModel$finalModel

predictRF <- predict(RFModel,newdata = testing)
cmRF <- confusionMatrix(predictRF, testing$classe)
cmRF

plot(RFModel)
plot(cmRF$table, col = cmRF$byClass, main = paste("Random Forest Confusion Matrix: Accuracy =", round(cmRF$overall['Accuracy'], 4)))

## We saw accuracy of 0.9922 and out-of-sample error as 0.0078

## GBM

set.seed(12345)
controlGBM <- trainControl(method = "repeatedcv", number = 5, repeats = 1)
GBMModel  <- train(classe ~ ., data=training, method = "gbm", trControl = controlGBM, verbose = FALSE)
print(GBMModel)

predictGBM <- predict(GBMModel,newdata = testing)
cmGBM <- confusionMatrix(predictGBM, testing$classe)

plot(cmGBM$table, col = cmGBM$byClass, main = paste("Gradient Boosted Confusion Matrix: Accuracy =", round(cmGBM$overall['Accuracy'], 4)))
cmGBM

## We saw accuracy of 0.9624 and out-of-sample error as 0.0376

Results <- predict(RFModel, newdata=valid_in)
ValidationRes <- data.frame(problem_id = valid_in$problem_id, predicted = Results)
ValidationRes