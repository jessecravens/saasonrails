class Company
  include Mongoid::Document
  field :name,              :type => String, :null => false, :default => ""
  field :subdomain,         :type => String, :null => false, :default => ""

  has_one :owner, class_name: 'User'
  has_many :users, dependent: :destroy

  validates_presence_of :name, :case_sensitive => false
  validates_uniqueness_of :subdomain, :case_sensitive => false
end
