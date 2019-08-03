class User < ApplicationRecord
  has_many :messages
  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :visits, class_name: "Ahoy::Visit"
  has_many :events, class_name: "Ahoy::Event"
  attr_accessor :remember_token, :activation_token, :password_reset_token, :prev_tab_num
  before_save :downcase_email
  before_create :create_activation_digest
  after_update_commit :broadcast_appearance
  validates :name, presence: true, length: { maximum: 50 }
  
  scope :is_online, -> { where online: true } 

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 250 }, 
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }, allow_nil:true

  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

  # Activates an account.
  def activate
    update_attribute :activated,    true
    update_attribute :activated_at, Time.zone.now
  end

  def save_password_reset
    update_attribute :password_reset_digest, create_password_reset_digest
    update_attribute :reset_password_at, Time.zone.now
  end

  def send_mail_user_activate_model
    Signup::Activate.new(self).send_mail_activate_service
  end

  def send_mail_user_password_reset_model
    Password::ResetServices.new(self).call
  end

  def password_reset_expired?
    reset_password_at > 100.seconds.ago
  end

  def appear
    if tabs == 0
      update_attributes online: true
    end
    update_attributes tabs: tabs + 1
  end

  def disappear
    update_attributes tabs: tabs - 1
    if tabs == 0
      update_attributes online: false
    end
  end

  private
    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest activation_token
    end

    def create_password_reset_digest
      self.password_reset_token = User.new_token
      self.password_reset_digest = User.digest password_reset_token
    end
   
    def broadcast_appearance
      AppearanceBroadcastJob.perform_later self if saved_change_to_attribute?("online") 
    end

end
