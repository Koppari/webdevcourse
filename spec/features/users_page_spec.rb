require 'rails_helper'

include Helpers

describe "Users page" do
  before :each do
    user = FactoryGirl.create :user
    beer = FactoryGirl.create(:beer)
    rating = FactoryGirl.create(:rating, beer:beer, user:user)
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "ratings shown on user page" do
    visit user_path(1)
    expect(page).to have_content "Has made 1 rating with an average of 10"
  end

  it "favorite beer shown on user page" do
    visit user_path(1)
    expect(page).to have_content "Users favorite beer style is Lager"
  end

  it "favorite brewery shown on user page" do
    visit user_path(1)
    expect(page).to have_content "Users favorite brewery is anonymous"
  end
end