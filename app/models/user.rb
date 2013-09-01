class User
  include Mongoid::Document

  field :name, type: String
  field :email, type: String
  field :password_digest, type: String
  field :password_salt, type: String
  field :admin, type: Mongoid::Boolean, default: false

  attr_accessor :password
  before_save :encrypt_password

  def self.authenticate! email, password
    user = User.find_by(email: email)
    if user and user.password_digest = BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      NullUser.new
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_digest = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end


class NullUser
  def name; nil end
  def email; nil end
end
