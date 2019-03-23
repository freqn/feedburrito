require_relative './feed_cleaner.rb'

class App
  attr_reader :connection

  def initialize
    @connection = Service::RestClient.authenticate
  end

  def clean
    FeedCleaner.new(connection).clean
  end
end

App.new.clean