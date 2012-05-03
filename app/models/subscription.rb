class Subscription
  include Mongoid::Document
  field :stripe_card_token, type: String
  field :started_at, type: Integer
  field :ended_at, type: Integer
  field :status, type: String

  belongs_to :company
  belongs_to :plan

  scope :active, where(status: 'active')
  scope :past_due, where(status: 'past_due')
  scope :canceled, where(status: 'canceled')
  scope :unpaid, where(status: 'unpaid')

  scope :not_active, where(:status.ne => 'active')
end
