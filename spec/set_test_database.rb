# this should clear down the database before running each test

require 'pg'

# p "Setting up test database..."

def setup_test_database
  connection = PG.connect(dbname: 'chitter_manager_test')
  # Clear the chitter tables
  connection.exec("TRUNCATE peeps;")
  connection.exec("TRUNCATE users;")
end
