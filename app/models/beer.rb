class Beer < ActiveRecord::Base
	include RatingAverage

	belongs_to :brewery
	has_many :ratings, dependent: :destroy

	def to_s
		"#{name}" + " #{brewery.name}"
	end

	def average_rating
		ratings.average(:score)
	end

end
