class Authentication
  include Mongoid::Document
  field :provider, type: String
  field :uid, type: String
  field :access_token, type: String

  belongs_to :user

  validates_uniqueness_of :uid, scope: :provider
  validates_uniqueness_of :provider, scope: :provider

  scope :facebook, where(provider: 'facebook')
  scope :google, where(provider: 'google')
end
