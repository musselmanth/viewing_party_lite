class ViewingParty < ApplicationRecord
    belongs_to :host, class_name: 'User'
    has_many :viewing_party_invitees, dependent: :destroy
    has_many :users, through: :viewing_party_invitees
    
    validates_presence_of :duration, :date, :start_time, :movie_id, :host_id
    validates :duration, numericality: { only_integer: true } 
    validate :duration_longer_than_runtime

    attr_reader :movie

    after_initialize :get_movie, if: :new_record?
    after_save :save_movie_details

    private

    def duration_longer_than_runtime
        if duration && @movie.runtime > duration
            errors.add(:duration, "must be greater than movie runtime")
        end
    end

    def save_movie_details
        update_columns(movie_title: @movie.title, image_path: @movie.image_path)
    end

    def get_movie
        @movie = MoviesFacade.get_movie(movie_id)
    end


end