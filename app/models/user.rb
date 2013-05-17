require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :photos
  has_many :comments
  
  def password=(wordpass)
      password = wordpass
      salt = self.salt
      @digest = Digest::SHA1.hexdigest(wordpass+salt)
  end
  
  def password
      @digest
  end
  
  def password_valid?
      if self.password == self.password_digest
          return true
      else
          return false
      end
  end
  
end
