class CreateVideoGames < ActiveRecord::Migration
  def change
    create_table :video_games do |t|
      t.string :name
      t.integer :user_id
    end 
  end
end
