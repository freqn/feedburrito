require 'twitter'

module Service
  class Client
    def self.authenticate
      Twitter::REST::Client.new do |config|
        config.consumer_key         = ENV['TWITTER_API_KEY']
        config.consumer_secret      = ENV['TWITTER_API_SECRET']
        config.access_token         = ENV['TWITTER_API_TOKEN']
        config.access_token_secret  = ENV['TWITTER_API_TOKEN_SECRET']
      end
    end
  end
end