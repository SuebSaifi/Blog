class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "sueb", password: "sueb", except: [:index, :show]

  def index
  @articles = Article.all
  end
  def show
    @article = Article.find(params[:id])
  end
  def new
    @article = Article.new

  end
  def edit
    @article = Article.find(params[:id])
  end
  
  def create
    @article = Article.new(article_param)
    if @article.save
    redirect_to @article
    else
      render 'new'
    end
  end
  
  def update
    @article = Article.find(params[:id])
      if @article.update(article_param)
        flash[:success] = "Article was successfully updated"
        redirect_to @article
      else
        flash[:error] = "Something went wrong"
        render 'edit'
      end
  end
    def destroy
      @article = Article.find(params[:id])
      if @article.destroy
        flash[:success] = 'Article was sarticle_param deleted.'
        redirect_to articles_url
      else
        flash[:error] = 'Something went wrong'
        redirect_to articles_url
      end
    end
    
  
  private

    def article_param
      params.require(:article).permit(:title,:body,:status)
    end
end
