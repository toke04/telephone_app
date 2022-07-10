class UsersController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, only: [:index]
  before_action :configure_sign_up_params, only: [:create]

  def index
    @search = User.ransack(params[:q])
    @users = @search.result.order(id: "DESC").page(params[:page]).per(10)
  end
 
  def show
    @user = User.find(current_user.id)

    # sip.confにまだ未登録だったら、追記する※appendモードで
    if @user.sip_regist_flag == false
       @user.registration_to_sip_conf
    end

    # userのshowページで、userに確認してもらう用の変数
    if @user.sip_regist_flag == true 
      @sip_service_status = "ご利用頂けます"
    else
      @sip_service_status = "まだお済みではありません"
    end

  end
  
  def sign_out
    @user = User.find(params[:id])
    session[:user_id] = nil
    new_user_session_path
  end
 
end
