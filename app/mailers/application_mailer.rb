class ApplicationMailer < ActionMailer::Base
  default from: site_email
  layout 'mailer'
end
