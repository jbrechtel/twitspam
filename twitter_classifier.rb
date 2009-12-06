require 'rubygems'
require 'bishop'
require 'twitter'

class TwitterClassifier
  NUMBER_OF_TWEETS_TO_CHECK = 100
  SPAM_THRESHOLD = 0.35
  
  def initialize(knowledge_file=nil)
    @bishop = Bishop::Bayes.new
    @bishop.load(knowledge_file) if knowledge_file
  end

  def save(knowledge_file)
    @bishop.save(knowledge_file)
  end

  
  def get_tweets(user)
    search = Twitter::Search.new(nil,{:user_agent => "TwitSpam.us"})
	search.from(user).per_page(NUMBER_OF_TWEETS_TO_CHECK).extend(Enumerable).map do |tweet| tweet.text end
  end
  
  def classify(category, user)
    tweets = get_tweets(user)
    tweets.each do |tweet| @bishop.train(category, tweet) end
  end
  
  
  
  def how_spammy(user)
    tweets = get_tweets(user)
	return -1 if tweets.nitems == 0
	
    spam_count = 0.0
    
    tweets.each do |tweet|
      results = @bishop.guess(tweet)
      normal_result = results.select do |result| result[0] == "normal" end.first
      spam_result = results.select do |result| result[0] == "spam" end.first
      spam_pct = spam_result.nil? ? 0 : spam_result[1]
      normal_pct = normal_result.nil? ? 0 : normal_result[1]
      
      
      result_difference = spam_pct || 0 - normal_pct || 0
      
      if result_difference > SPAM_THRESHOLD then spam_count = spam_count + 1 end
    end

    spam_count / tweets.nitems
  end
  
end

