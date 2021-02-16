class CommentsController < ApplicationController
  before_action :current_user
  before_action :set_store

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
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
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
  def set_store
    @store = Store.find(params[:store_id])
  end
  def comment_params
    params.require(:comment).permit(:content)
  end
end
