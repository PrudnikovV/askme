require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  attr_accessor :password
  has_many :questions, dependent: :destroy

  validates :password, confirmation: true, presence: true, on: :create
  validates :email, presence: true, uniqueness: true, format: /\A[\w\-.]+@[\w\-]+\.[\w\-.]+\z/, length: { maximum: 255 }
  validates :username, presence: true, uniqueness: true, format: /\A[\w]+\z/, length: { maximum: 40 }
  validates :background_color, format: /\A#(?:\h{3}){1,2}\z/

  before_validation :username_downcase
  before_save :encrypt_password

  def username_downcase
    unless username.nil?
      username.downcase!
    end
  end

  def self.authenticate(email, password)
    user = find_by(email: email)
    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
    return user if user.password_hash == hashed_password
    nil
  end

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
          )
        )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end
end
