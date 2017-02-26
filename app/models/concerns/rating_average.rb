module RatingAverage
	extend ActiveSupport::Concern

	def average_rating
		return 'No ratings yet' if self.ratings.nil?
		self.ratings.average(:score)
	end

end