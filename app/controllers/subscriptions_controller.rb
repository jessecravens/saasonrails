class SubscriptionsController < ApplicationController
  def edit
    @subscription = Subscription.find(params[:id])
  end

  def update
  end
end
