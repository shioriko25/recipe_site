class Admin::CommentsController < ApplicationController
   # 管理者でログインしているのみ閲覧可にするメソッド
  before_action :authenticate_admin!

  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  # def edit
  #   @comment = Comment.find(params[:id])
  #   @comment = Comment.new(comment_params)
  # end

  # def update
  #   @comment = Comment.find(params[:id])
  #   if @comment.update(comment_params)
  #     flash[:notice] = "保存できました"
  #     redirect_to admin_comment_path(comment.id)
  #   else
  #     render :new
  #   end
  # end


  def destroy
    if Comment.find(params[:id]).destroy
      redirect_to admin_comments_path
      flash[:notice] = "削除できました"
    else
      render :index
    end
  end




end
