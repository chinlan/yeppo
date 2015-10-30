class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.notify_comment.subject
  #
  def notify_comment( params )
    @greeting = "Hi"
    @contact = params
    
    mail to: "tprupx0@gmail.com"
  end
end
