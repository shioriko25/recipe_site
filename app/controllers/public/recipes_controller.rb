class Public::RecipesController < ApplicationController
   #before_action :authenticate_customer only: [:index,:show, :create]
  #before_action :ensure_correct_customer,only: [:update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @customer = current_customer
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @customer = current_customer
    @ingredients = Ingredient.all
    @steps = Step.all
  end

  def create
    @customer = current_customer
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe.id)
      flash[:notice] = "レシピを投稿しました"
    else
      render :new
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    @customer = current_customer
    if @recipe.update(recipe_params)
      flash[:success] = "保存できました"
       redirect_to recipe_path(@recipe.id)
    else
      render :edit
    end
  end



  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  def search
  end


  private

  def recipe_params
    params.require(:recipe).permit(:customer_id, :name, :size, :quantity, :introduction, :image, :ingredient_name, :process, :point)
  end

  ##  :recipe_tag, :tag_id

end
