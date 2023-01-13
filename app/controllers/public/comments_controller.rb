class Public::CommentsController < ApplicationController


  def index
  end

  def create
    recipe = Recipe.find(params[:recipe_id])
    comment = current_user.recipe_comments.new(recipe_params)
    comment.recipe_id = recipe.id
    comment.save
    redirect_to recipe_path(recipe)
  end

  def destroy
  end

   private

  def recipe_params
    params.require(:recipe).permit(:comment, :image)
  end

end
