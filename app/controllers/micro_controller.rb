class MicroController < ApplicationController
	#before_filter :authenticate

	def index
		@themes = Theme.order("id ASC")
	end

	protected

	def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "damian" && password == "micro"
    end
  end
end
