class AddTypeToWidgets < ActiveRecord::Migration
  def change
    add_column :widgets, :type, :string
  end
end
