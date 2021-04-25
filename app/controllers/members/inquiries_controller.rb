class Members::InquiriesController < ApplicationController

  before_action :authenticate_member!

  def index
    # 入力画面を表示
    @inquiry = Inquiry.new
    @inquiry.name = current_member.last_name + current_member.first_name
    @inquiry.email = current_member.email
  end

  def confirm
    # 入力値のチェック
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
    @inquiry.name = current_member.last_name + current_member.first_name
    @inquiry.email = current_member.email
    if @inquiry.valid?
      # OK。確認画面を表示
      render :action => 'confirm'
    else
      # NG。入力画面を再表示
      render :action => 'index'
    end
  end

  def thanks
    # メール送信
    @inquiry = Inquiry.create(params[:inquiry].permit(:name, :email, :message))#セーブも行いたいのでcreateに変更
    InquiryMailer.send_mail(@inquiry).deliver
  end

end
