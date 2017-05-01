class ApplicationMailer < ActionMailer::Base
  include ApplicationHelper

  default from: %{"#{site_name}" <#{site_email}>}
  layout 'mailer'
end
