shuttle <- shuttle

## Consider the space shuttle data ?shuttle in the MASS library. 
## Consider modeling the use of the autolander as the outcome (variable name use). 
## Fit a logistic regression model with autolander (variable auto) 
## use (labeled as "auto" 1) versus not (0) as predicted by wind sign (variable wind). 
## Give the estimated odds ratio for autolander use comparing head winds, 
## labeled as "head" in the variable headwind (numerator) 
## to tail winds (denominator).

shuttle2 <- mutate(shuttle,auto=1*(use=="auto"))
logreg <- glm(auto ~ wind -1, family= "binomial", data=shuttle2)
Coeffs <- summary(logreg)$coef
LogoddRatioHeadTail <- Coeffs[1,1]-Coeffs[2,1]
oddRatioHeadTail <- exp(LogoddRatioHeadTail)
oddRatioHeadTail

## Consider the previous problem. Give the estimated odds ratio for autolander 
## use comparing head winds (numerator) to tail winds (denominator) adjusting 
## for wind strength from the variable magn.

logreg2 <- glm(auto ~ wind+magn -1, family= "binomial", data=shuttle2)
Coeffs <- summary(logreg2)$coef
LogoddRatioHeadTail <- Coeffs[1,1]-Coeffs[2,1]
oddRatioHeadTail <- exp(LogoddRatioHeadTail)
oddRatioHeadTail


## If you fit a logistic regression model to a binary variable, 
## for example use of the autolander, then fit a logistic regression model
## for one minus the outcome (not using the autolander) what happens to 
## the coefficients?

logreg3.1 <- glm(auto ~ wind, family= "binomial", data=shuttle2)
summary(logreg3.1)$coef

logreg3.2 <- glm(1- auto ~ wind, family= "binomial", data=shuttle2)
summary(logreg3.2)$coef

## Consider the insect spray data InsectSprays. Fit a Poisson model using spray 
## as a factor level. Report the estimated relative rate comapring spray A 
## (numerator) to spray B (denominator).

poisreg4 <- glm(count ~ spray -1, family="poisson", data=InsectSprays)
poisreg4coeffs <- summary(poisreg4)$coef
rateSprayASprayB <- exp(poisreg4coeffs[1,1] - poisreg4coeffs[2,1])
rateSprayASprayB

## Using a knot point at 0, fit a linear model that looks like a hockey stick 
## with two lines meeting at x=0. Include an intercept term, x and the knot 
## point term. What is the estimated slope of the line after 0?
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)

plot(x,y)
lm1 <- lm(y[1:6]~x[1:6])
lm2 <- lm(y[6:11]~x[6:11])

abline(lm1,col="blue",lw=2)
abline(lm2,col="blue",lw=2)

knot <- c(0)
splineterm <- sapply(knot,function(knot) ((x>knot)*(x-knot)))
mat <- cbind(1,x,splineterm)

linreg6 <- lm(y~mat-1)
pred6 <- predict(linreg6)
lines(x,pred6,col="red")
legend(x=-1,y=5, c("With lm","With X"),lty=c(1,1), lwd=c(2.5,2.5),col=c("blue", "red"))


slope <- (pred6[11]-pred6[6])/(x[11]-x[6])
slope