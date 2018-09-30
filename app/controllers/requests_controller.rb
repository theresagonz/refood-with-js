class RequestsController < ApplicationController
  before_action :require_login
  before_action :redirect_to_index_if_not_authorized_to_edit_request, only: [:edit, :update, :destroy]
  before_action :redirect_to_index_if_not_authorized_to_edit_offer, only: [:index]
  before_action :redirect_to_existing_request, only: [:new, :create]

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
      flash[:message] = "Thanks for making a new request! #{offer.user.name} has been notified"
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
    @requests = @offer.requests.select { |r| r.completed == false }
    @comment = Comment.new
  end

  def offer_completed
    @offer = Offer.find_by(id: params[:offer_id])
    @requests = @offer.requests.select { |r| r.completed == true }
  end

  def completed
    @requests = current_user.requests.select { |r| r.completed == true}
  end

  def edit
    @offer = Offer.find_by(id: params[:offer_id])
    @request = Request.find_by(id: params[:id])
  end

  def update
    @offer = Offer.find_by(id: params[:offer_id])
    @request = Request.find_by(id: params[:id])
    if @request.update(request_params)
      flash[:message] = 'Request successfully updated'
      redirect_to offer_request_path(@offer, @request)
    else
      flash.now[:error] = @request.errors.full_messages.uniq
      render :edit
    end
  end

  def complete
    request = Request.find_by(id: params[:id])
    request.update(request_params)

    flash[:message] = "Thanks for being an awesome human!"
    redirect_to offer_requests_path(request.offer)
  end

  def destroy
    request = Request.find_by(id: params[:id])
    request.delete

    flash[:message] = "Request successfully deleted"
    redirect_to '/index'
  end

  private

    def request_params
      params.require(:request).permit(:message, :requestor_email, :requestor_phone, :completed, :offer_id, :completed, :requestor_point, :giver_point)
    end

    def comment_params
      params.require(:comment).permit(:comment_for_requestor, :comment_for_giver, :offer_id)
    end
end
