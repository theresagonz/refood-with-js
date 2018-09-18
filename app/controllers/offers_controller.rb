class OffersController < ApplicationController
  before_action :require_login
  before_action :redirect_to_index_if_not_authorized, only: [:edit, :update, :destroy]

  def new
    @offer = Offer.new
  end

  def create
    offer = current_user.giver.offers.build(offer_params)
    if offer.save
      redirect_to offer_path(offer)
    else
      flash[:error] = user.errors.full_messages
      render :new
    end
  end

  def index
    @offers = Offer.all
  end
    
  def show
    @offer = Offer.find_by(id: params[:id])
    @request = Request.where(offer: @offer, receiver: current_user).first
    @expiration = format_date(@offer.expiration)
  end

  def edit
    @offer = Offer.find_by(id: params[:id])
  end

  def update
    offer = current_user.giver.offers.build(offer_params)
    if offer.save
      redirect_to offer_path(offer)
    else
      flash[:error] = offer.errors.full_messages
      @offer = Offer.find_by(id: params[:id])
      render :edit
    end
  end

  def destroy
    Offer.find_by(id: params[:id]).delete
    redirect_to index_path
  end

  private

  def offer_params
    params.require(:offer).permit(:title, :description, :availability, :expiration, :fulfilled)
  end
end
