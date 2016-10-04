require 'rails_helper'

RSpec.feature "listing Articles" do 

  RSpec.configure do |config|
    config.include Devise::Test::IntegrationHelpers, type: :feature
  end

  before do
    @test = User.create!(email: "test@test.com", password: "asdfasdf")
    sign_in(@test, scope: :user)
    @article1 = Article.create(title: "The first article", body: "Body of the first article", :user => @test)
    @article2 = Article.create(title: "The second article", body: "Body of the second article", :user => @test)
  end

  it "List all articles" do
    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)  
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title) 
    expect(page).to have_link(@article2.title)   
  end
end