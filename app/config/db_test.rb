require 'active_record'
require 'mysql2' # or 'pg' or 'sqlite3'

# Change the following to reflect your database settings
ActiveRecord::Base.establish_connection(
  adapter:  'mysql2', # or 'postgresql' or 'sqlite3'
  host:     'localhost',
  database: 'tweet_delete',
)

# Define your classes based on the database, as always
class YourModel < ActiveRecord::Base
end