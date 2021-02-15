class StoreFavoritesController < ApplicationController
  before_action :current_user
  before_action :set_store
  def create
    @store.passive_follows.create(follower_id: @current_user.id)
    respond_to do |format|
      format.js { render :create }
    end
  end

  def destroy
    favorite = @store.passive_follows.find_by(follower_id: @current_user.id)
    favorite.destroy
    respond_to do |format|
      format.js { render :destroy }
    end
  end

  private
  def set_store
    @store = Store.find(params[:id])
  end
end
