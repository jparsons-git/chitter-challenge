require 'pg'

class User

  attr_reader :id, :name, :email, :username, :password


  def initialize(id:, name:, email:, username:, password:)
    @id  = id
    @name = name
    @email = email
    @username = username
    @password = password
  end

  def self.adduser(name, email, username, password)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_manager_test')
    else
      connection = PG.connect(dbname: 'chitter_manager')
    end

    connection.exec_params(
      result = "INSERT INTO users (name, email, username, password) VALUES ($1, $2, $3, $4) RETURNING id, name, email, username, password;",
      [name, email, username, password])
      # p result
    User.new(id: result[0]['id'], name: result[0]['name'], email: result[0]['email'], username: result[0]['username'], password: result[0]['password'])  
  end  

  def self.validuser(username, password)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_manager_test')
    else
      connection = PG.connect(dbname: 'chitter_manager')
    end

    # a = "Janie-P"
    # b = "jane11"

    #result = connection.exec("SELECT * FROM users WHERE(username: 'Janie-P', password: 'jane11');")
    count = connection.exec("SELECT COUNT(*) FROM users WHERE username: = 'Janie-P' AND password: = 'jane11';")

    # SELECT * FROM users WHERE username = 'Janie-P' AND password = 'jane11';
    # User.where(category: "Ruby", author: "Jesus Castello")

    if count != 1
      nil
    else  
      result = connection.exec("SELECT * FROM users WHERE username = 'Janie-P' AND password = 'jane11';")    
      result.map do |thingamy|
        # count += 1
        # p "thangamy #{count}"
        User.new(id: thingamy['id'], name: thingamy['name'], email: thingamy['email'], username: thingamy['username'], password: thingamy['password'])
      end
    end   
  end

end  
