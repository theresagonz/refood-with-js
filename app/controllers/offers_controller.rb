class OffersController < ApplicationController
  layout 'application_no_login_link', only: [:current_offers]
  before_action :require_login, except: [:current_offers]
  before_action :redirect_to_index_if_not_authorized_to_edit_offer, only: [:edit, :update, :destroy]

  def new
    @offer = current_user.giver.offers.build
  end

  def create
    offer = current_user.giver.offers.build(offer_params)
    if offer.save
      flash[:message] = "Offer successfully created"
      redirect_to offer_path(offer)
    else
      flash.now[:error] = user.errors.full_messages
      render :new
    end
  end

  def index
    @offers = Offer.open_offers.select { |o| o.giver_id != current_user.id }.reverse


    respond_to do |format|
      format.html { render :index }
      format.json { render json: @offers }
    end
  end

  def by_location
    @offers = Offer.group_by_location
  end

  def closed
    @offers = Offer.select { |o| o.giver_id == current_user.id && o.closed }
  end

  def current_offers
    @offers = Offer.select { |o| !o.deleted && !o.closed }.reverse
  end
    
  def show
    @offer = Offer.find(params[:id])
    @request = Request.select { |r| r.offer == @offer && r.requestor == current_user.requestor }.first
    @requests = @offer.requests.select { |r| r.completed_requestor == false }
    @completed_requests = @offer.requests.select { |r| r.completed_requestor }

    respond_to do |format|
      format.html { render :show }
      format.json { render json: @offer }
    end    
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def update
    @offer = Offer.find(params[:id])
    # if params are coming from the offer edit form
    if params[:offer]
      if @offer.update(offer_params)
      flash[:message] = "Offer successfully updated"
      redirect_to offer_path(@offer)
      else
        flash.now[:error] = offer.errors.full_messages
        render :edit
      end
    # if params are coming from offer requests (close offer)
    else
      @offer.closed = true
      @offer.save
      flash[:message] = "Offer successfully closed"
      redirect_to '/index'
    end
  end

  def destroy
    offer = Offer.find(params[:id])
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
    params.require(:offer).permit(:headline, :description, :availability, :expiration, :closed, :city, :state)
  end
end
