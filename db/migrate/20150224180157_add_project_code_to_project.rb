class AddProjectCodeToProject < ActiveRecord::Migration
  def change
    add_column :projects, :code, :string
  end
end
