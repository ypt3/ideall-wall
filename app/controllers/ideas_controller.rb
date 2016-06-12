class IdeasController < ApplicationController
    def index
    @ideas = Idea.order(likes: :desc)
  end

  def create
    @updatePostCount = User.update_counters (session[:user_id]), :post_counter => +1
    @idea = Idea.create(ideas_params)
    @like = Like.create(likes_params)
    redirect_to '/ideas/index'
  end
  def show
    @idea = Idea.find(params[:id])
    @likes = Like.where("idea_id = ?", params[:id])
    
  end
  def update
    @like = Idea.update_counters (params[:id]), :likes => +1
    @updateLikeCount = User.update_counters (session[:user_id]), :like_counter => +1
    @tracker = Like.create(likes_params)
    redirect_to '/ideas/index'
  end

  def destroy 
    if params[:post_user_id] == params[:session_id]
      @idea = Idea.find(params[:id]).delete
      @updatePostCount = User.update_counters (session[:user_id]), :post_counter => -1
      flash[:delete] = "You've successfully deleted that post"
      redirect_to '/ideas/index'
  else
    flash[:cannot] = "Sorry, you are not allowed to delete this post"
    redirect_to '/ideas/index'
  end
  end

  private
  def ideas_params
    params.require(:idea).permit(:message,:user_id)
    
  end
  private
  def likes_params
    params.require(:like).permit(:user_id,:idea_id)
  end
end
