class TestPlan < ActiveRecord::Base
  self.table_name = "test_plan"
  attr_accessible :owner, :plan_description, :plan_name, :test_suite_id,
   :testplan_id_pk
end
