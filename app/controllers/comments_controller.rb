class CommentsController < ApplicationController

  def create
    puts params.inspect

    @prototype = Prototype.find(params[:prototype_id])
    @comment = @prototype.comments.build(comment_params)
    if @comment.save
      redirect_to prototype_path(@prototype.id)
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show", status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(prototype_id: params[:prototype_id], user_id: current_user.id)
  end

end
