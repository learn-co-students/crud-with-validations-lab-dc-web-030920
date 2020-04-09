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
            errors.add(:release_year, "Release year cannot be in the future.")
        end
    end

    def song_repeat
         if Song.find_by(title: title, release_year: release_year, artist_name: artist_name)
            errors.add(:title, "An Artist can't release a song with the same title in the same year.")
         end
    end

end



# class Invoice < ApplicationRecord
#     validate :expiration_date_cannot_be_in_the_past,
#       :discount_cannot_be_greater_than_total_value
   
#     def expiration_date_cannot_be_in_the_past
#       if expiration_date.present? && expiration_date < Date.today
#         errors.add(:expiration_date, "can't be in the past")
#       end
#     end
   
#     def discount_cannot_be_greater_than_total_value
#       if discount > total_value
#         errors.add(:discount, "can't be greater than total value")
#       end
#     end
#   end