class Public::HomesController < ApplicationController


  def top
    @recipes = Recipe.all
    #新着順
    @recipes = Recipe.all.order(created_at: :desc)
    @recipe_rank = Recipe.includes(:favorited_customers).sort {|a,b| b.favorited_customers.size <=> a.favorited_customers.size}
  end

  def about
  end

end
