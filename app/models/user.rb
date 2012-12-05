# class User < ActiveRecord::Base
#   attr_accessible :email, :password_hash, :password_salt
# end



class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  # FIXME implement real admin roles :)
  def admin?
    return (email == 'jasminasab@gmail.com' && password_hash == BCrypt::Engine.hash_secret('jasmina123', password_salt)) ? true : false
  end

end

