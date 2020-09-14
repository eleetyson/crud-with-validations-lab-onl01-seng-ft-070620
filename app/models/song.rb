class Song < ApplicationRecord
  # title can't be blank or repeated by the same artist in the same year
  # released must be true or false
  # release year, if song is released...
    # should exist be less than or equal to the current year
  # artist name can't be blank
  validates :title, presence: true
  validates_uniqueness_of :title, scope: [:artist_name, :release_year]
  validates :artist_name, presence: true
  validates :released, inclusion: {in: [true, false]}
  with_options if: :song_released? do |song|
    song.validates :release_year, presence: true
    song.validates :release_year, numericality: {less_than_or_equal_to: Time.now.year}
  end

  def song_released?
    released
  end
end
