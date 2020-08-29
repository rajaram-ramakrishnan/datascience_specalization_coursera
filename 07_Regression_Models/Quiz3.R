## Consider the  mtcars data set. Fit a model with mpg as the outcome that 
## includes number of cylinders as a factor variable and weight as confounder. 
## Give the adjusted estimate for the expected change in mpg comparing 8 cylinders 
## to 4.

names(mtcars)
factor(mtcars$cyl)

fit <- lm (mpg ~ factor(cyl)+wt, data=mtcars)
coef <- fit$coefficients
coef[3]

## Consider the  mtcars data set. Fit a model with mpg as the outcome that 
## includes number of cylinders as a factor variable and weight as a possible 
## confounding variable. Compare the effect of 8 versus 4 cylinders on mpg for 
## the adjusted and unadjusted by weight models. Here, adjusted means including 
## the weight variable as a term in the regression model and unadjusted means 
## the model without weight included. What can be said about the effect comparing
## 8 and 4 cylinders after looking at models with and without weight included?.

fit <- lm (mpg ~ factor(cyl)+wt, data=mtcars)
coef <- fit$coefficients

fitnowt <- lm (mpg ~ factor(cyl), data=mtcars)
coefnowt <- fitnowt$coefficients

summary(fit)
summary(fitnowt)

## Estimate of No weight (-11.5636) is less than estimate of weight(-6.0709). 
## Hence cyl appears to have less of impact when we disregard weight

## Consider the mtcars data set. Fit a model with mpg as the outcome 
## that considers number of cylinders as a factor variable and weight as 
## confounder. Now fit a second model with mpg as the outcome model that 
## considers the interaction between number of cylinders (as a factor variable) and weight. 
## Give the P-value for the likelihood ratio test comparing the two models 
## and suggest a model using 0.05 as a type I error rate significance benchmark.

fit <- lm (mpg ~ factor(cyl)+wt, data=mtcars)
coef <- fit$coefficients

fitinter <- lm (mpg ~ factor(cyl)*wt, data=mtcars)
coefinter <- fitinter$coefficients

anova(fit,fitinter)

## As P-value is more than 0.05, we would fail to reject the null hypothesis 
## so that no interaction is required

## Consider the mtcars\verb|mtcars|mtcars data set. Fit a model with mpg as 
## the outcome that includes number of cylinders as a factor variable and 
## weight inlcuded in the model as. How is wt coefficient interpreted?
fit <- lm(mpg ~ wt + factor(cyl), data = mtcars)
coef <- fit$coefficients

fit2 <- lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)
coef2 <- fit2$coefficients

## consider the following data set
x <- c(0.586, 0.166, -0.042, -0.614it, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
## Give the hat diagonal for the most influential point

plot(x,y)
fit <- lm (y ~ x)
hatvalues(fit)

## Give the slope dfbeta for the point with the highest hat value.

dfbetas(fit)[which(hatvalues(fit)==max(hatvalues(fit))),]

