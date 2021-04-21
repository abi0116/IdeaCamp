class Members::IdeaCommentsController < ApplicationController

  before_action :authenticate_member!

  def create
    @idea = Idea.find(params[:idea_id])
    @idea_comment = IdeaComment.new#どっちにしろフォームで使っているから用意してあげる
    comment = current_member.idea_comments.new(idea_comment_params)
    comment.idea_id = @idea.id
    comment.save
    # @idea.create_notification_comment!(current_member, @idea_comment.id)
    #redirect_to idea_path(idea.id)
  end

  def destroy
    @idea = Idea.find(params[:idea_id])
    @idea_comment = IdeaComment.new
    IdeaComment.find_by(id: params[:id],idea_id: params[:idea_id]).destroy
    #redirect_to idea_path(params[:idea_id])
  end

  private

  def idea_comment_params
    params.require(:idea_comment).permit(:comment)
  end

end
