class CreateTestPlanExecuteds < ActiveRecord::Migration
  def change
    create_table :test_plan_executeds do |t|
      t.integer :testPlan_executed_id
      t.string :windows_host
      t.string :browser
      t.string :environment
      t.string :release
      t.date :starttime
      t.date :endtime
      t.string :totaltime
      t.integer :test_suite_id
      t.integer :test_plan_id
      t.integer :test_suite_executed_id

      t.timestamps
    end
  end
end
