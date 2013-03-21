class CreateTestSuiteExecuteds < ActiveRecord::Migration
  def change
    create_table :test_suite_executeds do |t|
      t.integer :testsuite_executed_id
      t.string :jenkins_id
      t.string :build_number
      t.string :build_paramL
      t.string :environment
      t.string :release
      t.string :browser
      t.string :executedBranch
      t.date :starttime
      t.date :endtime
      t.date :totaltime
      t.string :servername
      t.integer :test_suite_id

      t.timestamps
    end
  end
end
