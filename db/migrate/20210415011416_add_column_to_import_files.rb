class AddColumnToImportFiles < ActiveRecord::Migration[6.1]
  def change
    add_column :import_files, :import_errors, :string
  end
end
