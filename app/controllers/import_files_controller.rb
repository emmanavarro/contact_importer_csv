class ImportFilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @import_file = ImportFile.new
  end

  def new
    @import_file = ImportFile.new
  end

  def create
    @import_file = current_user.import_files.build(filename: params[:file].original_filename)
    @import_file.save
    @import_file.import(params[:file], current_user)
    redirect_to contacts_path, notice: 'Contacts were successfully imported'
  end
end
