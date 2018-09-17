class RequestsController < ApplicationController
  def new
    @offer = Offer.find_by(id: params[:offer_id])
  end

  def create
    request = Request.new(request_params)
    request.offer_id = params[:offer_id]
    request.receiver_id = current_user.id
    request.save
    offer = Offer.find(params[:offer_id])
    redirect_to offer_request_path(offer, request)
  end

  def show
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def request_params
    params.require(:request).permit(:message, :receiver_email, :receiver_phone)
  end
end
