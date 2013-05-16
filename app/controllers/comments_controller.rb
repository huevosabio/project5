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
      comment = Comment.create(:comment => params[:comment][:comment], :photo_id => params[:comment][:photo_id], :user_id => params[:comment][:user_id])
      comment.save!
      redirect_to (:controller => 'photo', :action => 'index', :id => params[:comment][:photo_id])
  end
end
