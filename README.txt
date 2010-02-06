Twitter Spam
--------------

-Knowledge File

TwitterSpam relies on a bishop knowledge file to initialize its bayesian filter.  
By default it looks for the file named twitter_spam.kf.  To initialize the default
knowledge file execute ./init_knowledge_file.sh in the root directory of TwitterSpam.  

Specific Twitter users are mentioned in this file as sources of sample comments.  
If you want to use different users then modify the ./get_tweets.rb lines inside 
init_knowledge_file.sh.



