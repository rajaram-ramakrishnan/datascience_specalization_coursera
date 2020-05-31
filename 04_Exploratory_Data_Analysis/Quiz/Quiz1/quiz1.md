# Week1 Quiz

###### Question 1

Which of the following is a principle of analytic graphics?

- Don't plot more than two variables at at time

- Show box plots (univariate summaries)

- Only do what your tools allow you to do

- Integrate multiple modes of evidence

- Make judicious use of color in your scatterplots

Ans:

- Integrate multiple modes of evidence

###### Question 2

What is the role of exploratory graphs in data analysis?

- The goal is for personal understanding.

- Axes, legends, and other details are clean and exactly detailed.

- Only a few are constructed.

- They are used in place of formal modeling.

Ans :

- The goal is for personal understanding.

###### Question 3

Which of the following is true about the base plotting system?

- The system is most useful for conditioning plots

- Margins and spacings are adjusted automatically depending on the type of plot and the data

- Plots are typically created with a single function call

- Plots are created and annotated with separate functions

Ans :

- Plots are created and annotated with separate functions

Functions like 'plot' or 'hist' typically create the plot on the graphics device and functions like 'lines', 'text', or 'points' will annotate or add data to the plot.

###### Question 4

Which of the following is an example of a valid graphics device in R?

- A socket connection

- A file folder

- The computer screen

- A Microsoft Word document

- The keyboard

Ans :

- The computer screen

###### Question 5

Which of the following is an example of a vector graphics device in R?

- Postscript

- JPEG

- PNG

- TIFF

- GIF

Ans :

- Postscript


###### Question 6

Bitmapped file formats can be most useful for

- Plots that are not scaled to a specific resolution

- Scatterplots with many many points

- Plots that may need to be resized

- Plots that require animation or interactivity

Ans :

- Scatterplots with many many points

###### Question 7

Which of the following functions is typically used to add elements to a plot in the base graphics system?

- plot()

- lines()

- hist()

- boxplot()

Ans :

- lines()


###### Question 8

Which function opens the screen graphics device on Windows?

- postscript()

- jpeg()

- windows()

- xfig()

Ans :

- windows()

###### Question 9

What does the 'pch' option to par() control?

- the plotting symbol/character in the base graphics system

- the orientation of the axis labels on the plot

- the size of the plotting symbol in a scatterplot

- the line width in the base graphics system

Ans :

- the plotting symbol/character in the base graphics system


###### Question 10

If I want to save a plot to a PDF file, which of the following is a correct way of doing that?

- Construct the plot on the PNG device with png(), then copy it to a PDF with dev.copy2pdf().

- Open the PostScript device with postscript(), construct the plot, then close the device with dev.off().

- Open the screen device with quartz(), construct the plot, and then close the device with dev.off().

- Construct the plot on the screen device and then copy it to a PDF file with dev.copy2pdf()

Ans :

- Construct the plot on the screen device and then copy it to a PDF file with dev.copy2pdf()

