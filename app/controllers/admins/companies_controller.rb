class Admins::CompaniesController < ApplicationController

  before_action :authenticate_admin!

  def index
    @members = Member.joins(:company).where("companies.status = 1")#申請中のmemberのみ表示、memberを複数呼びたいためこの条件が難しい。テーブル結合後(joinでmembersテーブルとcompaniesテーブル)にwhereで検索を行っている。SQLの書き方なのでwhereの中身はステータスがどんな値で保存されているかをもとに引っ張て来る(今回はenumなので1で持ってきている)
    @company = Company.find_by(member_id: params[:id] )
  end

  def update
    company = Company.find_by(member_id: params[:id] )#いつものfindメソッドでok
    if params[:status] == "acceptance"#パラメーターを見て受け取れそうな形に持っていく
      member = company.member
      member.is_company = true
      company.status = 2#updateの1文目でmemberとの紐づけは完了しているので、company.statusとしても他ののcompany.statusが変わってしまうことはない
      company.save
      member.save
      redirect_to admins_complete_path
    else
      company.status = 3
      company.save
      redirect_to admins_complete_path
    end
  end

  def complete
  end

end
