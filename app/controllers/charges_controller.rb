class ChargesController < ApplicationController
	before_filter :check_if_user

	def new
		if params[:theme_id]
			session[:theme_id] = params[:theme_id]
		end
		if session[:theme_id]
			case session[:theme_id].to_i
			when 1
				@theme = "Corgi"
				@amount = 300
			when 2
				@theme = "Boxer"
				@amount = 300
			end
		else
			@empty_cart = 1
		end
	end

	def create
	  # Amount in cents
	  @amount = params[:amount]

	  customer = Stripe::Customer.create(
	    :email => 'example@stripe.com',
	    :card  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @amount,
	    :description => 'Rails Stripe customer',
	    :currency    => 'usd'
	  )

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to charges_path
	end


	private

		def check_if_user
			redirect_to new_user_registration_path unless user_signed_in? 
		end
end
