require 'rails_helper'

RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :feature
end

RSpec.feature "Editing an Articles" do 

  before do
    @test = User.create!(email: "test@test.com", password: "asdfasdf")
    sign_in(@test)
    @article = Article.create(title: "The first article", body: "Body of the first article", :user => @test)
  end

  it "A user updates an article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: "Updated article"
    fill_in "Body", with: "Updated body of article"
    click_button "Update Article"

    expect(page).to have_content("Article has been updated") 
    expect(page.current_path).to eq(article_path(@article))
  end

  it "A user fails to update an article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: ""
    fill_in "Body", with: "Updated body of article"
    click_button "Update Article"

    expect(page).to have_content("Article has not been updated") 
    expect(page.current_path).to eq(article_path(@article))
  end
end