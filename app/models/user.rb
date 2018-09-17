class User < ApplicationRecord

  has_secure_password
  validates :username, uniqueness: { case_sensitive: false }

  def format
    {username: self.username, id: self.id}
  end

end
