class User < ApplicationRecord

  # device用メソッド。必要に応じて、追加すること
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
         
  # ユーザー登録用のバリデーション。
  # ユーザーネームは一意で15文字以下に
  validates  :name, presence: true, uniqueness: true, length: { maximum: 15 }
  # asteriskのセキュリティの観点から、4文字の内線番号を強要する
  validates :src, presence: true, uniqueness: true,length: { is: 4 }
  # asteriskの保守・運用の観点から、英数字&12文字以下を強要する
  validates  :telephone_pass, presence: true,length: { maximum: 12 }, format: { with: /\A[a-zA-Z1-9]+\z/ }

  # asteriskのsip.confにユーザー情報を記入し、電話が出来るようにする
  def registration_to_sip_conf
    # asteriskがないサーバーで実行するとエラーになるので
    if File.exist?("/etc/asterisk/sip.conf")
      file = File.open("/etc/asterisk/sip.conf", "a:UTF-8")
      file.puts "\n"
      file.puts "[#{self.src}]\n"
      file.puts "type=friend\n"
      file.puts "defaultuser=#{self.src}\n"
      file.puts "defaultuser=#{self.telephone_pass}"
      file.puts "host=dynamic"
      file.close
      system(`asterisk -rx "sip reload"`)
      # 記入後はフラグを「true」にして、save
      self.sip_regist_flag = 1
      self.save
    end
  end

  # ログインしているユーザーが、ボタンを押した時に、自動発信出来るようにする
  def current_user_autocall
    # 新規作成なので「w」モードで
    file = File.open("/var/spool/asterisk/outgoing/call.txt", "w:UTF-8")
    # file = File.open("/root/call.txt", "w:UTF-8") / for test
    file.puts"Channel: SIP/#{self.src}"
    file.puts "RetryTime: 60"
    file.puts "WaitTime: 30"
    file.puts "Context: default"
    file.puts "Extension: 5566"
    file.close
  end

end
