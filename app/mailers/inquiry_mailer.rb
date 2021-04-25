class InquiryMailer < ApplicationMailer

  def send_mail(inquiry)
    @inquiry = inquiry
    mail(
      from: ENV['user_name'],#メールを送るにはパスワードが必要なので、fromは自分でないといけない
      to:   ENV['user_name'],
      cc: inquiry.email,#ccでメールを送った本人と管理者に同様のメールを送信する(currentが使えない)
      subject: 'お問い合わせ通知'
    )
  end

end
