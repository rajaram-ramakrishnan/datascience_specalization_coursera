Coursera JHU Data Science Specialization Capstone Project
========================================================
author: Rajaram R
date: 2021-02-07
autosize: true

Project
========================================================

This Project uses Natural Language Processing aka NLP to predict the next word when user inputs words or set of words.

The data for this project is provided by Swiftkey. Data comes in 4 different languages and there are 3 sources of data (blogs, news and twitter)

Deliverables: 

- Next Word Prediction Model App
- App hosted at shinyapps.io
- This presentation hosted at rpubs

Next Word Prediction Model
========================================================

The next word prediction model applies principles of text mining infrastructure in R . Prediction Model steps are as follows :

- Input : Data from HC Corpora Corpus
- 20% sampling is used due to huge file size and limited processing power
- Clean Training Data : Apply basic cleaning techniques(remove URLs, special characters, email address, profanity words, ordinals, white spaces) and create the data to 2 word, 3 word and 4 word data in data table
- Sort n grams data based on the frequency
- N-grams functions uses Katz's Ngram back off model to predict the next word
- Katz's backoff is a generative n-gram language model that estimates the conditional probability of a word given its history in n-gram. It accomplishes this estimation by backing off through progressively shorter history models under certain conditions. By doing so, the model with the most reliable information about a given history is used to provide the better results


Next Word Prediction App
========================================================

The next word prediction App provides a simple user interface where user can input the words and see the next predicted word.

*Features :*

- Text box for User Input
- Top 3 predicted word outputs dynamically below user input in blue color
- ? indicates no prediction
- 3 Tabs with plots of most frequent n-grams in data set
- To minimize size and runtime of model, some accuracy has been sacrificed.

Documentation and Source Code
========================================================

Data Table 

"https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html"

Text Mining in R

"http://www.jstatsoft.org/v25/i05/"

Katz's back-off model

"https://en.wikipedia.org/wiki/Katz%27s_back-off_model"

Shiny App

"https://rajaramrr.shinyapps.io/NextWordPredictionModel/"

Github source code repository

"https://github.com/rajaram-ramakrishnan/datascience_specalization_coursera/tree/master/10_Capstone_Project"



