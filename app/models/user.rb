class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true,
            length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 }
  validates :password, format: { with: /([A-Z].*\d)|(\d.*[A-Z].*)/,
                                 message: "should contain one number and one capital letter" }

  def self.best_raters
    sorted_by_amount_of_ratings = User.all.sort_by{ |u| (-u.ratings.count) }
    sorted_by_amount_of_ratings[0, 5]
  end

  def favorite_beer
    return nil if ratings.empty?
    return nil if beers.empty?
    ratings.sort_by(&:score).last.beer
  end

  def favorite_style
    return nil if ratings.empty?
    return nil if beers.empty?

    ratings_of_styles = ratings.group_by { |r| r.beer.style }
    averages_of_styles = []
    ratings_of_styles.each do |style, ratings|
      averages_of_styles << {
          style: style,
          rating: ratings.map(&:score).sum / ratings.count.to_f
      }
    end
    averages_of_styles.sort_by{ |b| -b[:rating] }.first[:style]
  end

  def favorite_brewery
    return nil if ratings.empty?
    return nil if beers.empty?
    beers.joins("INNER JOIN breweries ON beers.brewery_id = breweries.id").group("breweries.name").order('AVG(ratings.score) ASC').last.brewery.name
  end

end