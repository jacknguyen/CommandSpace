class AuthsController < ApplicationController
	before_action :authenticate_user, only: [:destroy]
 
	def new
		if current_user
			redirect_to root_path
		else
			@user = User.new
		end
	end

	def create
		if params[:user][:username].present?
			user = User.find_by(username: params[:user][:username])
			if user && user.authenticate?(params[:user][:password])
				session[:user_id] = user.id 
				redirect_to items_path
			else
				flash[:error] = "Incorrect Password. Try Again"
				redirect_to new_auth_path
			end
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to new_auth_path
	end
end
