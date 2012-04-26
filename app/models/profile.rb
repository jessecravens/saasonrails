class Profile
  include Mongoid::Document
  field :first_name
  field :last_name

  belongs_to :user

  attr_accessible :first_name, :last_name
  validates_presence_of :first_name, :last_name

  def full_name 
    "#{first_name} #{last_name}"
  end
end
