class Members::MembersController < ApplicationController

  def show
    @member = Member.find(params[:id])
    @ideas = @member.ideas.order(created_at: :desc)
    @all_ranks = Idea.find(Favorite.group(:idea_id).order("count(idea_id) desc").limit(3).pluck(:idea_id))
    @my_ranks = @all_ranks.select{ |idea| idea.member_id == current_member.id }
  end

  def edit
  end

  def update
  end

  def leave
  end

  def withdraw
  end

  def company
  end

  def complete
  end

end
