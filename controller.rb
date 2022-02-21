
require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/peep'
require_relative './lib/user.rb'

class ChitterManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/peeps' do
    $peeps = Peep.all
    @peeps = $peeps
    @currentuser = $currentuser
    @userloggedin = $userloggedin 
    erb :'peeps/index'
  end

  post '/signin' do
    @username = params[:username]
    @password = params[:password]
    @peeps = $peeps

    this_user = User.validuser(@username, @password)

    if this_user != nil && this_user['username'] == @username &&  this_user['password'] == @password 
      
      $loggedinuser = User.new(id: this_user['id'], name: this_user['name'], email: this_user['email'], username: this_user['username'], password: this_user['password'])  
      
      @loggedinuser = $loggedinuser
      $currentuser = @username 
      $userloggedin = true
      $signin_error = false
      $signin_err_msg = ""
      $peeps = @peeps
    else
      $peeps = @peeps
      $currentuser = nil
      $userloggedin = false
      $signin_error = true
      $signin_err_msg = "Invalid username or password, please try again"
      $loggedinuser = nil
    end    

    redirect '/completed'
  end

  post '/register' do
    @name = params[:newname]
    @email = params[:newemail]
    @username = params[:newusername]
    @password = params[:newpassword]
    @peeps = $peeps
  
    User.adduser(@name, @email, @username, @password)
    this_user = User.validuser(@username, @password)

    $loggedinuser = User.new(id: this_user['id'], name: this_user['name'], email: this_user['email'], username: this_user['username'], password: this_user['password'])  
    $currentuser = @username
    $userloggedin = true
    $peeps = @peeps

    redirect '/completed'
  end

  post '/postpeep' do
    details = params[:confirmationText]
    @loggedinuser = $loggedinuser
    Peep.add(details, @loggedinuser.id, @loggedinuser.username)
    $peeps = Peep.all
    redirect '/completed'
  end  

  post '/signout' do
    @peeps = $peeps 
    $currentuser = nil
    $userloggedin = false
    $loggedinuser = nil
    $peeps = @peeps
    @currentuser = nil
    @userloggedin = false
    @loggedinuser = nil

    redirect '/completed'
  end

  get '/completed' do
    @peeps = $peeps
    @currentuser = $currentuser
    @userloggedin = $userloggedin
    @loggedinuser = $loggedinuser
    @signin_error = $signin_error
    @signin_err_mg = $signin_err_msg 
    erb :'peeps/index'
  end  

  run! if app_file == $0
end
