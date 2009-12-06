require 'twitter_classifier'
require 'optiflag'

module Args extend OptiFlagSet
  optional_flag "kf" do
    long_form "knowledge_file"
    default "twitter_spam.kf"
    description "knowledge file -- used for storing classification data"
  end

  flag "u" do
    long_form "user"
    description "the user to classify"
  end

  optional_flag "c" do
    long_form "category"
    description "The category that the user belongs to.  If this is not specified then TwitterSpam will try to guess the user's correct classification."
  end

  and_process!
end

def show_usage()
  puts "twitter_span -knowledge_file [knowledge_file] -user <user> -category [category]" 
end

knowledge_file = ARGV.flags.kf
users = ARGV.flags.u.split(',')
category = ARGV.flags.c

if users.empty? then
  show_usage()
  return
end


classifier = TwitterClassifier.new(knowledge_file)

if category then
  users.each do |user|
     classifier.classify(category,user)
     puts "#{user} is now considered #{category}"
  end
else
  users.each do |user|
    spam_pct = classifier.how_spammy(user)
    puts "#{spam_pct*100}% of #{user}'s recent tweets look like spam"
  end
end

classifier.save knowledge_file