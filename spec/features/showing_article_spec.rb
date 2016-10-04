require 'rails_helper'

RSpec.feature "Showing an Articles" do 

  RSpec.configure do |config|
    config.include Devise::Test::IntegrationHelpers, type: :feature
  end

  before do
    @test = User.create(email: "test@test.com", password: "asdfasdf")
    @tested = User.create(email: "tested@test.com", password: "asdfasdf")
    @article1 = Article.create(title: "The first article", body: "Body of the first article", :user => @test)
    @article2 = Article.create(title: "The second article", body: "Body of the second article", :user => @tested)            
  end

  it "Display individual article" do
    visit "/"
    click_link @article1.title

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(current_path).to eq(article_path(@article1))
  end
  
   it "A non-owner signed-in cannot see Edit or Delete links on a non-authored link" do
    sign_in(@test)

    visit "/"

    click_link @article2.title

    expect(page).to_not have_link("Edit Article")       
    expect(page).to_not have_link("Delete Article") 
  end

  it "A non-signed in user does not see Edit or Delete links" do
    visit "/"
    
    click_link @article1.title

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(current_path).to eq(article_path(@article1))
    
    expect(page).to_not have_link("Edit Article")       
    expect(page).to_not have_link("Delete Article") 
  end 

  it "A signed-in-owner can see Edit and Delete links" do
    sign_in(@test)

    visit "/"

    click_link @article1.title

    expect(page).to have_link("Edit Article")       
    expect(page).to have_link("Delete Article") 
  end 
end