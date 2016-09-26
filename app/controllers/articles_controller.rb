class ArticlesController < ApplicationController
  
  def index    
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    
    respond_to do |format|
      if @article.save
        flash[:notice] = 'Article was successfully created.'        
        format.html { redirect_to(@article) }
        format.xml { render xml: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        #format.xml { render xml: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
     @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end