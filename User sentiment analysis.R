rm(list = ls())

# Install Requried Packages
install.packages("SnowballC")
install.packages("tm")
install.packages("twitteR")
install.packages("syuzhet")

# Load Requried Packages
library("SnowballC")
library("tm")
library("twitteR")
library("syuzhet")

# Authentication keys
consumer_key <- 'Getyourownkeys'
consumer_secret <- 'Getyourownkeys'
access_token <- 'ABCDEFGHIJKLMNO'
access_secret <- 'ABCDEFGHIJKLMNO'

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

tweets <- userTimeline("realdonaldtrump", n=200)
n.tweet <- length(tweets)

tweets.df <- twListToDF(tweets) 
head(tweets.df)

tweets.df2 <- gsub("http.*","",tweets.df$text)
tweets.df2 <- gsub("https.*","",tweets.df2)
tweets.df2 <- gsub("#.*","",tweets.df2)
tweets.df2 <- gsub("@.*","",tweets.df2)

word.df <- as.vector(tweets.df2)

emotion.df <- get_nrc_sentiment(word.df)

emotion.df2 <- cbind(tweets.df2, emotion.df) 
head(emotion.df2)

sent.value <- get_sentiment(word.df)
head(sent.value)

most.positive <- word.df[sent.value == max(sent.value)]
head(most.positive)

most.negative <- word.df[sent.value <= min(sent.value)] 
head(most.negative)

positive.tweets <- word.df[sent.value > 0]
head(positive.tweets)

negative.tweets <- word.df[sent.value < 0] 
head(negative.tweets)

neutral.tweets <- word.df[sent.value == 0]
head(neutral.tweets)

# Alternate way to classify as Positive, Negative or Neutral tweets
category_senti <- ifelse(sent.value < 0, "Negative", ifelse(sent.value > 0, "Positive", "Neutral"))
head(category_senti)
table(category_senti)


# value_senti <- ifelse(sent.value < 0, -1, ifelse(sent.value > 0,1,0))
# Data<-data.frame(as.Date(tweets.df$created,format='%Y-%m-%d %H:%M:%S'),value_senti)
# plot(Data,type='h',col=c('red','blue','green'))
