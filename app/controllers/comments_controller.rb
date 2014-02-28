class CommentsController < ApplicationController
  def create
  	@topic = Topic.find(params[:topic_id])
  	@post = @topic.posts.find(params[:post_id])
  	@comments = @post.comments

  	@comment = current_user.comments.build(params[:comment])
  	@comment.post = @post
  	
  	authorize! :create, @comment, message: "You need to be signed in  to do that."
  	if @comment.save
  		flash[:notice] = "Comment was created successfully."
  		redirect_to [@topic, @post] 
  	else
  		flash[:error] = "Error creating comment. Please try again."
  		render 'post/show'
  	end
  end

end
