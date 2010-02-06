Twitter Spam
--------------

-Knowledge File

TwitterSpam relies on a bishop knowledge file to initialize its bayesian filter.  
By default it looks for the file named twitter_spam.kf.  To initialize the default
knowledge file execute ./init_knowledge_file.sh in the root directory of TwitterSpam.  

Specific Twitter users are mentioned in this file as sources of sample comments.  
If you want to use different users then modify the ./get_tweets.rb lines inside 
init_knowledge_file.sh.



-Gems

Twitter Spam depends on the following gems 
(the latest version of each should hopefully be fine, but known working versions are listed just in case)

bishop => 0.3.0
twitter => 0.6.12
haml => 2.2.6
sinatra => 0.9.2
