class CommentsController < ApplicationController
  before_action :current_user
  before_action :set_store

  def create
    @comment = @current_user.comments.build(comment_params)
    @comment.store = @store

    respond_to do |format|
      if @comment.save
        flash[:notice] = '投稿しました'
        format.js { render :create }
      else
        flash[:notice] = '投稿できませんでした'
        format.js { render :error }
      end
    end
  end

  def destroy
  end

  private
  def set_store
    @store = Store.find(params[:store_id])
  end
  def comment_params
    params.require(:comment).permit(:content)
  end
end
