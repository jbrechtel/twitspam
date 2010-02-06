#!/bin/sh

#normal
./get_tweets.rb jbrechtel,nathanrigsby,vurlo,martinfowler,unclebobmartin,bellware,shanselman >> normal_samples.txt
./get_tweets.rb sarajchipps,steveandrews,dastels,karlseguin,chadmyers >> normal_samples.txt

#spam
./get_tweets.rb teeny_tube,porngus,mugsnjugs,ChocoStick,Social_Net_GURU >> spam_samples.txt
./get_tweets.rb brettbonham,peggy353,MarketingX,DrSocialMedia,Buy_Viagra_,rickeriksen17 >> spam_samples.txt
./get_tweets.rb SEOmachine,semajgael,finlayjudy >> spam_samples.txt
ruby seed twitter_spam.kf