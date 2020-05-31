# Week2 Quiz

######Question 1

Under the lattice graphics system, what do the primary plotting functions like xyplot() and bwplot() return?

- an object of class "lattice"

- an object of class "trellis"

- nothing; only a plot is made

- an object of class "plot"

Ans :

```R
library(nlme)
library(lattice)

plot <- xyplot(weight ~ Time | Diet,BodyWeight)
class(plot)
# "trellis"
```

- an object of class "trellis"

######Question 2

What is produced by the following code?

```R
library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet,BodyWeight)
```


- A set of 16 panels showing the relationship between weight and time for each rat.

- A set of 3 panels showing the relationship between weight and time for each rat.

- A set of 11 panels showing the relationship between weight and diet for each time.

- A set of 3 panels showing the relationship between weight and time for each diet.

Answer :

- A set of 3 panels showing the relationship between weight and time for each diet.
- Link to Images

######Question 3

Annotation of plots in any plotting system involves adding points, lines, or text to the plot, in addition to customizing axis labels or adding titles. Different plotting systems have different sets of functions for annotating plots in this way.

Which of the following functions can be used to annotate the panels in a multi-panel lattice plot?

- panel.lmline()

- axis()

- points()

- lines()

Ans :

- panel.lmline()

######Question 4

The following code does NOT result in a plot appearing on the screen device.

```R
library(lattice)
library(datasets)
data(airquality)
p <- xyplot(Ozone ~ Wind | factor(Month), data = airquality)
```

Which of the following is an explanation for why no plot appears?

- There is a syntax error in the call to xyplot().

- The variables being plotted are not found in that dataset.

- The object 'p' has not yet been printed with the appropriate print method.

- The xyplot() function, by default, sends plots to the PDF device.

Ans :

- The object 'p' has not yet been printed with the appropriate print method.

######Question 5

In the lattice system, which of the following functions can be used to finely control the appearance of all lattice plots?

- splom()

- par()

- print.trellis()

- trellis.par.set()

Ans :

- trellis.par.set()

######Question 6

What is ggplot2 an implementation of?

- the S language originally developed by Bell Labs

- the base plotting system in R

- a 3D visualization system

- the Grammar of Graphics developed by Leland Wilkinson

Ans :

- the Grammar of Graphics developed by Leland Wilkinson

######Question 7

Load the `airquality' dataset form the datasets package in R

```R
library(datasets)
data(airquality)
```

I am interested in examining how the relationship between ozone and wind speed varies across each month. What would be the appropriate code to visualize that using ggplot2?

```R
qplot(Wind,Ozone,data=airquality,facets = . ~ factor(Month))

qplot(Wind,Ozone,data=airquality,geom = "smooth")

airquality = transform(airquality, Month = factor(Month))
qplot(Wind,Ozone,data=airquality,facets = Month)

qplot(Wind,Ozone,data=airquality)
```

Ans :

With new version of ggplot, both 1 and 3 produces the same result.

```R
qplot(Wind,Ozone,data=airquality,facets = . ~ factor(Month))
```

- Link to Images

######Question 8

What is a geom in the ggplot2 system?

- a method for making conditioning plots

- a method for mapping data to attributes like color and size

- a statistical transformation

- a plotting object like point, line, or other shape

Ans :

- a plotting object like point, line, or other shape

######Question 9

When I run the following code I get an error:

```R
library(ggplot2)
library(ggplot2movies)
g <- ggplot(movies, aes(votes, rating))
print(g)
```

I was expecting a scatterplot of 'votes' and 'rating' to appear. What's the problem?

- The object 'g' does not have a print method.

- ggplot does not yet know what type of layer to add to the plot.

- There is a syntax error in the call to ggplot.

- The dataset is too large and hence cannot be plotted to the screen.

Ans :

- ggplot does not yet know what type of layer to add to the plot.

######Question 10

The following code creates a scatterplot of 'votes' and 'rating' from the movies dataset in the ggplot2 package. After loading the ggplot2 package with the library() function, I can run

```R
qplot(votes, rating, data = movies)
```

How can I modify the the code above to add a smoother to the scatterplot?

```R
qplot(votes, rating, data = movies) + stats_smooth("loess")
```

```R
qplot(votes, rating, data = movies, panel = panel.loess) 
```

```R
qplot(votes, rating, data = movies ,smooth = "loess")
```

```R
qplot(votes, rating, data = movies) + geom_smooth()
```


Ans :

```R
qplot(votes, rating, data = movies) + geom_smooth()
```

- Link to Images