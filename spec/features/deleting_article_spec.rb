require 'rails_helper'

RSpec.feature "Deleting an Articles" do 
  before do
   @article = Article.create(title: "The first article", body: "Body of the first article")
  end

  it "a user deletes an article" do
    visit "/" 

    click_link @article.title
    click_link "Delete Article"


    expect(page).to have_content("Article has been deleted")    
    expect(current_path).to eq(articles_path)
  end
end