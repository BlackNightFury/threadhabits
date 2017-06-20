class NotificationsMailer < ActionMailer::Base
  include Roadie::Rails::Automatic
  default from: "Threadhabits <#{Threadhabits::Application.config.default_email}>"
  layout 'mailer'

  def messages_alert(message, listing)
    @sender = message.sender
    @receiver = message.receiver
    @body = message.body
    @message = message
    @listing = listing
    mail to: @receiver.email, subject: "New Message From #{@sender.full_name}"
  end

  def follower_alert(follower,following)
    @follower = follower
    @following = following
    mail to: @follower.email, subject: "You just got a new follower!"
  end

  def sign_up_alert(person)
    @person = person
    mail to: Rails.application.secrets.admin_email, subject: "New Sign Up"
  end

  def payment_processed(person)
    @person = person
    mail to: person.email, subject: "Thank you for purchasing"
  end
end
