class Admin::ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_contact, only: [:edit, :update]

  def edit
    @contact = Contact.first 
  end

  def update
    if @contact.update(contact_params)
      flash[:notice] = "Contact was successfully updated."
      redirect_to edit_admin_contacts_path(@contact)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_contact
    @contact = Contact.first 
  end

  def contact_params
    params.require(:contact).permit(:address, :phone, :email, :website)
  end
  def authorize_admin
    redirect_to(root_path, alert: "Access denied.") unless current_user&.admin?
  end
end
