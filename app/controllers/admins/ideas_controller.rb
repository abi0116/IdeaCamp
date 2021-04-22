class Admins::IdeasController < ApplicationController

  before_action :authenticate_admin!

  def index
    @ideas = Idea.all.page(params[:page]).per(5).order(created_at: :desc)
  end

end
