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
          session[:id] = user.id
          session[:name] = user.first_name
          redirect_to(:controller => 'photo', :action => 'index', :id => session[:id])
      else
          redirect_to :back, :flash => {:message =>'Invalid login, please try again'}
      end
  end
  
  def logout
      reset_session
      redirect_to(:action => 'login')
  end
  
end
