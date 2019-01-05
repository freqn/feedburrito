require_relative './services/client.rb'
require 'active_support/all'

USERNAME = '' # Twitter username (without @)
DURATION = 0 # Preserve a duration of activitiy (from now)

class DeleteEm
  include Service
  attr_reader :client

  def initialize
    @client = Service::Client.authenticate
  end

  def get_timeline
    statuses = client.user_timeline(USERNAME, {:count => 200})

    statuses.each do |s| 
      s_time = convert(s.created_at)
      if s_time < DURATION.days.ago
        purge(s)
      end
    end
  end

  private

  def convert(time)
    time.to_time.iso8601
  end

  def purge(tweet)
    client.destroy_tweet(tweet.id)
  end
end

DeleteEm.new.get_timeline