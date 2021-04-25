class Members::IdeasController < ApplicationController

  before_action :authenticate_member!,except: [:top,:about,:index,:show]

  def top
    @ideas = Idea.all
    @tags = @ideas.tag_counts_on(:tags) #投稿に紐づくタグの取得
    @genres = Genre.all
  end

  def about
  end

  def new
    @idea = Idea.new
  end

  def index
    if current_member.present? && current_member.is_company == false#一般メンバー用
      if params[:tag_name]
        @ideas = Idea.tagged_with("#{params[:tag_name]}").where(adopted_status: "採用済み(完了済み)").page(params[:page]).per(5).order(created_at: :desc)#採用されている投稿のみ表示
      else
        @ideas = Idea.where(adopted_status: "採用済み(完了済み)").page(params[:page]).per(5).order(created_at: :desc)#採用されている投稿のみ表示
      end
    elsif current_member.present? && current_member.is_company == true#企業メンバー用
      if params[:tag_name]
        @ideas = Idea.tagged_with("#{params[:tag_name]}").page(params[:page]).per(5).order(created_at: :desc)#すべての投稿を表示
      else
        @ideas = Idea.page(params[:page]).per(5).order(created_at: :desc)#すべての投稿を表示
      end
    else
      if params[:tag_name]
        @ideas = Idea.tagged_with("#{params[:tag_name]}").where(adopted_status: "採用済み(完了済み)").page(params[:page]).per(5).order(created_at: :desc)#採用されている投稿のみ表示
      else
        @ideas = Idea.where(adopted_status: "採用済み(完了済み)").page(params[:page]).per(5).order(created_at: :desc)#採用されている投稿のみ表示
      end
    end
    @tags = @ideas.tag_counts_on(:tags) #投稿に紐づくタグの取得
    # @genre = Genre.find_by(created_at: params[:genre_id])
  end

  def genre_index
    @ideas = Idea.where("genre_id = ?",params[:genre_id]).where(adopted_status: "採用済み(完了済み)").page(params[:page]).per(5).order(created_at: :desc)#クエリパラメータの値を受け取っている,/genle?genre_id=3←トップのリンクで指定した
    @idea = Idea.where("genre_id = ?",params[:genre_id]).find_by(adopted_status: "採用済み(完了済み)")
    @genre_name = Genre.find(params[:genre_id]).name#genle_idはideaのカラムだが、そもそもそれれはGenreのidでもあるので、このようにして引っ張ってこれる
    @all_ranks = Idea.find(Favorite.group(:idea_id).order("count(idea_id) desc").limit(3).pluck(:idea_id))#全体のランキング
    if @idea.present?#ジャンルごとに開発完了済みのアイディアが存在するならば以下のコードでランキング表示
      @genre_rankss = @all_ranks.select{ |idea| idea.genre_id == @idea.genre_id}#ジャンルごとのランキング
      @genre_ranks = @genre_rankss.select{ |idea| idea.adopted_status == "採用済み(完了済み)"}#ジャンル(すてーたたすが完了済み限定)のランキング
    end
  end
#"genre_id = ?",params[:genre_id]

  def show
    @idea = Idea.find(params[:id])
    @idea_comment = IdeaComment.new
  end

  def create
    #byebug
    @idea = Idea.new(idea_params)
    @idea.member_id = current_member.id
    #byebug
    unless current_member.is_company == true
      if @idea.save
        redirect_to idea_path(@idea.id),notice: "アイディアの投稿ができました！"
      else
        flash.now[:alert] = "必須項目の入力をお願いします"
        render :new
      end
    else
      redirect_to root_path
    end
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
    redirect_to member_path(@idea.member.id)
  end

  def get_tag_search
    @tags = Idea.tag_counts_on(:tags).where('name LIKE(?)', "%#{params[:key]}%")
  end

  def status_update
    @idea = Idea.find(params[:idea_id])
    before_idea_status = @idea.adopted_status_before_type_cast#下で行う条件式の準備、ステータス変更前のenumの値だけを非難させている
    @idea.adopted_status = params[:idea][:adopted_status] #採用ボタンを押したら採用済み(企画中)にステータス変更,セレクトで更新ボタンを押したたらステータス変更の両方を担っている。
    @idea.adopted_by_id = current_member.id
    @idea.save
    after_idea_status = Idea.adopted_statuses[params[:idea][:adopted_status]]#下で行う条件式の準備、ステータス変更後のenumの値だけを非難させている
    message = case after_idea_status - before_idea_status #ステータス変更後と変更前の値の引き算(非難した値を使っている)
    when -1,-10,-100 then
      "採用を辞めました"
    when 0 then
      "ステータスの変更は行われませんでした"
    when 1 then
      "このアイディアの採用を開始しました。利用規約に沿った開発をお願いいたします"
    when 9 then
      "この採用を一時的に停止しました"
    when 90,99 then
      "このアイディアの開発完了報告ありがとうございます。お疲れさまでした"
    when -9 then
      "この停止中のアイディアを再開しました"
    when -99,-90 then
      "このアイディアへのステータスが変更されました。今一度操作が正しいか確認をお願いいたします。"
    end
    redirect_to idea_path(@idea.id),notice: message
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
