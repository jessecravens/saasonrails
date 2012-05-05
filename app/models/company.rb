class Company
  include Mongoid::Document
  field :name,              :type => String, :null => false, :default => ""
  field :subdomain,         :type => String, :null => false, :default => ""

  has_many :users, autosave: true, dependent: :destroy
  #embeds_one :owner, class_name: 'User'

  validates_presence_of :name, :case_sensitive => false
  validates_presence_of :subdomain, :case_sensitive => false
  validates_uniqueness_of :subdomain, :case_sensitive => false
  validates_format_of :subdomain, with: /^[a-z0-9_]+$/, message: "must be lowercase alphanumerics only"
  validates_length_of :subdomain, maximum: 32, message: "exceeds maximum of 32 characters"
  validates_length_of :subdomain, minimum: 3, message: "should have minimum of 3 characters"
  validates_exclusion_of :subdomain, in: ['www', 'mail', 'ftp'], message: "is not available"

  accepts_nested_attributes_for :users

  def owners
    self.users.select{ |u| u.has_role? :owner }
  end
end
