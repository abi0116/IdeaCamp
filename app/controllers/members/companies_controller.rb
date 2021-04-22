class Members::CompaniesController < ApplicationController

  before_action :authenticate_member!

  def new
    @company = Company.new#既にenumでデフォルトがあるため、newではない?→必要
    @member = current_member
  end

  def create
    unless current_member.company.present?#同じメンバーが複数申請できてしまうと、複数申請データが増えて無駄なのでここで条件分けする
      @company = Company.new(member_id: current_member.id, status: Company.statuses[:application])#statusに入れる内容の書き方はenum特有の書き方(ここの複数形に注意)。今回は変更で変わる値とその結果が指定さえているのでparamsのストロングパラメーターはいらない
      @company.save
      redirect_to root_path,notice: "企業申請が完了しました。受理されるまでお待ちください。"
    else
      flash.now[:alert] = "すでに企業申請が完了しております。お手数ですが、再度申請を行う場合は管理者に連絡をお願いいたします"
      render root_path#エラー画面を作ってそっちに遷移させる
    end
  end


end
