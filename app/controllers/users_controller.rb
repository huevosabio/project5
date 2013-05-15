class UsersController < ApplicationController
  def index
      @title = "User Index"
      @all_users = User.all
  end
end
