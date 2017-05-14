class Api::NewsController < Api::BaseController

  def show
    news = News.where(denied: false)
    render json: { status: 0, data: news }
  end

  def create
    puts params
    news = News.new(user_id: params[:user_id], content: params[:content], type: params[:type])
    if news.save
      render json: { status: 0, data: news }
    else
      render json: { status: 1, messages: news.errors.full_messages }
    end
  end

end
