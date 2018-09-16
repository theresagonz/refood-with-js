class OffersController < ApplicationController
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
  end
    
  def show
    @offer = Offer.find_by(id: params[:id])
  end

  def new
    @offer = Offer.new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def offer_params
    params.require(:offer).permit(:title, :description, :availability, :expiration, :fulfilled)
  end
end
