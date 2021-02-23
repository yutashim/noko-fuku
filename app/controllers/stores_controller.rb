class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]
  before_action :prohibit_access, only: [:mypage, :edit, :create, :destroy]

  def index
    @stores = Store.all
  end

  def show
    @promotions = @store.promotions.order(created_at: :desc)
    @comments = @store.comments.includes(:user).order(created_at: :desc)
    @new_comment = @store.comments.build
  end

  def mypage
    @favorite_stores = @store.following_stores
  end

  def new
    user_login?
    @store = Store.new
  end

  def create
    params[:store][:postcode].gsub!(/\A(\d{3})-?(\d{4})/, '\1\2')
    @store = Store.new(store_params)
    if @store.save
      session[:user_id] = "store_#{@store.id}"
      redirect_to store_path(@store.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    params[:store][:postcode].gsub!(/\A(\d{3})-?(\d{4})/, '\1\2')
    if @store.update(store_params)
      redirect_to store_path(@store.id)
    else
      render :edit
    end
  end

  def destroy
    @store.destroy
    session.delete(:user_id)
    redirect_to new_session_path
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

  def prohibit_access
    @store = Store.find(params[:store_id]) if action_name == 'mypage'
    if @current_user != @store
      redirect_to stores_path
    end
  end
end
