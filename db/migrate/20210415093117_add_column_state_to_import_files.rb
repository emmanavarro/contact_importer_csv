class AddColumnStateToImportFiles < ActiveRecord::Migration[6.1]
  def change
    add_column :import_files, :state, :string
  end
end
