class Members::CompaniesController < ApplicationController

  def new
    @company = Company.new#既にenumでデフォルトがあるため、newではない?
  end

  def create
    unless current_member.company.present?#同じメンバーが複数申請できてしまうと、複数申請データが増えて無駄なのでここで条件分けする
      @company = Company.new(member_id: current_member.id, status: Company.statuses[:application])#statusに入れる内容の書き方はenum特有の書き方(ここの複数形に注意)。今回は変更で変わる値とその結果が指定さえているのでparamsのストロングパラメーターはいらない
      @company.save!
      redirect_to root_path#申請確認画面へ移行させる
    else
      render root_path#エラー画面を作ってそっちに遷移させる
    end
  end


end
