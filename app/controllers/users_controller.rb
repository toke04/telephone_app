class UsersController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, only: [:index]
  before_action :configure_sign_up_params, only: [:create]

  def index
    @search = User.ransack(params[:q])
    @users = @search.result.page(params[:page]).per(10)
  end
 
  def show
    @user = User.find(current_user.id)
    # logger.debug "#{@user.sip_regist_flag}" #sip.confへの記入フラグを確認

    # sip.confにまだ未登録だったら、追記する※用appendモード
    if @user.sip_regist_flag == false
      file = File.open("/etc/asterisk/sip.conf", "a:UTF-8")
      file.puts "\n"
      file.puts "[#{@user.src}]\n"
      file.puts "type=friend\n"
      file.puts "defaultuser=#{@user.src}\n"
      file.puts "defaultuser=#{@user.telephone_pass}"
      file.puts "host=dynamic"
      file.close
      system(`asterisk -rx "sip reload"`)
      # 記入後はフラグを「true」にして、save
      @user.sip_regist_flag = 1
      @user.save
    end

    # userのshowページで、userに確認してもらう用
    if @user.sip_regist_flag == true 
      @sip_service_status = "ご利用頂けます"
    else
      @sip_service_status = "まだお済みではありません"
    end

  end
  
  # 自動発信ボタンの処理。「/var/spool/asterisk/outgoing」下にファイルを作成すると、自動callが流れる → https://www.voip-info.jp/index.php/%E8%87%AA%E5%8B%95%E7%99%BA%E4%BF%A1
  def autocall
    @user = User.find(current_user.id)
    # 新規作成なので「w」モードで
    file = File.open("/var/spool/asterisk/outgoing/call.txt", "w:UTF-8")
    # file = File.open("/root/call.txt", "w:UTF-8") / for test
    file.puts"Channel: SIP/#{@user.src}"
    file.puts "RetryTime: 60"
    file.puts "WaitTime: 30"
    file.puts "Context: default"
    file.puts "Extension: 5566"
    file.close
    redirect_to users_index_path
  end
  
  #自動発信を止める処理。音楽が止まる
  def stop_autocall
    @user = User.find(current_user.id)
    #このコマンドで止まる → https://www.didforsale.com/hangup-active-calls-from-asterisk-cli
    system(`asterisk -rx "hangup request all"`)
    redirect_to users_index_path   
  end

  def sign_out
    @user = User.find(params[:id])
    session[:user_id] = nil
    new_user_session_path
  end
 
end
