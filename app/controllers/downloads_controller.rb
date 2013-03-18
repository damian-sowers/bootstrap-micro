class DownloadsController < ApplicationController
	before_filter :check_if_user

	def index
		@charges = current_user.charges
		@themes = Array[]

		@charges.each do |c|
			@themes << Theme.find(c.theme_id)
		end
	end

	private

		def check_if_user
			redirect_to new_user_session_path unless user_signed_in? 
		end
end
