# Install packages (only run these lines ONCE; erase the # to "uncomment" these lines and run them)
# install.packages("tidyverse")
# install.packages("tokenizers")

# Load the packages into our working environment
library(tidyverse)
library(tokenizers)

# Basic text cleaning in R ----
# Source: https://www.mjdenny.com/Text_Processing_In_R.html 

# Example commands
string <- "Example STRING, with example numbers (12, 15 and also 10.2)?!"

# lowercase the entire string
temp <- tolower(string)
temp

# remove everything that is not a word - what regex do we need here?
temp <- str_replace_all(temp, "[^a-zA-Z\\s]", " ")
temp

# remove any extra spaces between words
temp <- str_replace_all(temp, "[\\s]+", " ")
temp

# tokenize the string (split it into individual words)
temp <- str_split(temp, " ")[[1]]
temp

# is there anything left to fix? 

# ...
indexes <- which(temp == "") # find any indexes in the character vector where "" is stored
if(length(indexes) > 0) {
  temp <- temp[-indexes] # grab the subset of the character vector without those indexes
} 

# Create a function to automate this workflow
clean_text <- function(string) {
  temp <- tolower(string)
  temp <- str_replace_all(temp, "[^a-zA-Z0-9\\s\\.]", " ")
  temp <- str_replace_all(temp, "[\\s]+", " ")
  temp <- trimws(temp)
  temp <- str_split(temp, " ")[[1]]
  return(temp)
}

# Test out our new function on some other strings
sentence <- "The term 'data science' (originally used interchangeably with 'datalogy') has existed for over thirty years and was used initially as a substitute for computer science by Peter Naur in 1960."
clean_sentence <- clean_text(sentence)

sentence <- paste("Now, I understand that because it's an election season",
                  "expectations for what we will achieve this year are low.",
                  "But, Mister Speaker, I appreciate the constructive approach",
                  "that you and other leaders took at the end of last year",
                  "to pass a budget and make tax cuts permanent for working",
                  "families. So I hope we can work together this year on some",
                  "bipartisan priorities like criminal justice reform and",
                  "helping people who are battling prescription drug abuse",
                  "and heroin abuse. So, who knows, we might surprise the",
                  "cynics again")
clean_sentence <- clean_text(sentence)

# what problems did our function not anticipate? 

# Text processing with tokenizers ----
# The tokenizers package automates the cleaning and tokenization of text
words <- tokenize_words(sentence)

length(words)
length(words[[1]])

# We can also use the data structure "tibble" from the tidyverse package to store our clean text
tab <- table(words[[1]])
tab <- data_frame(word = names(tab), count = as.numeric(tab))
tab

arrange(tab, desc(count))

# The tokenizers package also lets us split text into sentences rather than words
s <- tokenize_sentences(sentence)
s

s_words <- tokenize_words(s[[1]])
s_words

# Let's try with a longer text
# But first, let's clean our workspace by removing all variables
rm(list=ls())

# read in text from file
text <- read_lines("data/inaugural_speeches/inaugural_speeches/57_obama_2009.txt")

# tokenize text
words <- tokenize_words(text)
length(words[[1]])

tab <- table(words[[1]])
tab <- data_frame(word = names(tab), count = as.numeric(tab))
tab <- arrange(tab, desc(count))
tab

# Load word frequency dataset 
base_url <- "https://programminghistorian.org/assets/basic-text-processing-in-r"
wf <- read_csv(sprintf("%s/%s", base_url, "word_frequency.csv"))
wf

# Join the word frequency dataset with our text tibble
tab <- inner_join(tab, wf)
tab

# Let's see what words are more commonly used in our text than in the English Google Web Corpus
filter(tab, frequency < 0.1)

print(filter(tab, frequency < 0.002), n = 15) # the 15 most commonly used, unique words in this text

# We could contextualize this information if we have additional metadata about US presidential inaugural speeches
# (we do)
metadata <- read_csv("data/inaugural_speeches/inaugural_metadata.csv")
metadata

# summarize the top 5 most used words with frequency less than 0.002% in a general English corpus
tab <- filter(tab, frequency < 0.002)
result <- c(metadata$president[57], metadata$date[57], tab$word[1:5])
paste(result, collapse = "; ")

# Corpus analysis with tokenizers and tidyverse ----
# Using the same methods, we can analyze a large set of texts all at once

# Read in text files - set variable input_loc to be the full path of the directory where your data is
input_loc <- "data/inaugural_speeches/inaugural_speeches"

files <- dir(input_loc, full.names = TRUE)
text <- c()
for (f in files) {
  text <- c(text, paste(readLines(f), collapse = "\n"))
}

words <- tokenize_words(text)
sapply(words, length)

# plot the number of words in each text by year
qplot(metadata$year, sapply(words, length))
qplot(metadata$year, sapply(words, length), color = metadata$party)

# Stylometric analysis
sentences <- tokenize_sentences(text)
s_words <- sapply(sentences, tokenize_words)

s_length <- list()
for (i in 1:nrow(metadata)) {
  s_length[[i]] <- sapply(s_words[[i]], length)
}
s_length_median <- sapply(s_length, median)

qplot(metadata$year, s_length_median)
qplot(metadata$year, s_length_median) + geom_smooth()

# Summarize word frequencies for all documents in the corpus
description <- c()
for (i in 1:length(words)) {
  tab <- table(words[[i]])
  tab <- data_frame(word = names(tab), count = as.numeric(tab))
  tab <- arrange(tab, desc(count))
  tab <- inner_join(tab, wf)
  tab <- filter(tab, frequency < 0.002)
  
  result <- c(metadata$president[i], metadata$party[i], metadata$year[i], tab$word[1:5])
  description <- c(description, paste(result, collapse = "; "))
}