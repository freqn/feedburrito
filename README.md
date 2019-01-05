# FeedCleaner

### Description

A simple utility to remove tweets with an optional time buffer

### Usage

1) You will need access to the Twitter API. If you don't have it already, [apply here](https://developer.twitter.com/en/apply-for-access).
2) Create an app with Twitter [here](https://developer.twitter.com/en/apps).
3) Take note of your access credentials and set your ENV variables accordingly (see *client.rb* for reference). You may also hard-code them if you don't plan to commit.
4) Assign `USERNAME` in *delete_em.rb* to your Twitter username.
5) Assign `DURATION` in *delete_em.rb* to the amount of days of activity you'd like to keep (0 for none).
6) Run `ruby delete_em.rb` from the lib directory.
