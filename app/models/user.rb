class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3,
                       			 maximum: 30 }

  validates :password, length: { minimum: 4 }

  has_many :ratings
  has_many :beers, through: :ratings

end