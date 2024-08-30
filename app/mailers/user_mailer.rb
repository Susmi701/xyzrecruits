class UserMailer < ApplicationMailer
  
  def shortlisted_email(application)
    @application = application
    mail(to: @application.email, subject: 'Your Application has been Shortlisted ')
  end
  
  def application_received(application)
    @application = application
    mail(to: @application.email, subject: 'Your application has been received')
  end
  
end
