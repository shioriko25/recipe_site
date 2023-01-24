class Public::RecipesController < ApplicationController
 #before_action :authenticate_customer only: [:index,:show, :create]
 #before_action :ensure_correct_customer,only: [:update, :destroy]

  def index
    @recipes = Recipe.all
    @recipes = Recipe.all.order(created_at: :desc)
    @tag_list = Tag.all
    #@recipe = current_customer.recipes.new #ビューのform_withのmodelに使う
  end

  def rank
     @recipes = Recipe.all
     @recipe_rank = Recipe.includes(:favorited_customers).sort {|a,b| b.favorited_customers.size <=> a.favorited_customers.size}
    @tag_list = Tag.all
  end


  def new
    @recipe = Recipe.new
    @customer = current_customer
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
    @recipe_tags = @recipe.tags #そのクリックした投稿に紐付けられているタグの取得
    #@customer = Customer.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @customer = current_customer
    @tags = @recipe.tags.pluck(:tag_name).join(", ")
  end

  def create
    @customer = current_customer
    @recipe = Recipe.new(recipe_params)
    tag_list = params[:recipe][:tag_name].delete("　").delete(" ").split(',')
    if @recipe.save
       @recipe.save_tag(tag_list)
       redirect_to recipe_path(@recipe.id)
      flash[:notice] = "レシピを投稿しました"
    else
      render :new
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    @customer = current_customer
    tag_list = params[:recipe][:tag_name].delete("　").delete(" ").split(',')
    if @recipe.update(recipe_params)
       @recipe.save_tag(tag_list)
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
    #redirect_back(fallback_location: root_path)
  end

  

  def search
    @tag_list = Tag.all  #投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id]) #クリックしたタグを取得
    @recipes = @tag.recipes.all #クリックしたタグに紐付けられた投稿を全て表示
  end



  def finder
    @range = params[:range]
    @recipes = Recipe.looks(params[:search],params[:word])
    @customers = Customer.looks(params[:search], params[:word])
  end


  private

  def recipe_params
    params.require(:recipe).permit(:customer_id, :name, :size, :quantity, :introduction, :image, :ingredient_name, :process, :point)
  end
end

