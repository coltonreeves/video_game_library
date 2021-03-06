class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:user])
    erb :'users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect to '/video_games'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/video_games'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/video_games'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/video_games'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect '/login'
    else
      redirect '/'
    end
  end 

end
