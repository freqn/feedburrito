require_relative './services/rest_client.rb'
require 'active_support/all'

USERNAME = 'freqn' # Twitter USERNAME (without @)
DURATION = 0 # Sets limit to the number of days 

class FeedCleaner
  include Service
  attr_reader :client

  def initialize(client)
    @client = client
  end

  def clean
    statuses.each do |s| 
      s_time = convert(s.created_at)
      if s_time < DURATION.days.ago
        purge(s)
      end
    end
  end

  private

  def statuses
    client.user_timeline(USERNAME, {:count => 200}) 
  end

  def convert(time)
    time.to_time.iso8601
  end

  def purge(tweet)
    client.destroy_tweet(tweet.id)
  end
end
