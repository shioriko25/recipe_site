class Public::CommentsController < ApplicationController
before_action :authenticate_customer!

  def index
    # コメントしてくれた方のcomment_idを取得
    target_comment_ids_array = Comment.where(recipe_id: Recipe.where(customer_id: params[:customer_id]).pluck(:id)).pluck(:id)
    # 自分のcomment_idを配列に格納
    my_comment_ids_array = Comment.where(customer_id: params[:customer_id]).pluck(:id)
    # 上記2つのいずれかにあてはまるcomment_idを取得
    comment_ids = target_comment_ids_array + my_comment_ids_array
    @comments = Comment.where(id: comment_ids).all
  end

  def create
    recipe = Recipe.find(params[:recipe_id])
    comment = current_customer.comments.new(comment_params)
    comment.recipe_id = recipe.id
    if comment.save
       flash[:notice] = "コメントを送信しました"
       redirect_to recipe_path(recipe)
    else
      flash[:notice] = "コメントを送信失敗しました"
       redirect_to recipe_path(recipe)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    redirect_to recipe_path(params[:recipe_id]) unless comment.customer_id == current_customer.id
    comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to recipe_path(params[:recipe_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :image, :recipe_id, :customer_id)
  end

end
