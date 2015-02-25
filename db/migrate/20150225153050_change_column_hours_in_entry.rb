class ChangeColumnHoursInEntry < ActiveRecord::Migration
  def change
  	change_column :entries, :hours,  :decimal
  end
end
