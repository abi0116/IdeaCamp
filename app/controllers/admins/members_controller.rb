class Admins::MembersController < ApplicationController

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @ideas = @member.ideas
    # @all_ranks = Idea.find(Favorite.group(:idea_id).order("count(idea_id) desc").limit(3).pluck(:idea_id))
    # @my_ranks = @all_ranks.select{ |idea| idea.member_id == current_member.id }
  end

  def company
    @members = Idea.where(is_adopted: true).order(created_at: :desc)
  end

end
