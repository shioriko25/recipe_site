# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: :create
  
  
  
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to root_path, notice: 'guestuserでログインしました。'
  end


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

 private



  # 退会しているかを判断するメソッド
  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email]) # 入力されたemailからアカウントを1件取得
    return if @customer.nil?
    if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted#取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
      redirect_to new_customer_registration_path
    end
  end
end

#↓この記述の仕方もある

# protected

# def customer_state
#   @customer = Customer.find_by(email: params[:customer][:email])
#   return if @customer.nil?
#   if @customer.valid_password?(params[:customer][:password])
#     if @customer.is_deleted
#       flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
#       redirect_to new_customer_registration_path
#     end
#   end
# end

