class PhotoController < ApplicationController
  def index
      @display_user = User.find_by_id(params["id"])
      if @display_user == nil
          @display_user = "User not Found"
          return
      else
          @display_user = @display_user.first_name + " " + @display_user.last_name
      end
      photos = Photo.find(:all, :conditions => "user_id = CAST( " + params["id"] + " AS character varying(140) )")
      dummyHash = Hash.new
      for foto in photos
        dummyHash[foto] = Array.new
        comentarios = Comment.find(:all, :conditions => ("photo_id = CAST( " + foto.id.to_s + " AS character varying(140) )"))
        for comentario in comentarios
            id = comentario.user_id
            #puts id
            usuario = User.find(id)
            #puts usuario
            username = usuario.first_name + " " + usuario.last_name
            dummyHash[foto] << {"comment" => comentario.comment, "user" => username, "userid" => id}
        end
      end
      @photos = dummyHash
  end
  
  def new
      if session[:id]
          @title = "Upload Photo"
      else
          redirect_to(:controller => 'users', :action => 'login')
      end
  end
  
  def create
      new_photo = Photo.new(:user_id => params[:photo][:user_id], :date_time => Time.now, :file_name => params[:photo][:file_name].original_filename)
      name = new_photo.file_name
      directory = "public/images/"
      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(params[:photo][:file_name].read) }
      flash[:notice] = "File uploaded"
      if new_photo.save
          redirect_to(:action => index, :id => session[:id])
      else
          redirect_to(:back, :flash => {:message => 'An error ocurred with the photo upload'})
      end
  end
end