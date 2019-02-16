class User < ApplicationRecord
  VALID_EMAIL_REGEX =/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save {self.email = email.downcase }
  validates :name, presence: true, length: { minimum: 10, maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
    format: {with: VALID_EMAIL_REGEX },
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  has_secure_password

  store :roles, accessors: [ :admin?, :verifier?, :surveyor? ], coder: JSON
end
