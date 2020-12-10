class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def user_created_email
    @email = params[:email]
    mail(
      from: Rails.application.credentials.google[:email],
      to: @email.to,
      subject: @email.subject
    )
  end
end
