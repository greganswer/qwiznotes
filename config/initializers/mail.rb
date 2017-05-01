ActionMailer::Base.smtp_settings = {
  address: "smtp.mailgun.org",
  authentication: :plain,
  domain: "qwiznotes.com",
  enable_starttls_auto: true,
  password: Rails.application.secrets.mailgun_password,
  port: 587,
  user_name: "postmaster@qwiznotes.com",
}
