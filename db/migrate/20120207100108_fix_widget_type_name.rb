class FixWidgetTypeName < ActiveRecord::Migration
  def up
  	rename_column :widgets, :type, :data_type
  end

  def down
  	rename_column :widgets, :data_type, :type
  end
end
