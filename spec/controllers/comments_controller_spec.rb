require 'rails_helper'
require 'support/macros'

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    before do
     @test = User.create(email: "test@test.com", password: "asdfasdf")
    end

    context "signed in user" do
      it "can create a comment" do
        login_user @test
        article = Article.create(title: "The first article", body: "Body of the first article", :user => @test)
        post :create, comment: { body: "Awesome post" }, article_id: article.id
        expect(flash[:success]).to eq("Comment has been created") 
      end
    end

     context "snon-igned in user" do
      it "redirected to the sign in page" do
        login_user nil
        article = Article.create(title: "The first article", body: "Body of the first article", :user => @test)
        post :create, comment: { body: "Awesome post" }, article_id: article.id
        expect(response).to redirect_to new_user_session_path 
      end
    end
  end
end
