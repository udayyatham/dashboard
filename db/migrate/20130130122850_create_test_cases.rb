class CreateTestCases < ActiveRecord::Migration
  def change
    create_table :test_cases do |t|
      t.integer :testCase_id_pk
      t.integer :case_no
      t.string :owner
      t.text :case_description
      t.integer :test_suite_id
      t.integer :test_plan_id

      t.timestamps
    end
  end
end
