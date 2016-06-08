class ApplicationMailer < ActionMailer::Base
  default from: "no_reply@traits.org"
  layout 'mailer'
end
