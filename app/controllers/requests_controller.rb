class RequestsController < ApplicationController
  before_action :require_login
  before_action :redirect_to_index_if_not_authorized_to_edit_request, only: [:show, :edit, :update, :destroy]
  before_action :redirect_to_index_if_not_authorized_to_edit_offer, only: [:index]
  before_action :redirect_to_existing_request, only: [:new, :create]
  before_action :redirect_if_user_owns_offer, only: [:new, :create]
  before_action :redirect_if_offer_and_request_not_associated, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def new
    @offer = Offer.find(params[:offer_id])
    @request = @offer.requests.build
  end

  def create
    binding.pry
    # request = Request.new(request_params)
    # request.offer_id = params[:offer_id]
    # request.requestor = current_user.requestor

    # if request.save
    #   offer = Offer.find(params[:offer_id])
    #   flash[:message] = "Request successfully created"
    #   redirect_to offer_request_path(offer, request)
    # else
    #   flash.now[:error] = request.errors.full_messages
    #   @offer = Offer.find(params[:offer_id])
    #   @request = @offer.requests.build
    #   render :new
    # end
  end

  def show
    @offer = Offer.find(params[:offer_id])
    @request = Request.find(params[:id])
  end

  def index
    @offer = Offer.find(params[:offer_id])
    @requests = @offer.requests.select { |r| r.completed_requestor == false }
  end

  def offer_completed
    @offer = Offer.find(params[:offer_id])
    @requests = @offer.requests.select { |r| r.completed_requestor == true }
  end

  def completed
    @requests = current_user.requests.select { |r| r.completed_giver == true}
  end

  def recently_completed
    @requests = Request.recently_completed.take(10)
  end

  def edit
    @offer = Offer.find(params[:offer_id])
    @request = Request.find(params[:id])
  end

  def update
    @offer = Offer.find(params[:offer_id])
    @request = Request.find(params[:id])
    if @request.update(request_params)
      flash[:message] = 'Request successfully updated'
      redirect_to offer_request_path(@offer, @request)
    else
      flash.now[:error] = @request.errors.full_messages.uniq
      render :edit
    end
  end

  def complete
    request = Request.find(params[:id])
    request.update(request_params)
    flash[:message] = "Thanks for being an awesome human!"
    redirect_to '/index'
  end

  def destroy
    request = Request.find(params[:id])
    request.delete
    flash[:message] = "Request successfully deleted"
    redirect_to '/index'
  end

  private

    def request_params
      params.require(:request).permit(:message, :requestor_email, :requestor_phone, :offer_id, :completed_requestor, :completed_giver)
    end
end
