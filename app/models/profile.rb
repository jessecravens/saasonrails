class Profile
  include Mongoid::Document
  include Mongoid::Paperclip
  field :first_name
  field :last_name

  belongs_to :user

  has_mongoid_attached_file :avatar, styles: { thumb: '180x180' }

  attr_accessible :first_name, :last_name, :avatar
  validates_presence_of :first_name, :last_name

  def full_name 
    "#{first_name} #{last_name}"
  end
end
