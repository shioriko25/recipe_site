class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters #指定したデータは保存できるよう、許可を与える
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :name_kana, :introduction, :is_deleted])
  end

  private

  def after_sign_in_path_for(resource_or_scope) # ログイン後のリダイレクト先
    if resource_or_scope.is_a?(Admin)
      admin_customers_path
    else
      root_path
    end
  end


  def after_sign_out_path_for(resource_or_scope) # ログアウト後のリダイレクト先
    if resource_or_scope == :customer
        root_path
    elsif resource_or_scope == :admin
        new_admin_session_path
    else
        root_path
    end
  end




end
