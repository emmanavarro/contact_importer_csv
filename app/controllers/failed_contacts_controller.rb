class FailedContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @failed_contacts = FailedContact.all.paginate(page: params[:page], per_page: 15)
  end
end
