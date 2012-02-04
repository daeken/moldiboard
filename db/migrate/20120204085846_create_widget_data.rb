class CreateWidgetData < ActiveRecord::Migration
  def change
    create_table :widget_data do |t|
      t.references :widget
      t.text :value

      t.timestamps
    end
  end
end
