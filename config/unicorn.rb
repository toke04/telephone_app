# rootパスのディレクトリを指定（「../」が先頭に追加）
root_path = File.expand_path('../../../', __FILE__)

# アプリケーションサーバの性能を決定する
worker_processes 2

# アプリケーションの設置されているディレクトリを指定（current内に変更）
working_directory "#{root_path}/current"

# プロセスIDの保存先を指定（shared内に変更）
pid "#{root_path}/shared/tmp/pids/unicorn.pid"

# ポート番号を指定（shared内に変更）
listen "#{root_path}/shared/tmp/sockets/unicorn.sock"

# エラーのログを記録するファイルを指定（shared内に変更）
stderr_path "#{root_path}/shared/log/unicorn.stderr.log"

# 通常のログを記録するファイルを指定（shared内に変更）
stdout_path "#{root_path}/shared/log/unicorn.stdout.log"

# 以下略
