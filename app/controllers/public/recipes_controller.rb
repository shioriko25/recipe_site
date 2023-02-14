class Public::RecipesController < ApplicationController
 before_action :authenticate_customer!,only: [:new, :edit, :create, :update, :destroy]
 before_action :is_matching_login_customer,only: [:edit,:create, :update, :destroy]

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
   # @commits = @task.commits
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
       flash[:notice] = "レシピを投稿しました"
       redirect_to recipe_path(@recipe.id)
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
       flash[:notice] = "レシピの変更を保存できました"
       redirect_to recipe_path(@recipe.id)
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    #一つ前のページの情報先にリダイレクトする
    if params[:referer].present?
      redirect_to params[:referer]
    else
      redirect_to recipes_path
    end
  end

  def search
    #投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag_list = Tag.all  
    #クリックしたタグを取得
    @tag = Tag.find(params[:tag_id]) 
    #クリックしたタグに紐付けられた投稿を全て表示
    @recipes = @tag.recipes.all 
  end



  def finder
    @recipes = Recipe.looks(params[:word])
    @customers = Customer.looks(params[:word])
  end


  private

  def recipe_params
    params.require(:recipe).permit(:customer_id, :name, :size, :quantity, :introduction, :image, :ingredient_name, :process, :point)
  end

  def is_matching_login_customer
    customer_id = params[:recipe].nil? ? Recipe.find(params[:id] ).customer_id: recipe_params[:customer_id].to_i
    unless customer_id == current_customer.id
      redirect_to new_customer_session_path
    end
  end

end

