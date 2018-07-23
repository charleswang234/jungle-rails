class User < ActiveRecord::Base
  has_many :reviews

  has_secure_password

  validates :password, length: { minimum: 5 }
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, :password_digest, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.downcase.strip)
    if user && user.authenticate(password)
      user
    end
  end
end
