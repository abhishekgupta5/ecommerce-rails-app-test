class ApplicationController < ActionController::Base
  helper_method :cart

  private

  def cart
    session[:cart] ||= {}
  end
end
