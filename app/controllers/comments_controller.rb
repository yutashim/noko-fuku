class CommentsController < ApplicationController
  before_action :current_user
  before_action :set_store
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @current_user.comments.build(comment_params)
    @comment.store = @store

    respond_to do |format|
      if @comment.save
        flash[:notice] = '投稿しました'
        format.js { render :index }
      else
        flash[:notice] = '投稿できませんでした'
        format.js { render :error }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      flash.now[:notice] = 'コメントが削除されました'
      format.js { render :index }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        flash[:notice] = '編集しました'
        format.js { render :index }
      else
        flash[:notice] = '保存できませんでした'
        format.js { render :error }
      end
    end
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_store
    @store = Store.find(params[:store_id])
  end
  def comment_params
    params.require(:comment).permit(:content)
  end
end
