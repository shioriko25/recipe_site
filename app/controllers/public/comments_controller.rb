class Public::CommentsController < ApplicationController
before_action :authenticate_customer!

  def index
    @comments = Comment.all
    #@recipes = Recipe.all
  end

  def create
    recipe = Recipe.find(params[:recipe_id])
    comment = current_customer.comments.new(comment_params)
    comment.recipe_id = recipe.id
    if comment.save
       flash[:notice] = "コメントを送信しました"
       redirect_to recipe_path(recipe)
    else
      render :show
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to recipe_path(params[:recipe_id])
  end

   private

  def comment_params
    params.require(:comment).permit(:comment, :image, :recipe_id, :customer_id)
  end

end
