class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.references :dashboard
      t.string :name
      t.string :data_source
      t.string :data_method
      t.string :data_param
      t.string :refreshed_at

      t.timestamps
    end
  end
end
