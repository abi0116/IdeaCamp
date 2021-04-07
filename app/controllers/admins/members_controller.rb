class Admins::MembersController < ApplicationController

  def index
    @members = Member.all
  end

end
