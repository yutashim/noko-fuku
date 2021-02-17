class UserFavoritesController < ApplicationController
  before_action :current_user
  before_action :set_store
  def create
    @store.user_favorites.create(user_id: @current_user.id)
    respond_to do |format|
      format.js { render 'store_favorites/create'}
    end
  end

  def destroy
    favorite = @store.user_favorites.find_by(user_id: @current_user.id)
    favorite.destroy
    respond_to do |format|
      format.js { render 'store_favorites/destroy'}
    end
  end

  private
  def set_store
    @store = Store.find(params[:id])
  end
end
