#cnvrsl

## Requirements
You should have already read:

1. The App Flow document
2. The Campaign Manager doc

## Environment
This app is hosted on [Heroku](http://www.heroku.com/) using the Cedar stack.

## Processes
There are 3 main processes that make up this app:

### 1. CMS
The CMS uses Rails an the [ActiveAdmin](http://activeadmin.info/) gem. We selected ActiveAdmin because it's easy to get up and going quickly. At some point, we will have to build out a custom front-end for administration, but we're not there yet.

#### Worker Process
In Heroku, this processes is represented in the Procfile like so:

`web:    bundle exec rails s -p $PORT`

### 2. Tweetscan
We are using the [TweetStream](https://github.com/intridea/tweetstream) gem to hook up to the Twitter streaming API. We need to listen to this Twitter "firehose" for any Trigger (hashtag) that matches an active hashtag in the triggers table. When TweetStream finds a hashtag, it queues a PushTweet job using the Redis-backed [Resque library](https://github.com/defunkt/resque).


#### Worker Process
In Heroku, this processes is represented in the Procfile like so:

`tweetscan:  bundle exec rake tweetstream:stream --trace`


### 3. Pusher
The final process is the Pusher, which processes the Resque queue. The process should be:

1. Get an unused CouponCode (where sent = false) that corresponds to the matched Trigger for this Campaign
2. Add the CouponCode to a Message. Triggers can have multiple messages, so users aren't always seeing the same tweet being sent out.
3. Get the TwitterAccount (through the Campaign) for this Trigger , then send the Message as a tweet back to the user
4. Update the sent_to field of the CouponCode row we just sent, so we can track who the CouponCode was sent to.

#### Worker Process
In Heroku, this processes is represented in the Procfile like so:

`push:		bundle exec rake resque:work TERM_CHILD=1 RESQUE_TERM_TIMEOUT=10 QUEUES=tweets_queue --trace`
