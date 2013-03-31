class SubscriptionsController < ApplicationController

	def new
		@subscription = Subscription.new
	end

	def create
		@subscription = Subscription.new()
		@subscription.email = params[:email]

		if @subscription.save
			redirect_to :controller => :subscriptions, :action => "thanks", :only_path => true
		end
	end

	def thanks
	end


end
