library(hunspell)
library(tidytext)
library(tidyverse)
library(pdftools)
library(SnowballC)
library(viridis)
library(wordcloud)

data(stop_words)
keep_words <- data.frame(word = c("open"))
stop_words <- stop_words %>% 
  dplyr::anti_join(keep_words)
exclude_words <- data.frame(word = c("2012", "2013", "2014", "2015", "2016", 
                                     "http", "https"))

pdf_file <- "data/ki0217113enn.pdf"

# Get info
info <- pdftools::pdf_info(pdf_file)
# Read in data
txt <- pdftools::pdf_text(pdf_file)
txt_df <- dplyr::data_frame(page = 1:length(txt), 
                            text = txt)

txt_df <- txt_df %>% 
  tidytext::unnest_tokens(word, text) %>% 
  anti_join(stop_words) %>% 
  anti_join(exclude_words)


wordcloud::wordcloud(txt_df$word, max.words = 50, random.order = FALSE,
                     random.color = TRUE, 
                     colors = viridis::viridis(8))

