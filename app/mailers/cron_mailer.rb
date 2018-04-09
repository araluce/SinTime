class CronMailer < ActionMailer::Base
  default from: 'noreply@sintime.es'
  layout 'no_reply_mail'
end
