class TestSuiteExecuted < ActiveRecord::Base
  self.table_name = "test_suite_executed"
  attr_accessible :browser, :build_number, :build_paramL, :endtime,
   :environment, :executedBranch, :jenkins_id, :release, :servername, 
   :starttime, :test_suite_id, :testsuite_executed_id, :totaltime
end
