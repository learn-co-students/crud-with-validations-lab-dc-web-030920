class Song < ApplicationRecord
    validates :title, presence: true, uniqueness: true 
    validates :released, inclusion: [true, false] 
    validates :release_year, presence: true, if: :already_released?
    validate :release_year_cannot_be_in_future
    validate :song_repeat 

    def already_released?
        released == true 
    end 

    def release_year_cannot_be_in_future
        if release_year.to_i > Time.now.year 
            errors.add(:release_year, "can't be in the future")
        end 
    end

    def song_repeat
        if Song.find_by(title: title, artist_name: artist_name)
           errors.add(:title, "An Artist can't release a song with the same title in the same year.")
        end
   end

end
