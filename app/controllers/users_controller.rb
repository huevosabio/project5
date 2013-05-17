require 'digest/sha1'

class UsersController < ApplicationController
  def index
      @title = "User Index"
      @all_users = User.all
  end
  
  def login
      #displays a simple login form where the user
      #can enter their login name, no password yet
      @title = "Login"
  end
  
  def post_login
      user = User.find_by_login(params[:user][:username])
      if user
          user.password = params[:user][:password]
          if user.password_valid?
            session[:id] = user.id
            session[:name] = user.first_name
            redirect_to(:controller => 'photo', :action => 'index', :id => session[:id])
          else
            redirect_to :back, :flash => {:message =>'Invalid login, please try again'}
          end
      else
          redirect_to :back, :flash => {:message =>'Invalid login, please try again'}
      end
  end
  
  def logout
      reset_session
      redirect_to(:action => 'login')
  end
  
  def new
      @title = "Create a Username and Password"
  end
  
  def create
      user = User.find_by_login(params[:user][:username])
      if user
          redirect_to(:back, :flash => {:message =>'Sorry, username is already in use'})
      else
          salt = rand(10).to_s
          password = params[:user][:password]
          digest = Digest::SHA1.hexdigest(password+salt)
          user = User.new(:first_name => params[:user][:first_name], :last_name => params[:user][:last_name], :login => params[:user][:username], :salt => salt, :password_digest => digest)
          if user.save
              session[:id] = user.id
              session[:name] = user.first_name
              redirect_to(:controller => 'photo', :action => 'index', :id => session[:id])
          else
              redirect_to(:back, :flash => {:message => 'Sorry, something went wrong'})
          end
      end
  end
  
end
