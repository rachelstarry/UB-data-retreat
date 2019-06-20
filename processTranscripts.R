library(tidyverse)
library(quanteda)
library(tokenizers)

# SAMPLE TEXT PROCESSING (quanteda) ----
# Read in sample text files
sample1 <- read_lines("data/sample1911.txt") %>% paste0(collapse = "")
sample2 <- read_lines("data/sample1915.txt") %>% paste0(collapse = "")

# Tokenize sample texts, removing numbers and punctuation
s1_words <- tokens(sample1, remove_numbers = TRUE, remove_punct = TRUE, remove_hyphens = FALSE)
s2_words <- tokens(sample2, remove_numbers = TRUE, remove_punct = TRUE, remove_hyphens = FALSE)

s1_sentences <- tokens(sample1, remove_numbers = TRUE, what = "sentence")
s2_sentences <- tokens(sample2, remove_numbers = TRUE, what = "sentence")

# Generate bi-grams and tri-grams for each sample text
s1_ngrams <- tokens_ngrams(s1_words, n = 2:3)
s2_ngrams <- tokens_ngrams(s2_words, n = 2:3)

# Create a document-feature matrix with sample texts
docs <- c(paste0(s1_words$text1, collapse=" "), paste0(s2_words$text1, collapse=" "))
doc_term_matrix <- dfm(docs, stem = FALSE, tolower = TRUE, remove = stopwords())

# SAMPLE CORPUS ANALYSIS (quanteda) ----
# Simple frequency analysis
feature_freq <- textstat_frequency(doc_term_matrix, n = 100)

# Lexical diversity calculation
lexdiv <- textstat_lexdiv(doc_term_matrix)

# Relative frequency analysis ("keyness" = association scores for frequent words in a target and reference group)
keyness <- textstat_keyness(doc_term_matrix, target = doc_term_matrix@Dimnames$docs[2])
textplot_keyness(keyness)

# Collocation analysis
proper_names1 <- tokens(sample1) %>% 
  tokens_select(pattern = '^[A-Z]', valuetype = 'regex', case_insensitive = FALSE, padding = TRUE) %>% 
  textstat_collocations(min_count = 4)
proper_names2 <- tokens(sample2) %>% 
  tokens_select(pattern = '^[A-Z]', valuetype = 'regex', case_insensitive = FALSE, padding = TRUE) %>% 
  textstat_collocations(min_count = 4)

# SAMPLE TEXT PROCESSING (manual) ----
# Function to clean sample texts
clean_sample <- function(text) {
  # Remove blank lines
  indexes <- which(text == "" | text == " ")
  if (length(indexes) > 0) {
    text <- text[-indexes]
  }
  
  # Loop through remaining lines, performing additional cleanup
  clean_text <- NULL
  for (i in 1:length(text)) {
    # Text cleanup
    temp <- text[i] %>% 
      tolower() %>% 
      #str_replace_all("\\p{quotation mark}", "") %>%
      str_replace_all("[:punct:]", "") %>% 
      trimws()
    
    clean_text <- c(clean_text, temp)
  }
  return(clean_text)
}

# Read in, clean, and output sample texts
sample3 <- read_lines("data/sample1911.txt")
sample4 <- read_lines("data/sample1915.txt")

sample3_clean <- clean_sample(sample3) %>% paste0(collapse = " ") %>% str_replace_all("\\s+", " ")
write_lines(sample3_clean, "data/sample1911_processed.txt")

sample4_clean <- clean_sample(sample4) %>% paste0(collapse = " ") %>% str_replace_all("\\s+", " ")
write_lines(sample4_clean, "data/sample1915_processed.txt")

# SAMPLE TEXT PROCESSING (tokenizers) ----
