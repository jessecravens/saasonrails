require 'stripe'

module StripeHelper
  module SubscriptionHelper
    def self.create_subscription(company, plan, card)
      begin
        if company.stripe_customer_id.present?
          customer = Stripe::Customer.retrieve(company.stripe_customer_id)
          customer.plan = plan
          customer.card = card
          customer.save
        else
          customer = Stripe::Customer.create(description: company.name, email: company.users.first.email, plan: plan, card: card)
        end
      rescue Stripe::InvalidRequestError => e
        Rails.logger.error "Stripe error while creating subscription: #{e.message}"
        return nil
      end
      customer
    end

    def self.cancel_subscription(company)
      customer = Stripe::Customer.retrieve(company.stripe_customer_id) 
      customer.cancel_subscription
    end
  end
end