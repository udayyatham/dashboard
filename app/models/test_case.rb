class TestCase < ActiveRecord::Base
  self.table_name = "test_case"
  attr_accessible :case_description, :case_no, :owner, :testCase_id_pk,
   :test_plan_id, :test_suite_id
end
