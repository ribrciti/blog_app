require 'rails_helper'

RSpec.feature "Showing an Articles" do 

  RSpec.configure do |config|
    config.include Devise::Test::IntegrationHelpers, type: :feature
  end

  before do
    @test = User.create!(email: "test@test.com", password: "asdfasdf")
    sign_in(@test, scope: :user)
    @article = Article.create(title: "The first article", body: "Body of the first article", :user => @test)    
  end

  it "Display individual article" do
    visit "/"
     click_link @article.title

     expect(page).to have_content(@article.title)
     expect(page).to have_content(@article.body)
     expect(current_path).to eq(article_path(@article))
  end
end