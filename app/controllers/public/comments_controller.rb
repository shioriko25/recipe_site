class Public::CommentsController < ApplicationController


  def index
    @comments = Comment.all
    #@recipes = Recipe.all
  end

  def create
    recipe = Recipe.find(params[:recipe_id])
    comment = current_customer.comments.new(comment_params)
    comment.recipe_id = recipe.id
    comment.save
    redirect_to recipe_path(recipe)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to recipe_path(params[:recipe_id])
  end

   private

  def comment_params
    params.require(:comment).permit(:comment, :image, :recipe_id, :customer_id)
  end

end
