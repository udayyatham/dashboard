class TestCaseExecuted < ActiveRecord::Base
  self.table_name = "test_case_executed"
  attr_accessible :cobrand, :endtime, :failed_reason, :failed_screenshot, 
    :failed_url, :result, :starttime, :testCase_executed_id,:test_case_id,
    :test_plan_executed_id, :test_plan_id,
    :test_suite_executed_id, :test_suite_id, :totaltime
end
