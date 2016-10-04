require 'rails_helper'

RSpec.configure do |config|
    config.include Devise::Test::IntegrationHelpers, type: :feature
end

RSpec.feature "Showing an Article" do   

  before do
    @test = User.create(email: "test@test.com", password: "asdfasdf")
    @tested = User.create(email: "tested@test.com", password: "asdfasdf")
    @article = Article.create(title: "The first article", body: "Body of the first article", :user => @test)
    #@article2 = Article.create(title: "The second article", body: "Body of the second article", :user => @tested)            
  end

  it "permits a signed in user to write a review" do
    sign_in(@tested)

    visit "/"

    click_link @article.title
    fill_in "New Comment",  with: "An awesome article" 
    click_button "Add Comment" 

    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("An awesome article") 
    expect(current_path).to eq(article_path(@article.comments.last.id))
  end
end