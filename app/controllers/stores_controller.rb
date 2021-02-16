class StoresController < ApplicationController
  before_action :set_store, only: [:show]
  def show
    @comments = @store.comments.includes(:user)
    @new_comment = @store.comments.build
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      session[:user_id] = "store_#{@store.id}"
      redirect_to store_path(@store.id)
    else
      render :new
    end
  end

  private
  def set_store
    @store = Store.find(params[:id])
  end

  def store_params
    params.require(:store).permit(
      :name, :email, :password, :password_confirmation, :icon, :icon_cache, :postcode, :prefecture, :city, :street_address
    )
  end
end
