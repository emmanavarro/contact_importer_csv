class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
  end

  def show; end

  def destroy
    @contact.destroy
    redirect_to contacts_url
  end

  def import
    require 'csv'
    Contact.import(params[:file], current_user)
    redirect_to contacts_url, notice: 'Contacts were successfully imported.'
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :birthday, :phone, :credit_card, :franchise, :email)
  end
end
