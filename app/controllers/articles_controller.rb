class ArticlesController < ApplicationController
  
  def index
  @articles = Article.all   
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    
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
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

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
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:success] = "Article has been deleted"
      redirect_to articles_path
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end

