require 'pg'
# require 'activerecord'
require 'pry'
require_relative 'contact'

conn = PG::Connection.new(dbname: 'contacts', host: 'localhost', user: 'development', password: 'development')

# Output messages from Active Record to standard out
# ActiveRecord::Base.logger = Logger.new(STDOUT)

# puts 'Establishing connection to database ...'
# ActiveRecord::Base.establish_connection(
#   adapter: 'postgresql',
#   database: 'contacts',
#   username: 'development',
#   password: 'development',
#   host: 'localhost',
#   port: 5432,
#   pool: 5,
#   encoding: 'unicode',
#   min_messages: 'error'
# )
# puts 'CONNECTED'

# puts 'Setting up Database (recreating tables) ...'

# ActiveRecord::Schema.define do
#   # drop_table :stores if ActiveRecord::Base.connection.table_exists?(:stores)
#   # drop_table :employees if ActiveRecord::Base.connection.table_exists?(:employees)
#   create_table :contacts do |c|
#     c.column :name, :string
#     c.column :email, :string
#   end
# end

# puts 'Setup DONE'