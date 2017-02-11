require 'rails_helper'

include Helpers

describe "Beers page" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "is added with a valid name" do
    visit new_beer_path
    fill_in('beer[name]', with: 'test')
    expect {
      click_button('Create Beer')
    }.to change { Beer.count }.by(1)
  end

  it "without a proper name doesnt get added" do
    visit new_beer_path
    expect {
      click_button('Create Beer')
    }.to change { Beer.count }.by(0)
  end
end