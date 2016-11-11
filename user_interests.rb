require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'
require 'psych'
require 'yaml'


helpers do
  def count_interests(users_hsh)
    interests_tot = 0
    users_hsh.each_pair do |user, info|
      interests_tot += users_hsh[user][:interests].size
    end
    interests_tot
  end
end

before do
  @user_hash = YAML.load_file('users.yml')
  @user_tot = @user_hash.size
  @interest_tot = count_interests(@user_hash)
end

get "/" do
  redirect "/users"
end

get "/users" do
  erb :users
end

get "/users/:user_name" do
  @user = params[:user_name].to_sym
  @email = @user_hash[@user][:email]
  @interests = @user_hash[@user][:interests].join(", ")

  erb :user
end

