class Members::IdeasController < ApplicationController

  def top
  end

  def about
  end

  def new
    @idea = Idea.new
  end

  def index
    if params[:tag_name]
      @ideas = Idea.tagged_with("#{params[:tag_name]}").where(is_adopted: true).order(created_at: :desc)
    else
      @ideas = Idea.where(is_adopted: true).order(created_at: :desc)
    end
    # @genre = Genre.find_by(created_at: params[:genre_id])
  end

  def genre_index
    @ideas = Idea.where("genre_id = ?",params[:genre_id])#クエリパラメータの値を受け取っている,/genle?genre_id=3←トップのリンクで指定した
    @all_ranks = Idea.find(Favorite.group(:idea_id).order("count(idea_id) desc").limit(3).pluck(:idea_id))
    @genre_ranks = @all_ranks.select{ |idea| idea.genre_id == Idea.where("genre_id = ?",params[:genre_id])}
  end


  def show
    @idea = Idea.find(params[:id])
    @idea_comment = IdeaComment.new
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
    redirect_back(fallback_location: root_path)
  end

  private

  def idea_params
    params.require(:idea).permit(:title,:image,:caption,:member_id,:genre_id,:tag_list)#_idがいるかどうか見ておく
  end

end

#params:{XXXXXX}
#params: {idea:{title:"XXXX", image: "XXXX", ........} }
#params[:idea] => {title:"XXXX", image: "XXXX", ........}
#params[:idea][:title] => xxxx
#user = User.find(params[:id])
