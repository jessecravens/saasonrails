class SubscriptionsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @user = current_user
  end

  def edit
    @company = @subscription.company
    @plans = Plan.find(Plan.all.collect { |plan| plan.id unless plan == @subscription.plan }.compact )
  end

  def update
    @company = @subscription.company
    @company.cancel_subscription

    @company.create_subscription(Plan.find(params[:subscription][:plan]), params[:subscription][:stripe_card_token])

    redirect_to subscriptions_path, notice: 'Plan successfully changed'
  end
end