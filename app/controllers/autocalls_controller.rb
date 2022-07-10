class AutocallsController < ApplicationController

  # 自動発信ボタンの処理。「/var/spool/asterisk/outgoing」下にファイルを作成すると、自動callが流れる → https://www.voip-info.jp/index.php/%E8%87%AA%E5%8B%95%E7%99%BA%E4%BF%A1
  def autocall
    @user = User.find(current_user.id)
    @user.current_user_autocall
    redirect_to user_path(current_user)
  end
  
  #自動発信を止める処理。音楽が止まる
  def stop_autocall
    @user = User.find(current_user.id)
    #このコマンドを実行すると、通話が切れる → https://www.didforsale.com/hangup-active-calls-from-asterisk-cli
    system(`asterisk -rx "hangup request all"`)
    redirect_to user_path(current_user)
  end

end
