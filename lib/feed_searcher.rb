require_relative './services/rest_client.rb'
require_relative './services/streaming_client.rb'
require 'active_support/all'
require 'time'
require 'pry'



class FeedSearcher
  include Service
  attr_reader :client, :streamer

  def initialize
    @client = Service::RestClient.authenticate
    @streamer = Service::StreamingClient.authenticate
  end

  def search 
    client.search("20% off", result_type: "recent").take(3).each do |tweet|
      puts tweet.text
    end
  end

  def stream
    id = 0
    topics = []
    streamer.filter(track: topics.join(",")) do |object|
      unless object.retweeted_tweet?
        id += 1
        t = object.created_at.in_time_zone('Eastern Time (US & Canada)')
        time = t.strftime("%Y-%m-%d %l:%M:%S %p")
        location = object.user.location.nil? ? "UNKNOWN" : object.user.location
        # puts "#{time} EST"
        # puts "User: @#{object.user.screen_name}"
        # puts "Location: #{location}"
        # puts "#{object.text}" if object.is_a?(Twitter::Tweet)
        # puts "\n"
      end
    end
  end
end

FeedSearcher.new.stream