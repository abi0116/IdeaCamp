class Admins::IdeasController < ApplicationController

  before_action :authenticate_admin!

  def index
    @ideas = Idea.all
  end

end
