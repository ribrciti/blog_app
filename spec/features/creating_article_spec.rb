require 'rails_helper'

RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :feature
end

RSpec.feature "Creating Articles" do 

  before do
    @test = User.create!(email: "test@test.com", password: "asdfasdf")
    sign_in(@test)
  end

  it "A user creates a new article" do 
    visit "/"

    click_link "New Article"

    fill_in "Title",  with: "Creating first article" 
    fill_in "Body",  with: "Lorem Ipsum"
    click_button "Create Article"

    expect(page).to have_content("Lorem Ipsum")
    expect(page.current_path).to eq(page.current_path)
    expect(page).to have_content("Signed in as: #{@test.email}") 
  end

  it "A user fails to create a new article" do
     visit "/"

    click_link "New Article"

    fill_in "Title",  with: "" 
    fill_in "Body",  with: "" 
    click_button "Create Article" 

    expect(page).to have_content("Article has not been created")
    expect(page).to have_content("Title can't be blank") 
    expect(page).to have_content("Body can't be blank") 
  end
end 