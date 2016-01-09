class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Foyer::Controller::Helpers

  before_action :authenticate_user!

  protected

  # Override to support email store in session.
  def current_user
    super.update(email: user_session['email'])
  end
end
