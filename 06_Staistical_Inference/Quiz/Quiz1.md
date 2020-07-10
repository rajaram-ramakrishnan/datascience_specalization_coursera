### Quiz 1

Question 1 :

Consider influenza epidemics for two parent heterosexual families. Suppose that the probability is 17% that at least one of the parents has contracted the disease. The probability that the father has contracted influenza is 12% while the probability that both the mother and father have contracted the disease is 6%. What is the probability that the mother has contracted influenza?

(Hints look at lecture 2 around 5:30 and chapter 4 problem 4). 

Options :

- 11%
- 5%
- 17%
- 6%

Solution : 

P(AUB) = P(A)+P(B)-P(ANB)

P(AUB) = 0.17
P(A) = 0.12
P(B) = ?
P(ANB) = 0.06

0.17 = 0.12 + ? - 0.06
0.17 = 0.06 + ?
? = 0.17-0.06
?= 0.11

11%

Question 2 :

A random variable, XXX is uniform, a box from 0 to 1 of height 1. (So that its density is f(x)=1f(x) = 1f(x)=1 for 0≤x≤10\leq x \leq 10≤x≤1.) What is its 75th percentile?

(Hints, look at lecture 2 around 21:30 and Chapter 5 Problem 5. Also, look up the help function for the qunif command in R.)

Options :
- 0.10
- 0.50
- 0.25
- 0.75

Solution :

The density is like box. The point below 0.75 will be 0.75

Question 3 :

You are playing a game with a friend where you flip a coin and if it comes up heads you give her XXX dollars and if it comes up tails she gives you YYY dollars. The probability that the coin is heads is ppp (some number between 000 and 111.) What has to be true about XXX and YYY to make so that both of your expected total earnings is 000. The game would then be called “fair”.

(Hints, look at Lecture 4 from 0 to 6:50 and Chapter 5 Problem 6. Also, for further reading on fair games and gambling, start with the Dutch Book problem ). 

Options :
- X=Y
- p/1-p = X/Y
- p = X/Y
- p/1-p = Y/X

Solution :

probablity of coin being head = p

probablilty of coin being tail = 1-p

x*(p)*(-1) + y*(1-p) = 0

x*(p)*(-1) = y*(1-p)

x*p = y*(1-p)

x/y =(1-p)/p or y/x = p/1-p

Question 4 :

A density that looks like a normal density (but may or may not be exactly normal) is exactly symmetric about zero. (Symmetric means if you flip it around zero it looks the same.) What is its median? 

Options :
- The median must be 0.
- The median must be 1.
- The median must be diffrent from mean.
- We cant conclude anything about median.

Solution :

For exactly symmetric shape at 0, 50% of values are above 0 and 50% are below 0. Hence Median is 0.

Question 5 :
``` {r}
x <- 1:4
p <- x/sum(x)
temp <- rbind(x, p)
rownames(temp) <- c("X", "Prob")
temp
```

```{r}
## [,1] [,2] [,3] [,4]
## X 1.0 2.0 3.0 4.0
## Prob 0.1 0.2 0.3 0.4
```

What is the mean?

(Hint, watch Lecture 4 on expectations of PMFs.)

Options :
- 3
- 2
- 1
- 4

Solution :

Sum of X * Prob = mean. The products are 0.1,0.4,0.9 and 1.6. Sum = 0.1+ 0.4 + 0.9 + 1.6. Mean = 3

Question 6 :

A web site (www.medicine.ox.ac.uk/bandolier/band64/b64-7.html) for home pregnancy tests cites the following: “When the subjects using the test were women who collected and tested their own samples, the overall sensitivity was 75%. Specificity was also low, in the range 52% to 75%.” Assume the lower value for the specificity. Suppose a subject has a positive test and that 30% of women taking pregnancy tests are actually pregnant. What number is closest to the probability of pregnancy given the positive test?

(Hints, watch Lecture 3 at around 7 minutes for a similar example. Also, there's a lot of Bayes' rule problems and descriptions out there, for example here's one for HIV testing. Note, discussions of Bayes' rule can get pretty heady. So if it's new to you, stick to basic treatments of the problem. Also see Chapter 3 Question 5.)

Options :

- 30%
- 40%
- 20%
- 10%

Solution :

p(+|Preg) = 0.75

P(-|Not Preg) = 0.52

p(Preg) = 0.3

p(preg|+) = ?

p(preg|+) = p(+|preg) * p(preg)/(P(+|Preg)*p(preg)+P(+|not preg)*P(not preg)

We dont have values for P(+|not preg) and P(not preg). Hence we will re-write as follows.

p(preg|+) = p(+|preg) * p(preg)/(P(+|Preg)*p(preg)+(1-P(-|not preg))*(1-P(preg))

p(preg|+) = 0.75 * 0.3/(0.75*0.3)+(1-0.52)*(1-0.3)

           = 0.225 /(0.225 + 0.336)
           = 0.225 / 0.561
		       = 0.401069518
