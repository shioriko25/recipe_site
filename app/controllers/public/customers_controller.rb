class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!,only: [:edit, :update,  :unsubscribe, :withdrawal]
  before_action :is_matching_login_customer, only: [:edit, :update, :unsubscribe, :withdrawal]
  before_action :ensure_guest_user, only: [:edit]

  def show
    @customer = Customer.find(params[:id])
    @recipes = @customer.recipes.page(params[:page]).per(5)
    if customer_signed_in? && @customer.id == current_customer.id
      render "mypage"
    else
      render "show"
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "変更保存できました"
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdrawal
    @customer = current_customer
    #!を付けることでtrueかエラーで返すようになる
    @customer.update!(is_deleted: true)
    sign_out current_customer
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :name_kana, :email, :password, :image, :introduction )
  end

  def is_matching_login_customer
    customer_id = params[:id].to_i
    unless customer_id == current_customer.id
      redirect_to new_customer_session_path
    end
  end

  def ensure_guest_user
    @customer = Customer.find(params[:id])
    if @customer.name == "guestuser"
      redirect_to customer_path(current_customer)
    end
  end

end

