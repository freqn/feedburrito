require_relative './services/client.rb'
require 'active_support/all'

USERNAME = '' # Twitter username (without @)
DURATION = 0 # Preserve a duration of activitiy (from now)

class Delete
  include Service
  attr_reader :client

  def initialize
    @client = Service::Client.authenticate
  end

  def clean_timeline
    statuses = fetch_timeline

    statuses.each do |s| 
      s_time = convert(s.created_at)
      if s_time < DURATION.days.ago
        purge(s)
      end
    end
  end

  private

  def fetch_timeline
    client.user_timeline(USERNAME, {:count => 200})
  end

  def convert(time)
    time.to_time.iso8601
  end

  def purge(tweet)
    client.destroy_tweet(tweet.id)
  end
end

Delete.new.clean_timeline