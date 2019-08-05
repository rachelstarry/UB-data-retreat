# Install packages (only run these lines ONCE)
install.packages("stringr")

# Load the packages into our working environment
library(stringr)

# String manipulation in R ----
# Source: https://www.hackerearth.com/practice/machine-learning/advanced-techniques/regular-expressions-string-manipulation-r/tutorial/

# Strings in R: any value enclosed in " "
text <- "san francisco"
typeof(text)

num <- c("24","34","36")
typeof(num)

realnum <- c(1:10)
typeof(realnum)
realnum <- toString(num)
typeof(numnum)

# A few base R string functions
nchar(text)
toupper(text)
tolower(text)

string <- "Los Angeles, officially the City of Los Angeles and often known by its initials L.A., is the second-most populous city in the United States (after New York City), the most populous city in California and the county seat of Los Angeles County. Situated in Southern California, Los Angeles is known for its Mediterranean climate, ethnic diversity, sprawling metropolis, and as a major center of the American entertainment industry."
typeof(string)

# All functions in stringr start with str_ and operate on a vector of strings
# Some stringr functions perform the same tasks as the base R functions above

# count number of characters
nchar(string)
str_length(string)

# convert to lower
tolower(string)
str_to_lower(string)

# convert to upper
toupper(string)
str_to_upper(string)

# RegEX in Base R ----
# Source: https://rpubs.com/lakenp/regex1

# Base R's grepl() function returns a boolean value (T/F) reflecting whether the pattern is matched
words = c("statistics", "estate", "castrate", "catalyst", "banana")
grepl(pattern = "stat", x = words)

# Regex are case sensitive
grepl(pattern = "stat", x = "Statistics")
grepl(pattern = "stat", x = "Statistics", ignore.case = TRUE)

# grep() and grepl()
sentences = c("I like statistics", "I like bananas", "Estates and statues are expensive")
grep("stat", sentences)

grep("stat", sentences, value = TRUE)

grepl("stat", sentences)

# Parentheses matter with strings/regex
grepl("like", sentences)

grepl("are", sentences)

grepl("(are|like)", sentences)

# regexpr() and gregexpr()
regexpr("stat", sentences)

gregexpr("stat", sentences)

# sub() and gsub()
sub(pattern = "I", replacement = "You", sentences)

sub(pattern = " ", replacement = "_", sentences)

gsub(pattern = " ", replacement = "_", sentences)

# Let's try sub() and gsub() with our earlier string example
# find and replace first match, regardless of case
sub(pattern = "L", replacement = "B", string, ignore.case = T)

# find and replace all matches, regardless of case
gsub(pattern = "Los", replacement = "Bos", string, ignore.case = T)

# RegEx Practice ----

# Metacharacters
# Metacharacters are special characters that won't be detected unless prefixed with double backslash \\
# Metacharacters in R: . \ | ( ) [ ] { } $ * + ?
dt <- c("percent%", "percent")
grep(pattern = "percent\\%", dt, value = T)

dt <- c("may?", "money$", "and&")
grep(pattern = "[a-z][\\?-\\$-\\&]", dt, value = T)

gsub(pattern = "[\\?-\\$-\\&]", replacement = "", dt)

gsub(pattern = "\\\\", replacement = "-", "Barcelona\\Spain")

# Quantifiers
# Quantifiers help determine the length of the resulting match
names <- c("anna", "crissy", "puerto", "cristian", "garcia", "steven", "alex", "rudy")

# . matches every character except newline
grep(pattern = "e.", names, value = T)

# + matches the character to its left 1 or more times
grep(pattern = "t+", names, value = T)

# specify {n} to match n exactly two times
grep(pattern = "s{2}", names, value = T)

# how would you match all names with at least two As?
# how would you match "anna" but not "garcia"?

# Sequences
# Sequences contain special characters used to describe a pattern in a string
string <- "I have been to Paris 20 times"

# match a digit
gsub(pattern = "\\d+", replacement = "_", string)
regmatches(string, regexpr(pattern = "\\d+", string))

# match a non-digit
gsub(pattern = "\\D+", replacement = "_", string)
regmatches(string, regexpr(pattern = "\\D+", string))

# match a space - returns positions
gregexpr(pattern = "\\s+", string)

# match a non space
gsub(pattern = "\\S+", replacement = "word", string)

# match a word character
gsub(pattern = "\\w", replacement = "c", string)

# match a non-word character
gsub(pattern = "\\W",replacement = "_", string)  

# Character Classes
# Character classes are characters enclosed in [] - they match only the characters in the brackets
string <- "20 students went to Paris; 14 went to London"

# extract numbers
regmatches(string, gregexpr("[0-9]+", string))

# extract non-numeric words
regmatches(string, gregexpr("[a-zA-Z]+", string))  

# POSIX character classes are special character classes
string <- c("I sleep 16 hours\n, a day","I sleep 8 hours\n a day.","You sleep how many\t hours ?")

# get digits
unlist(regmatches(string, gregexpr("[[:digit:]]+", string)))

# remove punctuations
gsub(pattern = "[[:punct:]]+", replacement = "", string)

# remove spaces
gsub(pattern = "[[:blank:]]", replacement = "_", string)

# remove control characters
gsub(pattern = "[[:cntrl:]]+", replacement = "", string)

# remove non-alphanumeric characters
gsub(pattern = "[^[:alnum:]]+", replacement = "", string)

# Exercises ----
# A) Extract all the digits from this string
string <- "My roll number is 1006781"

# B) Find out if the values "A1" and "A4" are present in this string
string <- c("A1","A2","A3","A4","A5","A6","A7")

# C) Given these key-value pairs, extract only the values
string <-  c("G1:E001", "G2:E002", "G3:E003")

# D) Remove all the punctuation from this string
string <- "a1~!@#$%^&*bcd(){}_+:efg\"<>?,./;'[]-="

# E) Extract the email addresses from this string
string <- c("My email address is abc@boeing.com", "my email address is def@jobs.com", "aescher koeif", "paul renne")