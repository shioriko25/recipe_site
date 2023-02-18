class Public::FavoritesController < ApplicationController
before_action :authenticate_customer!

  def index
    # ログイン中のユーザーのお気に入りのpost_idカラムを取得
    favorites = Favorite.where(customer_id: current_customer.id).pluck(:recipe_id) 
    # postsテーブルから、お気に入り登録済みのレコードを取得
    @favorite_recipes = Recipe.find(favorites) 
  end

  def create
     recipe = Recipe.find(params[:recipe_id])
    favorite = current_customer.favorites.new(recipe_id: recipe.id)
    favorite.save
    redirect_to recipe_path(recipe)
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
    favorite = current_customer.favorites.find_by(recipe_id: recipe.id)
    favorite.destroy
    redirect_to recipe_path(recipe)
  end



end
