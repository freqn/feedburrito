require_relative './services/rest_client.rb'
require 'active_support/all'

USERNAME = '' # Twitter username (without @)
DURATION = 0 # Preserve a duration of activitiy (from now)

class FeedCleaner
  include Service
  attr_reader :client

  def initialize
    @client = Service::RestClient.authenticate
  end

  def clean
    statuses = timeline

    statuses.each do |s| 
      s_time = convert(s.created_at)
      if s_time < DURATION.days.ago
        purge(s)
      end
    end
  end

  private

  def timeline
    client.user_timeline(USERNAME, {:count => 200}) 
  end

  def convert(time)
    time.to_time.iso8601
  end

  def purge(tweet)
    client.destroy_tweet(tweet.id)
  end
end

FeedCleaner.new.clean