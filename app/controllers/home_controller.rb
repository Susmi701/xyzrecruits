class HomeController < ApplicationController
  def index
    @jobs = Job.active.order(created_at: :desc).limit(3)
  end
  def about
  end

  def contact
    @contact=Contact.first
    @inquiry = Inquiry.new
  end
 
end
