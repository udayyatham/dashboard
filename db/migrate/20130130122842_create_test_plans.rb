class CreateTestPlans < ActiveRecord::Migration
  def change
    create_table :test_plans do |t|
      t.integer :testplan_id_pk
      t.string :plan_name
      t.string :owner
      t.text :plan_description
      t.integer :test_suite_id

      t.timestamps
    end
  end
end
