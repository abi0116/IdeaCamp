class IdeasController < ApplicationController

  def top
  end

  def about
  end

  def new
    @idea = Idea.new
  end

  def index
    @ideas = Idea.all
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.member_id = current_member.id
    @idea.save
    redirect_to idea_path(@idea.id)
  end

  def edit
    @idea = Idea.find(params[:id])
    if current_member != @idea.member
      redirect_to root_path
    end
  end

  def update
    @idea = Idea.find(params[:id])
    if @idea.update(idea_params)
      redirect_to idea_path(@idea.id),notice: "アイディア編集できました！"
    else
      flash.now[:alert] = "必須項目の入力をお願いします"
      render :edit
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    redirect_to root_path
  end

  private

  def idea_params
    params.require(:idea).permit(:title,:image,:caption,:member_id)#_idがいるかどうか見ておく
  end

end
