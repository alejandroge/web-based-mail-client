class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Gmail client')
  end

  def user_created_email
    @email = params[:email]
    mail(to: @email.to, subject: @email.subject)
  end
end
