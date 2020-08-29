## 1
x <- c(0.18, -1.54, 0.42, 0.95)
w <- c(2, 1, 3, 1)

mu <- sum(x*w)/sum(w)

## 2

x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

# Regression through origin
linModel <- lm(y ~ x -1)

##3

data(mtcars)
linModel <- lm(mpg~wt, data=mtcars)

##4

sd_x <- 0.5
sd_y <- 1
cor_xy <- 0.5

slope <- cor_xy * sd_y / sd_x

##5

cor_yx <- 0.4
Quiz1 <- 1.5

# normalized , slope = correlation
beta1 <- cor_yx
beta0 <- 0

Quiz2 <- beta0 + beta1 * Quiz1

##6

x <- c(8.58, 10.46, 9.01, 9.64, 8.86)

first_measure <- (x[1]-mean(x))/sd(x)

##7

x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

linModel <- lm (y ~ x)
linModel$coefficients['(Intercept)']

##9
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
mean(x)
