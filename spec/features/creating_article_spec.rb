require 'rails_helper'

RSpec.feature "creating Articles" do 
  scenario "A user creates a new article" do 
    visit "/"

    click_link "New Article"

    fill_in "Title",  with: "Creating first article" 
    fill_in "Body",  with: "Lorem Ipsum" 
    click_button "Create Article"

    expect(page).to have_content("Lorem Ipsum")
    puts page.current_path
    expect(page.current_path).to eq(page.current_path)  
  end
end 