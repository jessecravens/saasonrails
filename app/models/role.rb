class Role
  include Mongoid::Document
  
  has_and_belongs_to_many :users
  belongs_to :resource, :polymorphic => true
  
  field :name, :type => String
  index :name, unique: true
  index(
    [
      [:name, Mongo::ASCENDING],
      [:resource_type, Mongo::ASCENDING],
      [:resource_id, Mongo::ASCENDING]
    ],
    unique: true
  )

  def self.roles_by_ability user
    if user.has_role?(:owner)
      self.all
    elsif user.has_role?(:admin)
      self.where :name.in => ['manager', 'employee']
    elsif user.has_role?(:manager)
      self.where name: 'employee'
    else
      []
    end
  end
end
