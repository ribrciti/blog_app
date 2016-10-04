class ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  def index
  @articles = Article.all   
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    
    respond_to do |format|
      if @article.save
        flash[:success] = 'Article has been created.'        
        format.html { redirect_to(@article) }
        format.xml { render xml: @article, status: :created, location: @article }
      else
        flash.now[:danger] = "Article has not been created"
        format.html { render action: "new" }
        #format.xml { render xml: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update

    respond_to do |format|
      if @article.update(article_params)
        flash[:success] = 'Article has been updated.'        
        format.html { redirect_to(@article) }
        format.xml { render xml: @article, status: :created, location: @article }
      else
        flash.now[:danger] = "Article has not been updated"
        format.html { render action: "edit" }
        #format.xml { render xml: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
    if @article.destroy
      flash[:success] = "Article has been deleted"
      redirect_to articles_path
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end


