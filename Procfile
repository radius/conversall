web:    bundle exec rails s -p $PORT
tweetscan:  bundle exec rake tweetstream:stream --trace
push:		bundle exec rake resque:work TERM_CHILD=1 RESQUE_TERM_TIMEOUT=10 QUEUES=tweets_queue --trace
