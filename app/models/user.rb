class User
  include Mongoid::Document
  extend Rolify
	rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Encryptable
  # field :password_salt, :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  field :authentication_token, :type => String

  has_one :profile, dependent: :destroy, autosave: true
  belongs_to :company
  has_many :authentications, dependent: :destroy, autosave: true

  validates_presence_of :email, :case_sensitive => false
  validates_uniqueness_of :email, :case_sensitive => false
  attr_accessible :email, :password, :password_confirmation, :remember_me, :profile_attributes, :role_ids

  accepts_nested_attributes_for :profile

  delegate :full_name, to: :profile
  delegate :avatar, to: :profile
  
  delegate :subscription, to: :company
  delegate :subscriptions, to: :company

  # NOTE: Also find user by provider uid
  def self.find_for_facebook_oauth(access_token, signed_in_resource = nil)
    user = User.where(email: access_token.info.email).first
    user.present? ? user : Authentication.where(provider: access_token.provider, uid: access_token.uid).first.try(:user)
  end

  def self.find_for_open_id(access_token, signed_in_resource = nil)
    user = User.where(email: access_token.info.email).first
    user.present? ? user : Authentication.where(provider: access_token.provider, uid: access_token.uid).first.try(:user)
  end

  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end

  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end
  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  def password_required?
    # Password is required if it is being set, but not for new records
    if !persisted?
      false
    else
      !password.nil? || !password_confirmation.nil?
    end
  end
end
