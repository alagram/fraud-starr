class AppMailer < ActionMailer::Base
  def send_password(user)
    @user = user
    mail to: user.email, from: "info@fraudstarr.com", subject: "Please reset your password."
  end
end