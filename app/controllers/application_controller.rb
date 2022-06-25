class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    users_path # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    new_user_session_path # ログアウト後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  protected
  # サインアップ用の関数。ビューから受け取りたい値を入れる
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:src,:telephone_pass,:sip_regist_flag])
  end
end
