class Plan
  include Mongoid::Document
  field :stripe_id, type: String
  field :amount, type: Float
  field :name, type: String
  field :interval, type: String

  validates_presence_of :stripe_id, :amount, :name, :interval
  validates_uniqueness_of :name

  has_many :subscriptions

  def self.free_plan
    Plan.first(conditions: { stripe_id: 'sor-free' })
  end

  def self.basic_plan
    Plan.first(conditions: { stripe_id: 'sor-basic' })
  end

  def self.pro_plan
    Plan.first(conditions: { stripe_id: 'sor-pro' })
  end
end
