class OffersController < ApplicationController
  before_action :require_login
  before_action :redirect_to_index_if_not_authorized_to_edit_offer, only: [:edit, :update, :destroy]

  def new
    @offer = Offer.new
  end

  def create
    offer = current_user.giver.offers.build(offer_params)
    if offer.save
      redirect_to offer_path(offer)
    else
      flash.now[:error] = user.errors.full_messages
      render :new
    end
  end

  def index
    @offers = Offer.select { |o| !o.deleted }
  end
    
  def show
    @offer = Offer.find_by(id: params[:id])
    @request = Request.select { |r| r.offer == @offer && r.requestor == current_user.requestor }.first
    @expiration = format_date(@offer.expiration)
  end

  def edit
    @offer = Offer.find_by(id: params[:id])
  end

  def update
    # if params are coming from the offer edit form
    # @offer will exist
    @offer = Offer.find_by(id: params[:id])
    binding.pry
    # if params are coming from the offer requests form
    # mark each of these requests competed
    request_id_array = params[:offer][:id]
    if request_id_array
      request_id_array.each do |request_id|
        if request_id.present?
          request = Request.find_by(id: request_id)
          request.completed = true
          request.save
        end
      end
      # if there's more than one request_id in the array
      if request_id_array == [""]
        flash[:message] = "Nothing marked picked up"
      else
        flash[:message] = "Thanks for being an awesome human!"
      end
      redirect_to '/index'
    elsif @offer.update(offer_params)
      flash[:message] = "Offer successfully updated"
      redirect_to offer_path(@offer)
    else
      flash.now[:error] = offer.errors.full_messages
      render :edit
    end
  end

  def destroy
    offer = Offer.find_by(id: params[:id])
    if offer.requests.present?
      offer.deleted = true
      offer.save
      flash[:message] = "Offer successfully deleted"
      redirect_to index_path
    else
      offer.delete 
      flash[:message] = "Offer successfully deleted"
      redirect_to index_path
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:headline, :description, :availability, :expiration, :closed)
  end
end
