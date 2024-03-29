class CommentsController < ApplicationController
  def new
     @comment = Comment.new
  end 
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create!(params[:comment])
    redirect_to @post, :notice => "Comment created!"
  end 
  
end
