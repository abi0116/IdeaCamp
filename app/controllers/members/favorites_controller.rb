class Members::FavoritesController < ApplicationController

  before_action :authenticate_member!

  def create
    @idea = Idea.find(params[:idea_id])
    favorite = current_member.favorites.new(idea_id: @idea.id)
    favorite.save
    # Idea.create_notification_like!(current_member)
    # redirect_back(fallback_location: root_path)非同期通信なのでjsファイルを呼んでもらうために消去
  end

  def destroy
    @idea = Idea.find(params[:idea_id])
    favorite = current_member.favorites.find_by(idea_id: @idea.id)
    favorite.destroy
    # redirect_back(fallback_location: root_path)非同期通信なのでjsファイルを呼んでもらうために消去
  end

end
