require 'pg'
require 'date'

class Peep

  attr_reader :id, :details, :date, :userid, :username

  def initialize(id:, details:, date:, userid:, username:)
    @id  = id
    @details = details
    @date = date
    @userid = userid
    @username = username
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_manager_test')
    else
      connection = PG.connect(dbname: 'chitter_manager')
    end

    result = connection.exec("SELECT * FROM peeps ORDER BY date DESC;")
    count = 0
    result.map do |thangamy|
      Peep.new(id: thangamy['id'], details: thangamy['details'], 
      date: thangamy['date'], userid: thangamy['userid'], username: thangamy['username'])
    end
  end

  def self.add(details, userid, username)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_manager_test')
    else
      connection = PG.connect(dbname: 'chitter_manager')
    end

    current_time = DateTime.now
    current_time.strftime "%Y.%m.%d %H:%M" + ":00"
    date = current_time.strftime "%Y.%m.%d %H:%M" + ":00"

    connection.exec_params(
      result = "INSERT INTO peeps (details, date, userid, username) VALUES ($1, $2, $3, $4) RETURNING id, details, date, userid, username;",
      [details, date, userid, username])
  end  

  private

  def get_date
    current_time = DateTime.now
    current_time.strftime "%Y.%m.%d %H:%M" + ":00"
    @date = current_time.strftime "%Y.%m.%d %H:%M" + ":00"
  end  

end
