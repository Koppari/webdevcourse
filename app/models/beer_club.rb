class BeerClub < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user

  def isInClub(user, club)
    Membership.where(user_id: user).where(beer_club_id: club).first != nil
  end
end
