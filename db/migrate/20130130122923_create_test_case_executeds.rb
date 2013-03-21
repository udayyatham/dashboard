class CreateTestCaseExecuteds < ActiveRecord::Migration
  def change
    create_table :test_case_executeds do |t|
      t.integer :testCase_executed_id
      t.string :cobrand
      t.string :result
      t.text :failed_reason
      t.text :failed_url
      t.text :failed_screenshot
      t.date :starttime
      t.date :endtime
      t.string :totaltime
      t.integer :test_suite_id
      t.integer :test_plan_id
      t.integer :test_case_id
      t.integer :test_suite_executed_id
      t.integer :test_plan_executed_id

      t.timestamps
    end
  end
end
