class PhotoController < ApplicationController
  def index
      @display_user = User.find_by_id(params["id"])
      if @display_user == nil
          @display_user = "User not Found"
          return
      else
          @display_user = @display_user.first_name + " " + @display_user.last_name
      end
      photos = Photo.find(:all, :conditions => "user_id == CAST( " + params["id"] + " AS string )")
      dummyHash = Hash.new
      for foto in photos
        dummyHash[foto] = Array.new
        comentarios = Comment.find(:all, :conditions => ("photo_id == CAST( " + foto.id.to_s + " AS string )"))
        for comentario in comentarios
            id = comentario.user_id
            puts id
            usuario = User.find(id)
            puts usuario
            username = usuario.first_name + " " + usuario.last_name
            dummyHash[foto] << {"comment" => comentario.comment, "user" => username, "userid" => id}
        end
      end
      @photos = dummyHash
  end
end