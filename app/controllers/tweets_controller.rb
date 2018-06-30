class TweetsController < ApplicationController
  #before_action :move_to_index, except: :index
  def index
    @tweets = Tweet.includes(:user).order('created_at DESC').page(params[:page]).per(5)
  end

  def new
    @tweet = Tweet.new
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments.includes(:user)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy if current_user.id == tweet.user_id
    flash[:alert] = '画像を削除しました'
  end


  def create
    @tweet = Tweet.new(image:tweet_params[:image],text:tweet_params[:text], user_id:current_user.id)
    if @tweet.save
      flash[:notice] = "新しいツイートを投稿しました"
      redirect_to action: :index
    else
      flash.now[:alert] = '投稿できませんでした'
      render action: :new
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params) if tweet.user_id == current_user.id
  end

  private

  def tweet_params
    params.permit(:image, :text)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
