require 'pg'

conn = PG::Connection.new(dbname: 'contacts', host: 'localhost', user: 'vagrant', password: '')

