class CreateDashboards < ActiveRecord::Migration
  def change
    create_table :dashboards do |t|
      t.string  :name
      t.boolean :protected

      t.timestamps
    end
  end
end
