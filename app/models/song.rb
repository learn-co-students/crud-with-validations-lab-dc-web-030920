class Song < ApplicationRecord
    validates :title, presence: true
    validate :released_year_true
    validate :release_year_future
    validate :song_repeat

    def released_year_true
        if released && !release_year.present?
            errors.add(:release_year, "Release year cannot be blank if the song has been released")
        end
    end

    def release_year_future
        if release_year.to_i > Time.now.year
            errors.add(:release_year, "Release year cannot be in the future")
        end
    end

    def song_repeat
        if Song.find_by(title: title, release_year: release_year, artist_name: artist_name)
            errors.add(:title, "Song cannot release the same song twice in a year")
        end
    end

end
