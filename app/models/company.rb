class Company
  include Mongoid::Document
  field :name,              :type => String, :null => false, :default => ""
  field :subdomain,         :type => String, :null => false, :default => ""
  field :stripe_customer_id, type: String

  has_many :users, autosave: true, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates_presence_of :name, :case_sensitive => false
  validates_presence_of :subdomain, :case_sensitive => false
  validates_uniqueness_of :subdomain, :case_sensitive => false
  validates_format_of :subdomain, with: /^[a-z0-9_]+$/, message: "must be lowercase alphanumerics only"
  validates_length_of :subdomain, maximum: 32, message: "exceeds maximum of 32 characters"
  validates_length_of :subdomain, minimum: 3, message: "should have minimum of 3 characters"
  validates_exclusion_of :subdomain, in: ['www', 'mail', 'ftp'], message: "is not available"

  accepts_nested_attributes_for :users

  def subscription
    subscriptions.active.first
  end

  def create_subscription(plan, card)
    customer = StripeHelper::SubscriptionHelper.create_subscription(self, plan.try(:stripe_id), card)
    if customer.present?
      self.update_attribute(:stripe_customer_id, customer.id)
      sub = customer.subscription
      subscriptions.create(stripe_card_token: card, started_at: sub.start, status: sub.status, plan: plan)
      true
    else
      false
    end
  end

  def cancel_subscription
    sub = StripeHelper::SubscriptionHelper.cancel_subscription(self)
    subscription.update_attributes(ended_at: sub.ended_at, status: sub.status) if sub.present?
  end
end
