class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  helper_method :current_user



  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end




  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end




  private

  def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

end
