class WelcomeController < ApplicationController
  layout "application_login_link", only: [:home]
  before_action :require_login, only: [:index]
  before_action :redirect_to_index_if_logged_in, only: [:home]


  def home
  end

  def index
    @offers = OfferDecorator.select { |o| o.user == current_user && !o.deleted }
    @requests = current_user.requests
  end
end
