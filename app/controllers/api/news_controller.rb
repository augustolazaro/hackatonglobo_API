class Api::NewsController < Api::BaseController
  skip_before_filter :verify_authenticity_token
  before_filter :allow_cors

  def graph
    news = News.where(denied: false).filter(params.slice(:initial_date, :final_date, :category)).order(:created_at).group(:created_at).count
    render json: { status: 0, data: news }
  end

  def index
    news = News.where(denied: false).filter(params.slice(:initial_date, :final_date, :category)).order(created_at: :desc)
    render json: { status: 0, data: news }
  end

  def create
    user = User.find_or_create_by(name: params[:user][:name])
    news = News.new(news_params)
    news.denied = false
    news.user = user
    if news.save
      render json: { status: 0, data: news }
    else
      render json: { status: 1, messages: news.errors.full_messages }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def news_params
    params.require(:news).permit(:content, :title, :image, :denied, :latitude, :longitude, :tags)
  end

  def allow_cors
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

end
