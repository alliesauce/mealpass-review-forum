class User < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest

  #requires first & last name, and username must be unique
  validates :username, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true

  #email/passowrd requirements
  has_secure_password
  Email_Regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  #validates allow_nil: true password is for when a user updates their profile - if they leave it blank, the password stays the same. Don't worry - a user can't sign up without a pssword, that would be captured by the properties of "has_secure_password" separately
  validates :password, confirmation: true, length: { minimum: 8 }, allow_nil: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: Email_Regex


  # Returns the hash digest of the given string. (code from railstutorial.org)
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token for sessions.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  #using self makes sure remember_token isnt just stored as a local variable
  # Remembers a user in the database for use with sessions if they select the "Remember Me option".
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user if does not select "remember me".
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Activates an account.
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
    send_welcome_email
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  #sends welcome email after activation
  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  #to search users by username
  def self.search(search)
    where("username LIKE ?", "%#{search}%")
  end

  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.to_s.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end



end


