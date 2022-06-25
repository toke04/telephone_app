# 本番環境用、デプロイの情報
set :stage, :production
set :rails_env, 'production'
# server '3.113.53.220', user: 'root', roles: %w{app db web}

# server '3.113.53.220',
#   user: 'root',
#   roles: %w{web app},
  # ssh_options {
  #   user 'root'
  #   keys: %w(~/.ssh/id_rsa),
  #   forward_agent: false,
  #   auth_methods: %w(publickey password)
  #   # password: 'please use keys'
  # }

# set :ssh_options, {
#   user: 'root',
#   keys: %w(~/.ssh/aws_ec2_tokeshi_key.pem),
#   forward_agent: true,
#   auth_methods: %w(publickey)
#   # password: 'please use keys'
# }
set :branch, "master"
# deploy先のサーバー情報
# role :web, %w{ec2-user@3.113.53.220}
# deployするディレクトリの場所
set :deploy_to, '/var/www/telephone_app'
# set :ssh_options, {
#  keys: [File.expand_path('~/.ssh/aws_ec2_tokeshi_key.pem)')]
# }


# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}

# role-based syntax
# ==================
# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}

# Custom SSH Options
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/user_name/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }
