## 1

x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)

# method 1 using lm
fit <- lm (y ~ x)
coefTab <- summary(fit)$coefficients
pval <- coefTab[2,4]


## method 2 

n <- length(y)
beta1 <- cor(y, x) * sd(y) / sd(x)
beta0 <- mean(y) - beta1 * mean(x)
e <- y - beta0 - beta1 * x
sigma <- sqrt(sum(e^2) / (n-2)) 
ssx <- sum((x - mean(x))^2)
seBeta1 <- sigma / sqrt(ssx)
tBeta1 <- beta1 / seBeta1
pBeta1 <- 2 * pt(abs(tBeta1), df = n - 2, lower.tail = FALSE)

## 2
# method1
sigma <- summary(fit)$sigma
#method2
sigma1 <- sqrt(sum(e^2)/(n-2))

##3
## method1

data(mtcars)
y <- mtcars$mpg
x <- mtcars$wt
fit_car <- lm(y ~ x)

newx <- data.frame(x = mean(x))
predict(fit_car, newdata = newx, interval = ("confidence"))


## method 2
yhat <- fit_car$coef[1] + fit_car$coef[2] * mean(x)
yhat + c(-1, 1) * qt(.975, df = fit_car$df) * summary(fit_car)$sigma / sqrt(length(y))       


## 5

## method1
predict(fit_car, newdata = data.frame(x = 3), interval = ("prediction"))
