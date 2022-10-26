namespace :update do

  desc "loads movie data for viewing_parties into database"
  task vp_movie_info:[:environment] do
    viewing_parties = ViewingParty.where("image_path IS NULL")
    viewing_parties.each do |vp|
      movie = MoviesFacade.get_movie(vp.movie_id)
      vp.update_columns(movie_title:  movie.title, image_path: movie.image_path)
    end
  end

end