class Members::MembersController < ApplicationController

  def show
    @member = Member.find(params[:id])
    @ideas = @member.ideas
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
