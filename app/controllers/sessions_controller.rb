class SessionsController < ApplicationController

	def new
	end

	def create
	  user = User.authenticate(params[:email], params[:password])
	  if user
	    session[:user_id] = user.id
	    where_to = user.admin? ? signups_url : root_url
	    redirect_to where_to, :notice => "Logged in! Admin:#{user.admin?}"
	  else
	    flash.now.alert = "Invalid email or password"
	    render "new"
	  end
	end

	def destroy
	  session[:user_id] = nil
	  redirect_to root_url, :notice => "Logged out!"
	end

end
