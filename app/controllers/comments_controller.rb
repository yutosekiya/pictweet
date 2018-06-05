class CommentsController < ApplicationController
  def create
    @comment = Comment.create(text:comment_params[:text], user_id:current_user.id, tweet_id:params:[:tweet_id])
    redirect_to "/tweets/#{@comment.tweet.id}"
  end

  private

  def comment_params
    params.permit(:text, :tweet_id)
  end
end
