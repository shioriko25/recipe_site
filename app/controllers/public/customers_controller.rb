class Public::CustomersController < ApplicationController
  #before_action :authenticate_customer!
  #before_action :ensure_correct_customer,except: [:unsubscribe, :withdrawal]

  def show
    @customer = Customer.find(params[:id])
    
    if @customer.id == current_customer.id
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
       flash[:success] = "保存できました"
       redirect_to customer_path(@customer)
    else
      render 'edit'
    end
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdrawal
    @customer = current_customer
    @customer.update!(is_deleted: true) #!を付けることでtrueかエラーで返すようになる
    sign_out current_customer
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
   params.require(:customer).permit(:name, :name_kana, :email, :password, :image, :introduction )
  end

end

