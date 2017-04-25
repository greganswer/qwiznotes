class ContactForm < MailForm::Base
  include ApplicationHelper

  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message, validate: true
  attribute :nickname, captcha: true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    { subject: "#{site_name} contact form", to: site_email, from: email }
  end
end
