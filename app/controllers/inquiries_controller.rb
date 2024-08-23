class InquiriesController < ApplicationController
  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      redirect_to contact_path, notice: 'Your inquiry has been submitted successfully.'
    else
      render 'home/contact', status: :unprocessable_entity
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :message)
  end
end
