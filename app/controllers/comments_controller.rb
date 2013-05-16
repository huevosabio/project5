class CommentsController < ApplicationController
  def new
      if session[:id]
          @title = "New Comment"
          @photo = Photo.find_by_id(params[:id])
      else
          redirect_to (:controller => 'users', :action => 'login', :flash => {:message =>'Please login to comment on photos'})
      end
  end

  def create
      comment = Comment.new(:comment => params[:comment][:comment], :photo_id => params[:id], :user_id => params[:comment][:user_id])
      if comment.save
          redirect_to (:controller => 'photo', :action => 'index', :id => params[:comment][:photo_id])
      else
          redirect_to :back, :flash => {:message => 'Please do fill the comment text box'}
      end
      
  end
end
