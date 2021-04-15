class ImportFilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @import_file = ImportFile.new
  end

  def new
    @import_file = ImportFile.new
  end

  def create
    ImportFile.import(params[:file], current_user)
    @import_file = current_user.import_files.build(filename: params[:file].original_filename)
    @import_file.save
    redirect_to contacts_path, notice: 'Contacts were successfully imported'
  end
end
