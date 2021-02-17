class PromotionsController < ApplicationController
  before_action :set_store, only: [:new, :create, :index]
  before_action :prohibit_access, only: [:new, :create]

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

  def prohibit_access
    if @store != @current_user
      redirect_to stores_path
    end
  end
end
