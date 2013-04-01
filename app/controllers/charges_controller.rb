class ChargesController < ApplicationController
	before_filter :set_theme_cookie
	before_filter :check_if_user

	def new
		if cookies[:theme_id]
			@row = Theme.find(cookies[:theme_id].to_i)
			@theme = @row.name
			#need to convert amount to i otherwise a price like 0.99 has a trailing 0. 99.0 and is invalid for stripe
			@amount = (@row.price * 100).to_i
			@theme_id = cookies[:theme_id]
		else
			@empty_cart = 1
		end
	end

	def create
		@row = Theme.find(params[:theme_id].to_i)
	  # Amount in cents
	  @amount = params[:amount].to_i
	  @theme_id = params[:theme_id]
	  @theme = params[:theme]

	  customer = Stripe::Customer.create(
	    :email => current_user.email,
	    :card  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @amount,
	    :description => 'Bootstrap Micro Customer',
	    :currency    => 'usd'
	  )

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  #
	  redirect_to new_charge_path
	else 
	  #need to save the stripe customer id into the db with the current user row. Also just update the user account here to include this theme in their downloads list. Clear their cookie and session then redirect to download. Maybe fire off an email as well. 
	  #current_user.id, stripe_customer_id, amount_paid, theme_id, theme_name
	  c = Charge.new
	  c.user_id = current_user.id
	  c.stripe_customer_id = customer.id
	  c.amount_paid = @amount.to_f/100
	  c.theme_id = @theme_id
	  c.theme_name = @theme

	  if c.save
	  	#need to clear their cookies here. 
	  	cookies.delete(:theme_id)
	  	flash[:success] = "Thanks for purchasing. Your downloads are displayed below"
			redirect_to :controller => "downloads", :action => "index", only_path: true
		end
	end


	private

		def set_theme_cookie
			if params[:theme_id]
				cookies[:theme_id] = { :value => params[:theme_id], :expires => 10.days.from_now } 
			end
		end

		def check_if_user
			redirect_to new_user_registration_path unless user_signed_in? 
		end
end
