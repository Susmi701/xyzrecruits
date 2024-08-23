class ApplicationController < ActionController::Base
  before_action :set_contact_details
  before_action :set_page_details
  def set_contact_details
    @contact = Contact.first 
  end
  def set_page_details
    @pagecontent = PageContent.first
  end
end
