class Admin::InquiriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @inquiries = Inquiry.paginate(page: params[:page], per_page: 10)
  end
end
