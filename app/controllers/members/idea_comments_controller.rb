class Members::IdeaCommentsController < ApplicationController

  def create
    idea = Idea.find(params[:idea_id])
    comment = current_member.idea_comments.new(idea_comment_params)
    comment.idea_id = idea.id
    comment.save
    redirect_to idea_path(idea.id)
  end

  def destroy
  end

  private

  def idea_comment_params
    params.require(:idea_comment).permit(:comment)
  end

end
