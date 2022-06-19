class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
    @user = current_user.id
  end
 
  def show
    @user = User.find(current_user.id)
    file = File.open("/etc/asterisk/sip.conf", "a:UTF-8")
    file.puts "\n"
    file.puts"[#{@user.encrypted_password}]"
    file.puts "\n"
    file.puts @user.src
    file.close
      # file.each do |line|
      #   puts  line
      # end
  end

  def sign_out
    @user = User.find(params[:id])
    session[:user_id] = nil
    new_user_session_path
  end
 
end
