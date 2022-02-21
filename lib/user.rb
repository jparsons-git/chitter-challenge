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

  def getusername
    @username
  end

  def getpassword
    @password
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
  end  

  def self.validuser(username, password)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_manager_test')
    else
      connection = PG.connect(dbname: 'chitter_manager')
    end
    
    result = connection.exec("SELECT * FROM users;")

    valid = false  
    result.map do |thingamy|
      if thingamy['username'] == username && thingamy['password'] == password
        valid = true
        return thingamy     
      end  
    end
    return valid ? thingamy : nil
  end

end  
