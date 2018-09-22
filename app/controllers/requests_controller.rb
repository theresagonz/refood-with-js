class RequestsController < ApplicationController
  before_action :require_login
  before_action :redirect_to_index_if_not_authorized_to_edit_request, only: [:edit, :update, :destroy]

  def new
    @offer = Offer.find_by(id: params[:offer_id])
    @request = Request.new
  end

  def create
    request = Request.new(request_params)
    request.offer_id = params[:offer_id]
    request.requestor = current_user.requestor

    if request.save
      offer = Offer.find(params[:offer_id])
      redirect_to offer_request_path(offer, request)
    else
      flash.now[:error] = request.errors.full_messages
      @offer = Offer.find_by(id: params[:offer_id])
      render :new
    end
  end

  def show
    @offer = Offer.find_by(id: params[:offer_id])
    @request = Request.find_by(id: params[:id])
  end

  def index
    @offer = Offer.find_by(id: params[:offer_id])
    @requests = Request.where("offer_id = ?", params[:offer_id])
  end

  def edit
    @offer = Offer.find_by(id: params[:offer_id])
    @request = Request.find_by(id: params[:id])
  end

  def update
  end

  def destroy
  end

  private

    def request_params
      params.require(:request).permit(:message, :requestor_email, :requestor_phone)
    end
end
