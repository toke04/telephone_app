# 本番用
$worker  = 2
$timeout = 30
$app_dir = "/var/www/telephone_app"
$listen  = File.expand_path 'tmp/sockets/.unicorn.sock', $app_dir
$pid     = File.expand_path 'tmp/pids/unicorn.pid', $app_dir
$std_log = File.expand_path 'log/unicorn.log', $app_dir
# # set config
worker_processes  $worker
working_directory $app_dir
stderr_path $std_log
stdout_path $std_log
timeout $timeout
listen  $listen
pid $pid
# # loading booster
preload_app true
# before starting processes
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      Process.kill "QUIT", File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end
# after finishing processes
after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end


# #開発環境
# # rootパスのディレクトリを指定（「../」が先頭に追加）
# root_path = File.expand_path('../../../', __FILE__)

# # アプリケーションサーバの性能を決定する
# worker_processes 2

# # アプリケーションの設置されているディレクトリを指定（current内に変更）
# # working_directory "#{root_path}/current"
# working_directory "#{root_path}"

# # プロセスIDの保存先を指定（shared内に変更）
# # pid "#{root_path}/shared/tmp/pids/unicorn.pid"
# pid "#{root_path}/tmp/pids/unicorn.pid"

# # ポート番号を指定（shared内に変更）
# # listen "#{root_path}/shared/tmp/sockets/unicorn.sock"
# listen "#{root_path}/tmp/sockets/unicorn.sock"

# # エラーのログを記録するファイルを指定（shared内に変更）
# # stderr_path "#{root_path}/log/unicorn.stderr.log"
# stderr_path "#{root_path}/shared/log/unicorn.stderr.log"

# # 通常のログを記録するファイルを指定（shared内に変更）
# stdout_path "#{root_path}/log/unicorn.stdout.log"
# # stdout_path "#{root_path}/shared/log/unicorn.stdout.log"