class Song < ApplicationRecord
    validates :title, presence: true, uniqueness: true
    validates :artist_name, presence: true
    validate :correct_release_year
  end
  
  def correct_release_year
    return true unless released
  
    year = release_year.to_i
    
    if year.zero?
      errors.add(:release_year, 'must be number')
    elsif year > Date.today.year
      errors.add(:release_year, 'must be in the past')
    end
end
