class PromotionsController < ApplicationController
  before_action :set_store, only: [:new, :create, :index]

  def index
    @promotions = @store.promotions
    respond_to do |format|
      format.js { :index }
    end
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = @store.promotions.build(promotion_params)
    if @promotion.save
      redirect_to store_path(@promotion.store_id)
    else
      render :new
    end
  end
  private
  def set_store
    @store = Store.find(params[:store_id])
  end

  def promotion_params
    params.require(:promotion).permit(:title, :content, :store_id)
  end
end
