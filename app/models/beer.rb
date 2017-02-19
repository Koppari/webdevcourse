class Beer < ActiveRecord::Base
	include RatingAverage

	validates :name, presence: true
  validates :style_id, presence: true

	belongs_to :brewery
    has_many :ratings, dependent: :destroy
    has_many :raters, through: :ratings, source: :user

	def to_s
		"#{name}" + " #{brewery.name}"
	end

	def average
		return 0 if ratings.empty?
		ratings.map{ |r| r.score}.sum / ratings.count.to_f
	end

	def average_rating
		ratings.average(:score)
  end


end
