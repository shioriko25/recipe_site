class Admin::CustomersController < ApplicationController
   # 管理者でログインしているのみ閲覧可にするメソッド
  before_action :authenticate_admin!
  
  
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:success] = "保存できました"
      redirect_to admin_customer_path(@customer.id)
    else
      render 'edit'
    end
  end
  
   private

  def customer_params
    params.require(:customer).permit(:name, :name_kana,  :image, :introduction,  :email, :is_deleted)
  end

  
  
end
