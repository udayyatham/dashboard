class TestPlanExecuted < ActiveRecord::Base
  self.table_name = "test_plan_executed"
  attr_accessible :browser, :endtime, :environment, :release, :starttime,
   :testplan_executed_id, :test_plan_id, :test_suite_executed_id,
   :test_suite_id, :totaltime, :windows_host
end