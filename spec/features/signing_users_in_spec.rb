require 'rails_helper'

RSpec.feature "Users sign-in" do
  before do
    @test = User.create!(email: "test@test.com", password: "asdfasdf")
  end

  it "with valid credentials" do
    visit "/"

    click_link "Sign in"
    fill_in "Email", with: @test.email
    fill_in "Password", with: @test.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{@test.email}") 
  end
end

