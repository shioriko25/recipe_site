class Admin::CommentsController < ApplicationController
   # 管理者でログインしているのみ閲覧可にするメソッド
  before_action :authenticate_admin!

  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end


  def destroy
    if Comment.find(params[:id]).destroy
      redirect_to admin_comments_path
      flash[:notice] = "削除できました"
    else
      render :index
    end
  end
  
end
