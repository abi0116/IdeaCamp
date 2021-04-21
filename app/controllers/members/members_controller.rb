class Members::MembersController < ApplicationController

  before_action :authenticate_member!

  def show
    @member = Member.find(params[:id])
    @ideas = @member.ideas.page(params[:page]).per(5).order(created_at: :desc)
    @all_ranks = Idea.find(Favorite.group(:idea_id).order("count(idea_id) desc").limit(3).pluck(:idea_id))
    @my_ranks = @all_ranks.select{ |idea| idea.member_id == current_member.id }
  end

  def edit
    @member = Member.find(params[:id])
    if current_member != @member
      redirect_to root_path
    end
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to member_path(@member.id)
    else
      render :edit
    end
  end

  def adopt_idea
    if current_member.is_company == true
    @ideas = Idea.where(adopted_by_id: current_member.id)
    else
      redirect_to root_path
    end
  end

  def leave
  end

  def withdraw
  end

  def company
  end

  def complete
  end

 private

 def member_params
   params.require(:member).permit(:last_name,:first_name,:postal_code,:address,:telephone_number,:email)
 end

end
