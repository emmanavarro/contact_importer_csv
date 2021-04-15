class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: %i[show destroy]

  def index
    @contacts = Contact.all.paginate(page: params[:page], per_page: 15)
  end

  def show; end

  def destroy
    @contact.destroy
    redirect_to contacts_url
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :birthday, :phone, :credit_card, :franchise, :email, :last_digits)
  end
end
