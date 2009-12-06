require 'rubygems'
require 'sinatra'
require 'twitter_classifier'
require 'haml_helper'
require 'oauth'


include HamlHelper

classifier = TwitterClassifier.new "twitter_spam.kf"
enable :sessions

@@cache = {}

def cache(user,how_spammy=nil)
	@@cache[user] = how_spammy unless how_spammy.nil?
  @@cache[user]
end

def twitter_req_token
  OAuth::Consumer.new("YOUR TWITTER KEY","YOUR TWITTER SECRET", 
    { :site => "http://twitter.com" })
end

get '/' do
  haml :index 
end

get '/check' do
  how_spammy = cache(params[:username])
  how_spammy = classifier.how_spammy(params[:username]) if how_spammy.nil?
  cache(params[:username],how_spammy)
  (how_spammy * 100).round().to_s
end

get '/twitter_callback' do
  req_token = OAuth::RequestToken.new(Twitter.consumer, session[:twitter_request_token], session[:twitter_request_token_secret])
  access_token = req_token.get_access_token({},params[:oauth_token])
  session[:twitter_access_token] = access_token.token
  session[:twitter_token_secret] = access_token.secret
  haml :twitter_finish
end

get '/twitter' do
  req_token = twitter_req_token()
  session[:twitter_request_token] = req_token.token
  session[:twitter_request_token_secrect] = req_token.secret
  redirect_to req_token.authorize_url
end

get '/test' do
  haml :index
end
