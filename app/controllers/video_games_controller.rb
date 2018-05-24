class VideoGamesController < ApplicationController

  get '/video_games' do
    if logged_in?
      @video_games = VideoGame.all
      erb :'videogames/video_games'
    else
      redirect to '/login'
    end
  end 


end
