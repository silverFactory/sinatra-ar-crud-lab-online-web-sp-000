
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end
  get '/articles' do
    @articles = Article.all
    erb :index
  end
  post '/articles' do
    @article = Article.find_or_create_by(title: params[:title], content: params[:content])
    redirect "/articles/#{Article.last.id}"
  end
  get '/articles/new' do
    erb :new
  end
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end
  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    erb :show
  end
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
  #  raise params.inspect
    erb :edit
  end
  delete '/articles/:id' do
    @article = Article.find(params[:id])
    @article.destroy
    @articles = Article.all
    erb :index
  end
end
