require 'rubygems'
require 'sinatra'
require 'twitter_classifier'
require 'haml_helper'

include HamlHelper

classifier = TwitterClassifier.new "twitter_spam.kf"
enable :sessions

@@cache = {}

def cache(user,how_spammy=nil)
	@@cache[user] = how_spammy unless how_spammy.nil?
  @@cache[user]
end

get '/' do
  haml :index, :locals => { :username => params[:username] }
end

get '/check' do
  how_spammy = cache(params[:username])
  how_spammy = classifier.how_spammy(params[:username]) if how_spammy.nil?
  cache(params[:username],how_spammy)
  (how_spammy * 100).round().to_s
end