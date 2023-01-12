class Admin::CommentsController < ApplicationController
   # 管理者でログインしているのみ閲覧可にするメソッド
  before_action :authenticate_admin!
  
  def index
  end

  def show
  end

  def edit
  end

  def update
  end
end
