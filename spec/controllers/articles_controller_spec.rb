require 'rails_helper'
require 'support/macros'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #edit" do
    before do
      @test = User.create(email: "test@test.com", password: "asdfasdf")
    end

    context "owner is allowed to edit his articles" do
      it "renders the edit template" do
        login_user @test
        article = Article.create(title: "First article", body: "Body of first article", :user => @test)

        get :edit, params: { id: article }
        expect(response).to render_template :edit 
      end
    end
 
   context "non-owner is not allowed to edit other users articles" do
     it "redirects to the root path" do        
       @tested = User.create(email: "tested@test.com", password: "asdfasdf")

       login_user @tested

       article = Article.create(title: "First article", body: "Body of first article", :user => @test)

       get :edit, params: { id: article }
       message = "You can only edit your own article."
       expect(response).to redirect_to(root_path) 
       expect(flash[:danger]).to eq message 
      end
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
