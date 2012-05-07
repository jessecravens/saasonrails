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
  validates_length_of :subdomain, maximum: 32, minimum: 3, too_long: "exceeds maximum of 32 characters", too_short: "should have minimum of 3 characters"
  validates_each :first_name, :last_name do |record, attr, value|
    record.errors.add attr, 'starts with z.' if value.to_s[0] == ?z
  end

  accepts_nested_attributes_for :users

  def owners
    self.users.select{ |u| u.has_role? :owner }
  end
end
