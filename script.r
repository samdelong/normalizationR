library(tm)
library(SnowballC)

print("Input file name for normalizing > ")
text_file = readline(); 
email_text <- paste(readLines(text_file), collapse="\n")

# Run each normalizing regex on the file contents
email_text = gsub('[^\x01-\x7F]', '', email_text)
email_text = gsub('<.*/>', '', email_text)
email_text = removeNumbers(email_text)
email_text = gsub(' ?(f|ht)tp(s?)://(.*)[.][a-z]+', '', email_text)

# corpus magic
txt <- VectorSource(email_text)
txt.corpus <- VCorpus(txt)
txt.corpus <- tm_map(txt.corpus, content_transformer(tolower))
txt.corpus <- tm_map(txt.corpus, removeNumbers)
txt.corpus <- tm_map(txt.corpus, removePunctuation)
txt.corpus <- tm_map(txt.corpus, removeWords, stopwords("english"))
txt.corpus <- tm_map(txt.corpus, stripWhitespace); #inspect(docs[1])
txt.corpus <- tm_map(txt.corpus, stemDocument)
writeLines(as.character(txt.corpus[[1]]))
tdm <- TermDocumentMatrix(txt.corpus)

# Here is a link to the academic PDF from which the
# normalization regexes were provided
# https://www.mdpi.com/2076-3417/13/3/1971/pdf
