class VideoGamesController < ApplicationController

  get '/video_games' do
    if logged_in?
      @video_games = VideoGame.all
      erb :'videogames/video_games'
    else
      redirect to '/login'
    end
  end

  get '/video_games/new' do
    if logged_in?
      erb :'/videogames/create_video_game'
    else
      redirect to '/login'
    end
  end

  post '/video_games' do
    if logged_in?
      if params[:name] == ""
        redirect '/video_games/new'
      else
        @video_game = current_user.video_games.build(name: params[:name])
        if @video_game.save
          redirect to "/video_games/#{@video_game.id}"
        else
          redirect to "/video_games/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/video_games/:id' do
    if logged_in?
      @video_game = VideoGame.find_by_id(params[:id])
      erb :'/videogames/show_video_game'
    else
      redirect to '/login'
    end
  end

  get '/video_games/:id/edit' do
    if logged_in?
      @video_game = VideoGame.find_by_id(params[:id])
      if @video_game && @video_game.user == current_user
        erb :'videogames/edit_video_game'
      else
        redirect '/video_games'
      end
    else
      redirect '/login'
    end
  end

  patch '/video_games/:id' do
    if logged_in?
      if params[:name] == ""
        redirect to "/video_games/#{params[:id]}/edit"
      else
        @video_game = VideoGame.find_by_id(params[:id])
        if @video_game && @video_game.user == current_user
          if @video_game.update(name: params[:name])
            redirect to "/video_games/#{@video_game.id}"
          else
            redirect to "/video_games/#{@video_game.id}/edit"
          end
        else
          redirect to '/video_games'
        end
      end
    else
      redirect to '/login'
    end
  end





end
